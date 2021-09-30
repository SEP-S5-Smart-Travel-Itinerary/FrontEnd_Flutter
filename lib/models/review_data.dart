class ReviewDataInit {
  String title;
  String description;
  

  ReviewDataInit(
      {required this.title,
      required this.description,
      });

  factory ReviewDataInit.fromJson(Map<String, dynamic> json) {
    return ReviewDataInit(
        title: json['title'],
        description: json['description']);
        
  }
}
