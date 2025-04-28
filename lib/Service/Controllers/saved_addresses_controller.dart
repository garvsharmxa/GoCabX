import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedAddressesController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  var selectedMarker = Rxn<Marker>();
  var suggestions = <dynamic>[].obs;
  var currentLocation = LatLng(0, 0).obs;
  var selectedAddress = "Fetching address...".obs;
  var isLoading = false.obs;
  TextEditingController searchController = TextEditingController();

  // Store your API key securely (Use environment variables if possible)
  static const String googleApiKey = "AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM";

  @override
  void onInit() {
    super.onInit();
    loadSavedLocation();
    useCurrentLocation();
  }

  /// **Set a marker at the given position**
  void setMarker(LatLng position) {
    selectedMarker.value = Marker(
      markerId: const MarkerId("selected_location"),
      position: position,
      draggable: true,
      onDragEnd: (newPosition) {
        updateLocation(newPosition);
      },
    );
  }

  /// **Fetch and update the user's current location**
  Future<void> useCurrentLocation() async {
    isLoading.value = true;
    try {
      Location location = Location();
      var userLocation = await location.getLocation();
      LatLng newLocation = LatLng(userLocation.latitude!, userLocation.longitude!);

      updateLocation(newLocation);
    } catch (e) {
      print("Error getting current location: $e");
    }
    isLoading.value = false;
  }

  /// **Update location, marker, and address**
  Future<void> updateLocation(LatLng position) async {
    currentLocation.value = position;
    setMarker(position);
    await getAddressFromLatLng(position);
    await saveLocation(position);

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  /// **Convert LatLng coordinates to an address string**
  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        geo.Placemark place = placemarks.first;
        selectedAddress.value = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }
    } catch (e) {
      print("Error getting address: $e");
      selectedAddress.value = "Unable to fetch address";
    }
  }

  /// **Save location along with title, address, and phone number**
  Future<void> saveLocationWithDetails(String title, String address, String phoneNumber) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_title', title);
      await prefs.setString('saved_address', address);
      await prefs.setString('saved_phone', phoneNumber);

      Get.snackbar(
        "Location Saved",
        "Your location has been saved successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print("Error saving location details: $e");
      Get.snackbar(
        "Error",
        "Failed to save location details.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  /// **Fetch place suggestions based on user input**
  Future<void> fetchSuggestions(String input) async {
    if (input.isEmpty) {
      suggestions.clear();
      return;
    }
    final String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey&components=country:in";

    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);
      if (jsonData["status"] == "OK") {
        suggestions.value = jsonData["predictions"];
      } else {
        suggestions.clear();
      }
    } catch (e) {
      print("Error fetching place suggestions: $e");
      suggestions.clear();
    }
  }

  /// **Load saved location from shared preferences**
  Future<void> loadSavedLocation() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double? lat = prefs.getDouble('latitude');
      double? lng = prefs.getDouble('longitude');
      if (lat != null && lng != null) {
        LatLng savedLocation = LatLng(lat, lng);
        updateLocation(savedLocation);
      }
    } catch (e) {
      print("Error loading saved location: $e");
    }
  }

  /// **Save the user's selected location**
  Future<void> saveLocation(LatLng position) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude', position.latitude);
      await prefs.setDouble('longitude', position.longitude);
    } catch (e) {
      print("Error saving location: $e");
    }
  }

  /// **Select a location from search suggestions**
  Future<void> selectLocation(String placeId) async {
    final String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";

    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);

      if (jsonData["status"] == "OK") {
        double lat = jsonData["result"]["geometry"]["location"]["lat"];
        double lng = jsonData["result"]["geometry"]["location"]["lng"];
        LatLng newLocation = LatLng(lat, lng);

        updateLocation(newLocation);
        suggestions.clear();
      }
    } catch (e) {
      print("Error selecting location: $e");
    }
  }

  /// **Confirm selected location and notify the user**
  void confirmLocation() {
    if (selectedAddress.value.isNotEmpty && selectedMarker.value != null) {
      Get.snackbar(
        "Location Confirmed",
        "Your delivery location has been set to: ${selectedAddress.value}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Optionally navigate back after confirming
      // Get.back();
    } else {
      Get.snackbar(
        "Error",
        "Please select a valid location before confirming.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
