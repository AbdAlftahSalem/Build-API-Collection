class FoldersFilesPaths {
  //  *******  app files and folders path  *******

  // create singleton for FolderPaths
  static final FoldersFilesPaths instance = FoldersFilesPaths._internal();

  factory FoldersFilesPaths() => instance;

  FoldersFilesPaths._internal();

  String routesFolderPath = 'lib/src/routes/';
  String indexRoutePath = 'lib/src/routes/index.js';

  String fileInRoutes(String name) => '$routesFolderPath/$name';

}
