class Gym {
  final String name;
  final String address;
  final double lat;
  final double lng; 

  Gym({this.name, this.address, this.lat, this.lng});

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      name: json['name'],
      address: json['vicinity'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
    );
  }
}