class LocationModel {
  final String name;
  final String? comment;
  final double latY;
  final double longx;
  final String region;
  final String featureClass;

  LocationModel({
    required this.name,
    this.comment,
    required this.latY,
    required this.longx,
    required this.region,
    required this.featureClass,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      comment: json['comment'],
      latY: json['lat_y'],
      longx: json['long_x'],
      region: json['region'],
      featureClass: json['featureclass'],
    );
  }
}
