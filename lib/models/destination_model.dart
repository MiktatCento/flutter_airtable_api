import 'package:flutter_api_project/models/activity_model.dart';

class Destination {
  String city;
  List activities;
  String country;
  String imageUrl;
  String description;

  Destination({
    this.city,
    this.activities,
    this.country,
    this.imageUrl,
    this.description,
  });

  Destination.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    activities = json['activities'];
    country = json['country'];
    imageUrl = json['imageUrl'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['activities'] = this.activities;
    data['country'] = this.country;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    return data;
  }
}
