class PlanDataInit {
  final String? name;
  final String? budget;
  final DateTime? startDate;
  final DateTime? endDate;
  PlanDataInit({this.name, this.budget, this.startDate, this.endDate});

  factory PlanDataInit.fromJson(Map<String, dynamic> json) {
    return PlanDataInit(
        name: json['Name'],
        budget: json['initialBud'],
        startDate: json['startDate'],
        endDate: json['endDate']);
  }
}
