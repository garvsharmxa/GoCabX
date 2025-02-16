import 'dart:async';
import 'dart:convert';
import 'package:buzzcab/featuresRider/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../featuresDriver/home/widgets/nextScreenButton.dart';

class RideOngoingScreen extends StatefulWidget {
  final LatLng LocationA;
  final LatLng LocationB;
  const RideOngoingScreen({super.key, required this.LocationA, required this.LocationB});

  @override
  State<RideOngoingScreen> createState() => _RideOngoingScreenState();
}

class _RideOngoingScreenState extends State<RideOngoingScreen> {
  final Completer<GoogleMapController> _mapController = Completer();

  List<LatLng> _routeCoordinates = [];
  int _currentIndex = 0;
  Timer? _trackingTimer;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  final String googleApiKey = "AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM";
  late LatLng locationA;
  late LatLng locationB;

  @override
  void initState() {
    super.initState();
    locationA = widget.LocationA;
    locationB = widget.LocationB;
    _fetchRoute();
  }


  Future<void> _fetchRoute() async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${locationA.latitude},${locationA.longitude}&destination=${locationB.latitude},${locationB.longitude}&key=$googleApiKey&mode=driving";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["routes"].isNotEmpty) {
        final points = data["routes"][0]["overview_polyline"]["points"];
        _routeCoordinates = _decodePolyline(points);
        _initializeMap();
      }
    } else {
      print("Error fetching route: ${response.body}");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += deltaLng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  Future<void> _initializeMap() async {
    _markers = {
      Marker(
          markerId: const MarkerId("A"),
          position: locationA,
          infoWindow: const InfoWindow(title: "Pickup Location")),
      Marker(
          markerId: const MarkerId("B"),
          position: locationB,
          infoWindow: const InfoWindow(title: "Drop Location")),
    };

    _polylines = {
      Polyline(
        polylineId: const PolylineId("route_border"),
        points: _routeCoordinates,
        color: const Color(0xffCBCAE2),
        width: 9, // Slightly larger than the main polyline
        jointType: JointType.round,
      ),

      // Inner main blue polyline
      Polyline(
        polylineId: const PolylineId("route"),
        points: _routeCoordinates,
        color: const Color(0xff211F96), // Main polyline color
        width: 5, // Slightly smaller than the border
        jointType: JointType.round,
      ),
    };

    setState(() {});
    _startTracking();
  }

  void _startTracking() {
    _trackingTimer =
        Timer.periodic(const Duration(seconds: 3), (Timer timer) async {
      if (_currentIndex < _routeCoordinates.length - 1) {
        _currentIndex++;

        LatLng newPosition = _routeCoordinates[_currentIndex];

        setState(() {
          _markers.removeWhere(
              (marker) => marker.markerId == const MarkerId("current"));
          _markers.add(
            Marker(
              markerId: const MarkerId("current"),
              position: newPosition,
              infoWindow: const InfoWindow(title: "Your Location"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
            ),
          );
        });

        final GoogleMapController controller = await _mapController.future;
        controller.animateCamera(CameraUpdate.newLatLng(newPosition));
      } else {
        _trackingTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _trackingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: textColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Ride is almost done.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor),
              ),
              const SizedBox(height: 8),
              RichText(
                maxLines: 2,
                text: TextSpan(
                  style: TextStyle(
                      color: textColor, fontSize: 16), // Default style
                  children: [
                    const TextSpan(text: "You're on your way to "),
                    const TextSpan(
                      text: "Chandigarh University.",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      if (!_mapController.isCompleted) {
                        _mapController.complete(controller);
                      }
                    },
                    initialCameraPosition:
                        CameraPosition(target: locationA, zoom: 14),
                    markers: _markers,
                    polylines: _polylines,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                              'assets/images/content/IMG_5195.png'), // Update image
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Garv Sharma",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoTile(Icons.directions_car, "Hyundai i10"),
                        _infoTile(Icons.credit_card, "MH 12 AB 3456"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoTile(Icons.star, "4.8"),
                        _infoTile(Icons.diamond, "300 Rides Done"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: size.height * 0.36,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal[50], // Light background color
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pickup & Drop-off Details
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // Pickup Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Center(
                                        child: Icon(Icons.location_on,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text("Pickup Location",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Cannaught Palace, 123 abc Mall, New Delhi, 012345",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              height: size.height * 0.1,
                              width: 1.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          // Drop-off Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: isDarkMode
                                                ? [
                                                    const Color(0xFF211F96),
                                                    const Color(0xFF211F96)
                                                  ]
                                                : [
                                                    const Color(0xFF211F96),
                                                    const Color(0xFF211F96)
                                                  ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Center(
                                        child: Icon(Icons.location_on,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text("Drop-off",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Chandni Chowk, New Delhi, 054321",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // OTP Section
                    const Text(
                      "Your OTP for Ride",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: Text(
                            ["1", "2", "3", "9"][index], // Sample OTP
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 8),
                    Text(
                      "*Share this OTP with your driver to start the ride.",
                      style: TextStyle(fontSize: 12, color: Colors.teal[700]),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // Bottom Ride Status
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Arriving Drop Location in 10 Mins",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.directions_car,
                            color: Colors.teal, size: 32),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Nextscreenbutton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RiderNavigationMenu()));
                },
                buttonText: 'MAKE PAYMENT ₹150',
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
