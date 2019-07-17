class Gym {
  final String name;

  Gym({this.name});

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      name: json['name'],
    );
  }
}