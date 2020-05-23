class CourseDetail {
  final String imageUrl;

  CourseDetail({this.imageUrl});

  factory CourseDetail.fromJson(Map<dynamic, dynamic> data) {
    return CourseDetail(
      imageUrl: data['image_url'] ?? '',
    );
  }

  String getImageUrl() {
    return this.imageUrl;
  }
}
