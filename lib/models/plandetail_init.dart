class PlanDetailInit {
  String name;
  String place_id;

  PlanDetailInit(
      {required this.name,
      required this.place_id,});

  factory PlanDetailInit.fromJson(Map<String, dynamic> json) {
    return PlanDetailInit(
        name: json['name'],
        place_id: json['plan_id']);
  }
}
