class UserInfo {
  final int height;
  final bool isMale;

  UserInfo({this.height, this.isMale});

  factory UserInfo.fromJson(Map<String, dynamic> data) {
    return UserInfo(
      height: data['height'],
      isMale: data['isMale']
    );
  }

  Map<String, dynamic> toJson() =>
  {
    'height': height,
    'isMale': isMale,
  }; 
}