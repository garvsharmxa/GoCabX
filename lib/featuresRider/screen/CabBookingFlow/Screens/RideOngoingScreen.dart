import 'dart:async';
import 'dart:convert';
import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/featuresRider/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../featuresDriver/home/widgets/nextScreenButton.dart';

class RideOngoingScreen extends StatefulWidget {
  final LatLng LocationA;
  final LatLng LocationB;
  const RideOngoingScreen(
      {super.key, required this.LocationA, required this.LocationB});

  @override
  State<RideOngoingScreen> createState() => _RideOngoingScreenState();
}

class _RideOngoingScreenState extends State<RideOngoingScreen>
    with TickerProviderStateMixin {
  final Completer<GoogleMapController> _mapController = Completer();
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  List<LatLng> _routeCoordinates = [];
  int _currentIndex = 0;
  Timer? _trackingTimer;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  final String googleApiKey = "AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM";
  late LatLng locationA;
  late LatLng locationB;
  String pickupAddress = '';
  String dropAddress = '';

  @override
  void initState() {
    super.initState();
    locationA = widget.LocationA;
    locationB = widget.LocationB;

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );

    _fetchRoute();
    _getAddressFromLatLng();
    _slideController.forward();
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

  Future<void> _getAddressFromLatLng() async {
    final pickupUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationA.latitude},${locationA.longitude}&key=$googleApiKey";
    final dropUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationB.latitude},${locationB.longitude}&key=$googleApiKey";

    try {
      final pickupResponse = await http.get(Uri.parse(pickupUrl));
      final dropResponse = await http.get(Uri.parse(dropUrl));

      print("Pickup Response: ${pickupResponse.body}");
      print("Drop Response: ${dropResponse.body}");

      if (pickupResponse.statusCode == 200 && dropResponse.statusCode == 200) {
        final pickupData = json.decode(pickupResponse.body);
        final dropData = json.decode(dropResponse.body);

        if (pickupData["status"] == "OK" && dropData["status"] == "OK") {
          setState(() {
            pickupAddress = pickupData["results"][0]["formatted_address"];
            dropAddress = dropData["results"][0]["formatted_address"];
          });
        } else {
          print("Geocoding failed: ${pickupData["status"]}, ${dropData["status"]}");
        }
      } else {
        print("Error fetching address: HTTP error");
      }
    } catch (e) {
      print("Error: $e");
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
        color:  AppColors.primary.withOpacity(0.3),
        width: 12,
        jointType: JointType.round,
      ),
      Polyline(
        polylineId: const PolylineId("route"),
        points: _routeCoordinates,
        color:  AppColors.primary.withOpacity(0.8),
        width: 6,
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
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Gradient
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.navigation,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              "Ride in Progress",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.greenAccent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Arriving at Chandigarh University",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Map Section
              Padding(
                padding: const EdgeInsets.all(0),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    height: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
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
                        mapToolbarEnabled: false,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              // Driver Info Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.secondary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(
                                  'assets/images/content/IMG_5195.png'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Garv Sharma",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "4.8 • 300 rides",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.phone,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoChip(Icons.directions_car, "Hyundai i10",
                                isDarkMode),
                            _buildInfoChip(Icons.confirmation_number,
                                "MH 12 AB 3456", isDarkMode),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Trip Details Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Trip Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildLocationRow(
                        Icons.trip_origin,
                        "Pickup Location",
                        pickupAddress.isNotEmpty
                            ? pickupAddress
                            : "Fetching pickup location...",
                        const Color(0xff10B981),
                        isDarkMode,
                      ),
                      const SizedBox(height: 16),
                      _buildLocationRow(
                        Icons.location_on,
                        "Drop-off Location",
                        dropAddress.isNotEmpty
                            ? dropAddress
                            : "Fetching drop location...",
                        const Color(0xffF59E0B),
                        isDarkMode,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Payment Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                   color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff6C63FF).withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RiderNavigationMenu(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.payment,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "MAKE PAYMENT ₹150",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xff6C63FF),
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.black : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String title, String address,
      Color color, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
