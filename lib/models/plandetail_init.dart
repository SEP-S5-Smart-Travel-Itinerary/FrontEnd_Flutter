class PlanDetailInit {
  String name;
  String plan_id;

  PlanDetailInit(
      {required this.name,
      required this.plan_id,});

  factory PlanDetailInit.fromJson(Map<String, dynamic> json) {
    return PlanDetailInit(
        name: json['name'],
        plan_id: json['plan_id']);
  }
}
