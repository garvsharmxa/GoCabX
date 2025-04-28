import 'dart:async';
import 'dart:convert';
import 'package:buzzcab/featuresRider/screen/CabBookingFlow/Screens/RideDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../featuresDriver/home/widgets/nextScreenButton.dart';

class MapController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  final loc.Location location = loc.Location();
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropController = TextEditingController();

  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  Rx<LatLng?> pickupLocation = Rx<LatLng?>(null);
  Rx<LatLng?> dropLocation = Rx<LatLng?>(null);
  Rx<Marker?> selectedMarker = Rx<Marker?>(null);
  RxString searchingFor = "pickup".obs;
  RxList<dynamic> suggestions = <dynamic>[].obs;
  final Set<Polyline> polylines = {};
  static const String googleApiKey = "AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM";

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    try {
      final loc.LocationData locationData = await location.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        LatLng userLocation = LatLng(locationData.latitude!, locationData.longitude!);
        currentLocation.value = userLocation;
        updateMarker(userLocation, isPickup: true);
        moveCamera(userLocation);
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void fetchSuggestions(String input, String fieldType) async {
    if (input.isEmpty) {
      suggestions.clear();
      return;
    }
    searchingFor.value = fieldType;
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
      suggestions.clear();
    }
  }

  void selectSuggestion(String placeId) async {
    final String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);
      if (jsonData["status"] == "OK") {
        final location = jsonData["result"]["geometry"]["location"];
        LatLng newLocation = LatLng(location["lat"], location["lng"]);
        if (searchingFor.value == "pickup") {
          pickupController.text = jsonData["result"]["formatted_address"];
          pickupLocation.value = newLocation;
          updateMarker(newLocation, isPickup: true);
        } else {
          dropController.text = jsonData["result"]["formatted_address"];
          dropLocation.value = newLocation;
          updateMarker(newLocation, isPickup: false);
        }
        suggestions.clear();
        moveCamera(newLocation);
        if (pickupLocation.value != null && dropLocation.value != null) {
          drawRoute();
        }
      }
    } catch (e) {
      print("Error fetching location details: $e");
    }
  }

  void updateMarker(LatLng position, {required bool isPickup}) {
    selectedMarker.value = Marker(
      markerId: MarkerId(isPickup ? "pickup" : "drop"),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(isPickup ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed),
    );
  }

  Future<void> moveCamera(LatLng position) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 14));
  }

  Future<void> drawRoute() async {
    if (pickupLocation.value == null || dropLocation.value == null) return;
    final String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${pickupLocation.value!.latitude},${pickupLocation.value!.longitude}&destination=${dropLocation.value!.latitude},${dropLocation.value!.longitude}&key=$googleApiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);
      if (jsonData["status"] == "OK") {
        final points = jsonData["routes"][0]["overview_polyline"]["points"];
        List<LatLng> routeCoords = _decodePolyline(points);
        polylines.clear();
        polylines.add(Polyline(
          polylineId: PolylineId("route"),
          points: routeCoords,
          color: Colors.blue,
          width: 5,
        ));
      }
    } catch (e) {
      print("Error fetching route: $e");
    }
  }

  List<LatLng> _decodePolyline(String poly) {
    List<LatLng> polylineCoords = [];
    int index = 0, len = poly.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = poly.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = poly.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;
      polylineCoords.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polylineCoords;
  }
}
