class CurrentCityModel {
  final String ip;
  final String city;
  final String region;
  final String country;
  final double latitude;
  final double longitude;

  CurrentCityModel({
    required this.ip,
    required this.city,
    required this.region,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory CurrentCityModel.fromJson(Map<String, dynamic> json) {
    return CurrentCityModel(
      ip: json['ip'],
      city: json['city'],
      region: json['region'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
