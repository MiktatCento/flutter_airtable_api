import 'dart:convert';

import 'package:flutter_api_project/models/activity_model.dart';
import 'package:flutter_api_project/models/destination_model.dart';
import 'package:flutter_api_project/models/hotel_model.dart';
import 'package:http/http.dart' as http;

class API {
  //Get activity from airtable.com
  Future<List<Activity>> fetchActivity() async {
    final String _baseURL =
        "https://api.airtable.com/v0/appEM2uMT7ieXmvtf/ActivityModel?view=Grid%20view";
    final String _apiNo = "keyhCvEcWymnaStMI";
    Map<String, String> header = {"Authorization": "Bearer $_apiNo"};
    final response = await http.get(_baseURL, headers: header);
    if (response.statusCode == 200) {
      return (json.decode(response.body)["records"] as List)
          .map((data) => Activity.fromJson(data["fields"]))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Get activity from airtable.com with activity id
  Future<Activity> fetchActivityWithID(String id) async {
    final String _baseURL =
        "https://api.airtable.com/v0/appEM2uMT7ieXmvtf/ActivityModel/$id";
    final String _apiNo = "keyhCvEcWymnaStMI";
    Map<String, String> header = {"Authorization": "Bearer $_apiNo"};
    final response = await http.get(_baseURL, headers: header);
    if (response.statusCode == 200) {
      return Activity.fromJson(json.decode(response.body)["fields"]);
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Get hotel from airtable.com
  Future<List<Hotel>> fetchHotel() async {
    final String _baseURL =
        "https://api.airtable.com/v0/appEM2uMT7ieXmvtf/HotelModel?view=Grid%20view";
    final String _apiNo = "keyhCvEcWymnaStMI";
    Map<String, String> header = {"Authorization": "Bearer $_apiNo"};
    final response = await http.get(_baseURL, headers: header);
    if (response.statusCode == 200) {
      return (json.decode(response.body)["records"] as List)
          .map((data) => Hotel.fromJson(data["fields"]))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Get destination from airtable.com
  Future<List<Destination>> fetchDestination() async {
    final String _baseURL =
        "https://api.airtable.com/v0/appEM2uMT7ieXmvtf/DestinationModel?view=Grid%20view";
    final String _apiNo = "keyhCvEcWymnaStMI";
    Map<String, String> header = {"Authorization": "Bearer $_apiNo"};
    final response = await http.get(_baseURL, headers: header);
    if (response.statusCode == 200) {
      return (json.decode(response.body)["records"] as List)
          .map((data) => Destination.fromJson(data["fields"]))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
