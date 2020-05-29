class Goal {
  final double bmi;
  final double weight;
  final int courses;
  final double gym;
  final double steps;

  Goal({this.bmi, this.weight, this.courses, this.gym, this.steps});

  factory Goal.fromJson(Map<dynamic, dynamic> data) {
    return Goal(
      bmi: data['bmi'] + .0,
      weight: data['weight'] + .0,
      courses: data['courses'],
      gym: data['gym'] + .0,
      steps: data['steps'] ?? 10000,
    );
  }

  Map<String, Object> toDocument() => {
        'bmi': bmi,
        'weight': weight,
        'courses': courses,
        'gym': gym,
        'steps': steps,
      };

  double getBmi() {
    return this.bmi;
  }

  double getWeight() {
    return this.weight;
  }

  int getCourses() {
    return this.courses;
  }

  double getGym() {
    return this.gym;
  }

  double getSteps() {
    return this.steps;
  }
}
