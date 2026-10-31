import 'package:path/path.dart' as p;

import '../../core/model/api_collection_model.dart';
import '../../core/services/folder_and_file_service/folder_and_file_service.dart';
import '../../core/utils/string_consts.dart';

/// Writes a static web page that documents the collection.
class BuildWebVersion {
  /// Writes `thunder-output/web/` inside [outputPath]; open its `index.html`
  /// in a browser.
  static Future<void> buildWebVersion(
      ApiCollectionModel apiCollectionModel, String outputPath) async {
    String webPath = p.join(outputPath, 'thunder-output', 'web');
    await FolderAndFileService.createFolder(webPath);
    await FolderAndFileService.createFolder(p.join(webPath, 'style'));
    await FolderAndFileService.createFolder(p.join(webPath, 'js'));
    await FolderAndFileService.createFolder(
        p.join(webPath, 'assets', 'images'));

    await FolderAndFileService.createFile(
      p.join(webPath, 'index.html'),
      StringConsts.htmlContent,
    );

    await FolderAndFileService.createFile(
      p.join(webPath, 'style', 'home.css'),
      StringConsts.styleContent,
    );

    await FolderAndFileService.createFile(
      p.join(webPath, 'js', 'home.js'),
      StringConsts.homeJSContent,
    );

    await FolderAndFileService.createFile(
      p.join(webPath, 'js', 'data.js'),
      StringConsts.dataContent(apiCollectionModel),
    );

    await FolderAndFileService.createFile(
      p.join(webPath, 'assets', 'images', 'icon-arrow-down.svg'),
      '<svg width="10" height="6" xmlns="http://www.w3.org/2000/svg"><path stroke="#686868" stroke-width="1.5" fill="none" d="m1 1 4 4 4-4"/></svg>',
    );
    print("🌐 Web docs : ${p.join(webPath, 'index.html')}");
  }
}
