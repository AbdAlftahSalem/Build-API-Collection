class InfoModel {
  String collectionName;
  String baseUrl;

  InfoModel({
    required this.collectionName,
    required this.baseUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.collectionName,
      'schema':
          "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
    };
  }

  @override
  String toString() {
    return 'Info collection {collectionName: $collectionName, baseUrl: $baseUrl}';
  }
}
