import 'dart:async';
import 'dart:convert';
import 'package:buzzcab/featuresRider/screen/CabBookingFlow/Screens/RideDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
import '../../../featuresDriver/home/widgets/nextScreenButton.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final loc.Location _location = loc.Location();
  LatLng? selectedLocation;
  final TextEditingController _pickupController = TextEditingController();
  TextEditingController _dropController = TextEditingController();
  List<dynamic> _suggestions = [];
  LatLng? currentLocation; // Add this variable
  Marker? _selectedMarker;
  String _searchingFor = "pickup";
  static const String googleApiKey = "AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM";
  final Set<Polyline> _polylines = {};
  LatLng? pickupLocation;
  LatLng? dropLocation;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _selectSuggestion(String placeId) async {
    final String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);

      if (jsonData["status"] == "OK") {
        final location = jsonData["result"]["geometry"]["location"];
        LatLng newLocation = LatLng(location["lat"], location["lng"]);

        setState(() {
          if (_searchingFor == "pickup") {
            _pickupController.text = jsonData["result"]["formatted_address"];
            pickupLocation = newLocation;
            _updateMarker(newLocation, isPickup: true);
          } else {
            _dropController.text = jsonData["result"]["formatted_address"];
            dropLocation = newLocation;
            _updateMarker(newLocation, isPickup: false);
          }
          _suggestions = [];
        });

        _moveCamera(newLocation);
        if (pickupLocation != null && dropLocation != null) {
          _drawRoute();
        }
      }
    } catch (e) {
      print("Error fetching location details: $e");
    }
  }


  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    }

    loc.PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) return;
    }

    try {
      final loc.LocationData locationData = await _location.getLocation();

      if (locationData.latitude != null && locationData.longitude != null) {
        LatLng userLocation = LatLng(locationData.latitude!, locationData.longitude!);

        setState(() {
          currentLocation = userLocation; // Store the current location
          _updateMarker(userLocation, isPickup: true); // Add isPickup argument
        });

        _moveCamera(userLocation); // Move the camera to the user's location
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _fetchPickupSuggestions(String value) {
    _fetchSuggestions(value, "pickup");
  }

  void _fetchDropSuggestions(String value) {
    _fetchSuggestions(value, "drop");
  }

  Future<void> _fetchSuggestions(String input, String fieldType) async {
    if (input.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }
    setState(() {
      _searchingFor = fieldType;
    });
    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey&components=country:in";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);
      if (jsonData["status"] == "OK") {
        setState(() => _suggestions = jsonData["predictions"]);
      } else {
        setState(() => _suggestions = []);
      }
    } catch (e) {
      setState(() => _suggestions = []);
    }
  }

  void _updateMarker(LatLng position, {required bool isPickup}) {
    setState(() {
      if (isPickup) {
        pickupLocation = position;
        _selectedMarker = Marker(
          markerId: const MarkerId("pickup"),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
      } else {
        dropLocation = position;
        _selectedMarker = Marker(
          markerId: const MarkerId("drop"),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      }
    });
  }

  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 14));
  }

  Future<void> _drawRoute() async {
    if (pickupLocation == null || dropLocation == null) return;
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${pickupLocation!.latitude},${pickupLocation!.longitude}&destination=${dropLocation!.latitude},${dropLocation!.longitude}&key=$googleApiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);
      if (jsonData["status"] == "OK") {
        final points = jsonData["routes"][0]["overview_polyline"]["points"];
        List<LatLng> routeCoords = _decodePolyline(points);
        setState(() {
          _polylines.clear();
          _polylines.add(Polyline(
            polylineId: const PolylineId("route"),
            points: routeCoords,
            color: Colors.blue,
            width: 5,
          ));
        });
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

  Widget _modalBottomSheetMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10), // Pickup Location Input
          TextField(
            controller: _pickupController,
            onChanged: _fetchPickupSuggestions,
            decoration: InputDecoration(
              hintText: "Enter Pickup Location",
              prefixIcon: const Icon(Icons.location_on, color: Colors.green),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15), // Drop Location Input
          TextField(
            controller: _dropController,
            onChanged: _fetchDropSuggestions,
            decoration: InputDecoration(
              hintText: "Enter Drop Location",
              prefixIcon:
                  const Icon(Icons.location_on_outlined, color: Colors.red),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15), // Suggestions List
          if (_suggestions.isNotEmpty)
            Container(
              height: 150, // Adjusted height for better visibility
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_suggestions[index]["description"]),
                    leading: const Icon(Icons.place, color: Colors.blueAccent),
                    onTap: () =>
                        _selectSuggestion(_suggestions[index]["place_id"]),
                  );
                },
              ),
            ),
          const SizedBox(height: 10), // Confirm Ride Button
          Nextscreenbutton(
            onPressed: () {
              if (pickupLocation != null && dropLocation != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RideDetails(
                      LocationA: pickupLocation!,
                      LocationB: dropLocation!,
                    ),
                  ),
                );
              }
              else {
                // Show an error message if locations are not selected
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select both pickup and drop locations")),
                );
              }
            },
            buttonText: "Confirm Ride",
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _mapController.complete(controller);
              },
              myLocationEnabled: true,
              markers: _selectedMarker != null ? {_selectedMarker!} : {},
              polylines: _polylines,
              initialCameraPosition: CameraPosition(
                target: currentLocation ?? const LatLng(37.7749, -122.4194), // Default to San Francisco
                zoom: 12,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _modalBottomSheetMenu(),
    );
  }
}
