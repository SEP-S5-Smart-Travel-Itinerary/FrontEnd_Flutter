class BookDataInit {
  String name;
  List type;
  var rating;
  String place_id;
  var imagelink;

  BookDataInit(
      {required this.name,
      required this.type,
      this.rating,
      required this.place_id,
      this.imagelink});

  factory BookDataInit.fromJson(Map<String, dynamic> json) {
    return BookDataInit(
        name: json['name'],
        type: json['type'],
        rating: json['rating'],
        place_id: json['place_id'],
        imagelink: json['imagelink']);
  }
}
