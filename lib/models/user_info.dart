class UserInfo {
  final bool onboarded;

  UserInfo({this.onboarded});

  bool hasOnboarded() {
    return this.onboarded;
  }

  factory UserInfo.fromJson(Map<String, dynamic> data) {
    return UserInfo(
      onboarded: data['onboarded'],
    );
  }
}