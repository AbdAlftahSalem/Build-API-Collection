class FoldersFilesPaths {
  //  *******  app files and folders path  *******

  // create singleton for FolderPaths
  static final FoldersFilesPaths instance = FoldersFilesPaths._internal();

  factory FoldersFilesPaths() => instance;

  FoldersFilesPaths._internal();

  String routesFolder = 'lib/src/routes/';

  String fileInRoutes(String name) => '$routesFolder/$name';

}
