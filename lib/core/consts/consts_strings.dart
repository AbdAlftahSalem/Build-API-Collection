class ConstStrings {
  // create singleton for ConstStrings
  static final ConstStrings instance = ConstStrings._internal();

  factory ConstStrings() => instance;

  ConstStrings._internal();

  String routesTemplate(
          String endPoint, String requestType, String methodName) =>
      "router.route('${endPoint.replaceAll("{{base_url}}", "")}').${requestType.toLowerCase() == 'formdata' ? "post" : requestType.toLowerCase()}(${methodName.trim()})";

  String routeFileTemplate(
      String fileName, List<String> methods, List<String> routes) {
    return """
// setup express
const express = require("express");
const router = express.Router();

const {${methods.join(", ")}} = require("../controller/${fileName}_controller");

// setup global middlewares

// ${fileName} routs
${routes.join("\n")}

module.exports = router;    
    
""";
  }
}
