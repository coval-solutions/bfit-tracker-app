class CourseDetail {
  final String imageUrl;
  final int mins;
  final int weeks;
  final int workouts;

  CourseDetail({this.imageUrl, this.mins, this.weeks, this.workouts});

  factory CourseDetail.fromJson(Map<dynamic, dynamic> data) {
    return CourseDetail(
      imageUrl: data['image_url'] ?? '',
      mins: data['minutes'] ?? 1,
      weeks: data['weeks'] ?? 1,
      workouts: data['workouts'] ?? 11,
    );
  }

  String getImageUrl() {
    return this.imageUrl;
  }
}
