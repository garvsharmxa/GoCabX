import 'dart:async';
import 'dart:convert';
import 'package:buzzcab/featuresDriver/CabBookingFlow/Screens/RideDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? _controller;
  loc.Location _location = loc.Location();
  LatLng? selectedLocation;
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];
  Marker? _selectedMarker;

  static const String googleApiKey = "AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

    _location.getLocation().then((loc.LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        LatLng userLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        setState(() {
          selectedLocation = userLocation;
          _updateMarker(userLocation);
        });
        _moveCamera(userLocation);
      }
    });
  }

  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 16));
  }

  Future<void> _fetchSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }
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

  Future<void> _selectSuggestion(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);
      if (jsonData["status"] == "OK") {
        final location = jsonData["result"]["geometry"]["location"];
        LatLng newLocation = LatLng(location["lat"], location["lng"]);
        setState(() {
          selectedLocation = newLocation;
          _updateMarker(newLocation);
          _suggestions = [];
        });
        _moveCamera(newLocation);
      }
    } catch (e) {}
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _selectedMarker = Marker(
        markerId: MarkerId("selected"),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    });
  }

  void _confirmLocation() {
    if (selectedLocation != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>RideDetails()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Location"),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController.complete(controller);
              _controller = controller;
            },
            initialCameraPosition: CameraPosition(
              target: selectedLocation ?? LatLng(28.6139, 77.2090),
              zoom: 14,
            ),
            myLocationEnabled: true,
            onTap: (LatLng position) {
              setState(() {
                selectedLocation = position;
                _updateMarker(position);
              });
            },
            onCameraMove: (CameraPosition position) {
              setState(() {
                selectedLocation =
                    position.target; // Update marker position dynamically
              });
            },
            onCameraIdle: () {
              if (selectedLocation != null) {
                _updateMarker(
                    selectedLocation!); // Confirm marker when movement stops
              }
            },
            markers: _selectedMarker != null ? {_selectedMarker!} : {},
          ),
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search location...",
                          border: InputBorder.none,
                          enabledBorder: InputBorder
                              .none, // Ensures no border when enabled
                          focusedBorder: InputBorder
                              .none, // Ensures no border when focused
                          suffixIcon:
                              Icon(Icons.search, color: Colors.blueAccent),
                        ),
                        onChanged: _fetchSuggestions,
                      ),
                    ],
                  ),
                ),
                if (_suggestions.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 5)
                      ],
                    ),
                    child: Column(
                      children: _suggestions.map((suggestion) {
                        return ListTile(
                          title: Text(suggestion["description"]),
                          onTap: () =>
                              _selectSuggestion(suggestion["place_id"]),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.check, color: Colors.white),
        label: Text("Confirm Location"),
        onPressed: _confirmLocation,
      ),
    );
  }
}
