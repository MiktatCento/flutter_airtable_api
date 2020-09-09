class Activity {
  String imageUrl;
  String name;
  String type;
  List startTimes;
  int rating;
  int price;

  Activity({
    this.imageUrl,
    this.name,
    this.type,
    this.startTimes,
    this.rating,
    this.price,
  });

  Activity.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    name = json['name'];
    type = json['type'];
    startTimes = json['startTimes'];
    rating = json['rating'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['type'] = this.type;
    data['startTimes'] = this.startTimes;
    data['rating'] = this.rating;
    data['price'] = this.price;
    return data;
  }
}
