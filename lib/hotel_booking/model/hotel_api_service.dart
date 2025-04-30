import 'dart:convert';
import 'package:http/http.dart' as http;
import 'hotel_list_data.dart';
import 'package:flutter/services.dart'; // ✅ This is required for rootBundle


//class HotelApiService {
  //static const String apiUrl = 'assets/data/hotels.json'

 // static Future<List<HotelListData>> fetchHotels() async {
   // final response = await http.get(Uri.parse(apiUrl));
   // if (response.statusCode == 200) {
    //  List<dynamic> jsonData = json.decode(response.body);
     // return jsonData.map((hotel) => HotelListData.fromJson(hotel)).toList();
  //  } else {
     // throw Exception('Failed to load hotels');
   // }
 // }
//}

class HotelApiService {
  static const String apiPath = 'assets/data/hotels.json';

  static Future<List<HotelListData>> fetchHotels() async {
    final String response = await rootBundle.loadString(apiPath);
    final List<dynamic> jsonData = json.decode(response);
    return jsonData.map((hotel) => HotelListData.fromJson(hotel)).toList();
  }
}
