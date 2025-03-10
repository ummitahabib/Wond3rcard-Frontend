import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final sharedProvider = ChangeNotifierProvider<SharedController>((ref) {
  return SharedController(ref);
});

class SharedController extends ChangeNotifier {
  final Ref ref;

  SharedController(this.ref);

  String address = emptyString;
  LatLng selectedLocation = const LatLng(37.7749, -122.4194);
  final String googleApiKey = "AIzaSyD1AYNlL8vnySJShep7hXVy5F3U76PbyLk";

  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["status"] == "OK" && data["results"].isNotEmpty) {
          return data["results"][0]["formatted_address"];
        }
      }
    } catch (e) {
      print("Geocoding Error: $e");
    }
    return "Address not found";
  }
}
