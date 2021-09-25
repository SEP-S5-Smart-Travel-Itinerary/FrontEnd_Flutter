class PlanDataDel {
 
  String plan_id;

  PlanDataDel(
      {required this.plan_id,});

  factory PlanDataDel.fromJson(json) {
    return PlanDataDel(
        
        plan_id: json['plan_id']);
  }
}
