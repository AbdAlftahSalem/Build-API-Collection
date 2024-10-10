class InfoModel {
  String collectionName;
  String baseUrl;

  InfoModel({
     this.collectionName ="",
     this.baseUrl ="",
  });

  Map<String, dynamic> toMap() {
    return {
      'name': collectionName,
      'schema':
          "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
    };
  }

  @override
  String toString() {
    return 'Info collection {collectionName: $collectionName, baseUrl: $baseUrl}';
  }
}
