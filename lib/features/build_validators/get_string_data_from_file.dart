import '../../core/extensions/string_extensions.dart';
import '../../core/model/model_data_model.dart';

// todo : need refactor
class GetDataFromString {
  static List<ModelDataModel> getDataFromString(String content) {
    List<String> contentList = content.split("\n");
    bool addFlag = false;
    String title = "";
    List<String> options = [];
    List<ModelDataModel> modelDataModel = [];
    List<DataModel> dataModel = [];

    for (int i = 0; i < contentList.length - 1; ++i) {
      String value = contentList[i];
      value = value.trim();

      if (value.contains("timestamps")) break;

      bool printFlag = addFlag &&
          !title.endsWith("{") &&
          !title.endsWith("},") &&
          !title.endsWith("}");

      printFlag = printFlag &&
          !value.endsWith("{") &&
          !value.endsWith("},") &&
          !value.endsWith("}");

      if (printFlag) {
        // print("$title || $value");
        options.add(value);
      }

      // search in dict flag true
      if (value.endsWith("{")) {
        addFlag = true;
        title = value.split(":").first;
      }

      if (value.endsWith("}") || value.endsWith("},")) {
        addFlag = false;
        if (options.isNotEmpty) {
          dataModel = _adapterString(options);
          modelDataModel.add(ModelDataModel(
            filedName: title,
            dataModel: dataModel,
          ));
          options.clear();
        }
      }

      if (value.endsWith("[") && contentList[i + 1].trim().startsWith("{")) {
        title = contentList[i].trim().split(":").first;
        addFlag = true;
        i++;
      }
    }
    modelDataModel.forEach((element) {
      print(element.filedName);
      print(element.dataModel.first);
    });
    return modelDataModel;
  }

  // todo : need refactor code , need add default data from node.
  static List<DataModel> _adapterString(List<String> value) {
    DataModel modelDataModel = DataModel();
    List<DataModel> dataModels = [];
    value.forEach((element) {
      if (element.startsWith("type")) {
        modelDataModel.type =
            element.split(":").last.replaceAll(",", "").trim();
      } else if (element.startsWith("required")) {
        List<String> elementSplits = element.getDataFromList();
        modelDataModel.required = elementSplits.first.startsWith("true");
        modelDataModel.requiredMessage = elementSplits.last;
      } else if (element.startsWith("min")) {
        List<String> elementSplits = element.getDataFromList();
        modelDataModel.minLength = int.tryParse(elementSplits.first) ?? 0;
        modelDataModel.minLengthMessage = elementSplits.last;
      } else if (element.startsWith("max")) {
        List<String> elementSplits = element.getDataFromList();
        modelDataModel.maxLength = int.tryParse(elementSplits.first) ?? 0;
        modelDataModel.maxLengthMessage = elementSplits.last;
      } else if (element.startsWith("unique")) {
        List<String> elementSplits = element.getDataFromList();
        modelDataModel.unique = elementSplits.first.startsWith("true");
        modelDataModel.uniqueMessage = elementSplits.last;
      }
      dataModels.add(modelDataModel);
    });

    return dataModels;
  }
}
