class LocationData {
  String? name;
  List<String>? type;
  int? rating;
  String? placeId;
  List<Imagelink>? imagelink;
  double? latitude;
  double? longitude;
  int? reviews;

  LocationData(
      {this.name,
      this.type,
      this.rating,
      this.placeId,
      this.imagelink,
      this.latitude,
      this.longitude,
      this.reviews});

  LocationData.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    type = json['type'].cast<String>();
    rating = json['rating'];
    placeId = json['place_id'];
    if (json['imagelink'] != null) {
      imagelink = [];
      json['imagelink'].forEach((v) {
        imagelink!.add(new Imagelink.fromJson(v));
      });
    }
    latitude = json['latitude'];
    longitude = json['longitude'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['rating'] = this.rating;
    data['place_id'] = this.placeId;
    if (this.imagelink != null) {
      data['imagelink'] = this.imagelink!.map((v) => v.toJson()).toList();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['reviews'] = this.reviews;
    return data;
  }
}

class Imagelink {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Imagelink(
      {this.height, this.htmlAttributions, this.photoReference, this.width});

  Imagelink.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}
