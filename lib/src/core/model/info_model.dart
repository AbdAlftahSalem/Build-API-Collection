/// Collection name and base URL.
class InfoModel {
  /// Collection name (also the JSON file name).
  String collectionName;

  /// Base URL, saved as the `base_url` variable.
  String baseUrl;

  /// Creates collection info.
  InfoModel({
    this.collectionName = "",
    this.baseUrl = "",
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
