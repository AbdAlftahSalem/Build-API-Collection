import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:thunder_api/src/features/build_api_collection/print_request_data.dart';
import 'package:thunder_api/src/features/build_routes/build_route_file.dart';
import 'package:thunder_api/thunder_api.dart';

void main() {
  group('ReadRequestFromMethods.extractDataFromMethod', () {
    test('reads every annotation of a method', () {
      final requests = ReadRequestFromMethods.extractDataFromMethod([
        '// @desc Get all addresses',
        '// @route GET /api/v1/addresses',
        '// @param {"sort" : "desc"}',
        '// @header {"lang" : "en"}',
        '// @access Private (user)',
        'exports.getAddresses = asyncHandler(async (req, res) => {});',
      ]);
      expect(requests, hasLength(1));
      final r = requests.single;
      expect(r.desc, 'Get all addresses');
      expect(r.requestType, 'GET');
      expect(r.route, '/api/v1/addresses');
      expect(r.params, {'sort': 'desc'});
      expect(r.header, {'lang': 'en'});
      expect(r.access, 'privet');
      expect(r.methodNameInFile, 'getAddresses');
    });

    test('handles CRLF files, indentation, extra spaces and module.exports',
        () {
      const source = '  // @desc   Log in\r\n'
          '  // @route   POST    /auth/login\r\n'
          '  // @access  Public\r\n'
          '  module.exports.login = async (req, res) => {};\r\n';
      final requests = ReadRequestFromMethods.extractDataFromMethod(
          const LineSplitter().convert(source));
      expect(requests.single.route, '/auth/login');
      expect(requests.single.requestType, 'POST');
      expect(requests.single.access, 'public');
      expect(requests.single.methodNameInFile, 'login');
    });

    test('accepts the old "Privet" spelling', () {
      final r = ReadRequestFromMethods.getDetailsRequest(
          ['// @access Privet (user)']);
      expect(r.access, 'privet');
    });

    test('invalid JSON names the annotation', () {
      expect(
        () => ReadRequestFromMethods.getDetailsRequest(['// @param {sort}']),
        throwsA(isA<FormatException>()
            .having((e) => e.message, 'message', contains('@param'))),
      );
    });

    test('methods without annotations are skipped', () {
      final requests = ReadRequestFromMethods.extractDataFromMethod([
        'exports.helper = () => {};',
      ]);
      expect(requests, isEmpty);
    });
  });

  group('RequestsAdapter', () {
    List<FolderRequestCollectionModel> adapt(DetailRequestCode code) =>
        RequestsAdapter.requestsAdapter([
          RequestData(key: 'address', detailRequestCode: [code]),
        ]);

    test('adds query params to the URL', () {
      final url = adapt(DetailRequestCode(
        route: '/api/v1/addresses',
        requestType: 'GET',
        params: {'sort': 'desc', 'page': 1},
      )).single.detailRequests.single.requestModel.url;
      expect(url.raw, '{{base_url}}/api/v1/addresses?sort=desc&page=1');
      expect(url.path, ['api', 'v1', 'addresses']);
      expect(url.toMap()['query'], [
        {'key': 'sort', 'value': 'desc'},
        {'key': 'page', 'value': '1'},
      ]);
    });

    test('formdata routes are POST requests with form fields', () {
      final request = adapt(DetailRequestCode(
        route: '/api/v1/addresses',
        requestType: 'formdata',
        body: '{"title": "Home", "image": "home.png", '
            '"option": {"files_key": ["image"]}}',
      )).single.detailRequests.single.requestModel;
      expect(request.method, 'POST');
      final body = request.body.toMap();
      expect(body['mode'], 'formdata');
      expect(body['formdata'], [
        {'key': 'title', 'type': 'text', 'value': 'Home'},
        {'key': 'image', 'type': 'file', 'src': 'home.png'},
      ]);
    });

    test('private routes use bearer auth, public routes none', () {
      final private = adapt(DetailRequestCode(
              route: '/me', requestType: 'get', access: 'privet'))
          .single
          .detailRequests
          .single
          .requestModel;
      expect(private.method, 'GET');
      expect(private.toMap()['auth'], {
        'type': 'bearer',
        'bearer': [
          {'key': 'token', 'value': '{{token}}', 'type': 'string'}
        ],
      });

      final public = adapt(DetailRequestCode(
              route: '/login', requestType: 'POST', access: 'public'))
          .single
          .detailRequests
          .single
          .requestModel;
      expect(public.toMap().containsKey('auth'), isFalse);
    });
  });

  test('collection JSON uses Postman v2.1 keys', () {
    final map = ApiCollectionModel(
      infoCollection: InfoModel(collectionName: 'Demo'),
      variables: [VariableModel(key: 'base_url', value: 'http://localhost')],
    ).toMap();
    expect(map.keys, containsAll(['info', 'item', 'variable', 'event']));
    expect(map['variable'], [
      {'key': 'base_url', 'value': 'http://localhost'}
    ]);
  });

  group('files', () {
    late Directory temp;
    setUp(() => temp = Directory.systemTemp.createTempSync('thunder_api_'));
    tearDown(() => temp.deleteSync(recursive: true));

    test('reads a controllers folder and writes routes + collection', () async {
      final controllers = Directory(p.join(temp.path, 'controllers'))
        ..createSync();
      File(p.join(controllers.path, 'address_controller.js'))
          .writeAsStringSync('// @desc Get all\r\n'
              '// @route GET /api/v1/addresses\r\n'
              'exports.getAll = async () => {};\r\n'
              '// @desc Add\r\n'
              '// @route formdata /api/v1/addresses\r\n'
              '// @body {"title": "Home"}\r\n'
              'exports.add = async () => {};\r\n');
      File(p.join(controllers.path, 'notes.txt')).writeAsStringSync('x');

      final data =
          await ReadRequestFromMethods.getAllRequestsFromDir(controllers.path);
      expect(data.single.key, 'address');

      final collection = ApiCollectionModel(
        infoCollection: InfoModel(collectionName: 'Demo'),
        requestCollectionModel: RequestsAdapter.requestsAdapter(data),
      );

      await BuildRouteFile.buildRouteFile(collection, controllers);
      final route =
          File(p.join(temp.path, 'routes', 'address.js')).readAsStringSync();
      expect(route, contains('require("../controllers/address_controller")'));
      expect(route, contains("router.route('/api/v1/addresses').get(getAll);"));
      expect(route, contains("router.route('/api/v1/addresses').post(add);"));
      expect(route, contains('module.exports = router;'));

      await PrintAndSaveRequestData.saveJSONFile(collection, controllers.path);
      final json =
          File(p.join(controllers.path, 'thunder-output', 'Demo.json'));
      expect(json.existsSync(), isTrue);
      expect(jsonDecode(json.readAsStringSync())['info']['name'], 'Demo');
    });
  });
}
