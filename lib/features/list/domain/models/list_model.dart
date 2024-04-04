class ListItemModel {
  final String api;
  final String description;
  final String auth;
  final String cors;
  final String link;
  final String category;

  ListItemModel({
    required this.api,
    required this.description,
    required this.auth,
    required this.cors,
    required this.link,
    required this.category,
  });

  factory ListItemModel.fromJson(Map<String, dynamic> json) {
    return ListItemModel(
      api: json['API'],
      description: json['Description'],
      auth: json['Auth'],
      cors: json['Cors'],
      link: json['Link'],
      category: json['Category'],
    );
  }

  factory ListItemModel.fromDb(Map<String, dynamic> json) {
    return ListItemModel(
      api: json['api'],
      description: json['description'],
      auth: json['auth'],
      cors: json['cors'],
      link: json['link'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'API': api,
      'Description': description,
      'Auth': auth,
      'Cors': cors,
      'Link': link,
      'Category': category,
    };
  }
}
