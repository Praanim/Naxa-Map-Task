class ListItemModel {
  final String api;
  final String description;
  final String auth;
  final bool https;
  final String cors;
  final String link;
  final String category;

  ListItemModel({
    required this.api,
    required this.description,
    required this.auth,
    required this.https,
    required this.cors,
    required this.link,
    required this.category,
  });

  factory ListItemModel.fromJson(Map<String, dynamic> json) {
    return ListItemModel(
      api: json['API'],
      description: json['Description'],
      auth: json['Auth'],
      https: json['HTTPS'],
      cors: json['Cors'],
      link: json['Link'],
      category: json['Category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'API': api,
      'Description': description,
      'Auth': auth,
      'HTTPS': https,
      'Cors': cors,
      'Link': link,
      'Category': category,
    };
  }
}
