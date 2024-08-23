class InfoModel {
  String collectionName;

  InfoModel({required this.collectionName});

  Map<String, dynamic> toMap() {
    return {
      'name': this.collectionName,
      'schema': "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
    };
  }
}
