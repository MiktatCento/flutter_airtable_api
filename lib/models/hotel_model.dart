class Hotel {
  String name;
  int price;
  String imageUrl;
  String address;

  Hotel({this.name, this.price, this.imageUrl, this.address});

  Hotel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    data['address'] = this.address;
    return data;
  }
}
