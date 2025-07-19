import 'dart:async';
import 'dart:convert';
import 'package:buzzcab/common/widgets/colors/color.dart';
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

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _mapController = Completer();
  final loc.Location _location = loc.Location();
  LatLng? selectedLocation;
  final TextEditingController _pickupController = TextEditingController();
  TextEditingController _dropController = TextEditingController();
  List<dynamic> _suggestions = [];
  LatLng? currentLocation;

  Set<Marker> _markers = {};
  String _searchingFor = "pickup";
  static const String googleApiKey = "AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM";
  final Set<Polyline> _polylines = {};
  LatLng? pickupLocation;
  LatLng? dropLocation;
  bool _isLoading = false;

  String? _estimatedTime;
  String? _estimatedDistance;
  bool _isDraggingPickup = false;

  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.linear),
    );
    _pulseController.repeat(reverse: true);
    _animationController.forward();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _selectSuggestion(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";
    setState(() => _isLoading = true);

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
            _updateMarkers();
          } else {
            _dropController.text = jsonData["result"]["formatted_address"];
            dropLocation = newLocation;
            _updateMarkers();
          }
          _suggestions = [];
          _isLoading = false;
        });

        _moveCamera(newLocation);
        if (pickupLocation != null && dropLocation != null) {
          _drawRoute();
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error fetching location details: $e");
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        setState(() => _isLoading = false);
        return;
      }
    }

    loc.PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        setState(() => _isLoading = false);
        return;
      }
    }

    try {
      final loc.LocationData locationData = await _location.getLocation();

      if (locationData.latitude != null && locationData.longitude != null) {
        LatLng userLocation =
            LatLng(locationData.latitude!, locationData.longitude!);

        setState(() {
          currentLocation = userLocation;
          pickupLocation = userLocation;
          _updateMarkers();
          _isLoading = false;
        });

        _moveCamera(userLocation);

        _updatePickupAddress(userLocation);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error getting location: $e");
    }
  }

  Future<void> _updatePickupAddress(LatLng position) async {
    final address = await _getAddressFromLatLng(position);
    setState(() {
      _pickupController.text = address;
    });
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);
      if (jsonData["status"] == "OK" && jsonData["results"].isNotEmpty) {
        return jsonData["results"][0]["formatted_address"];
      }
    } catch (e) {
      print("Error getting address: $e");
    }
    return "Current Location";
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

  void _updateMarkers() {
    setState(() {
      _markers.clear();

      if (pickupLocation != null) {
        _markers.add(Marker(
          markerId: const MarkerId("pickup"),
          position: pickupLocation!,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(title: "Pickup Location"),
          draggable: true,
          onDragStart: (LatLng position) {
            setState(() {
              _isDraggingPickup = true;
            });
          },
          onDrag: (LatLng position) {
            setState(() {
              pickupLocation = position;
            });
          },
          onDragEnd: (LatLng position) async {
            setState(() {
              pickupLocation = position;
              _isDraggingPickup = false;
            });
            await _updatePickupAddress(position);
            if (dropLocation != null) {
              _drawRoute();
            }
          },
        ));
      }

      if (dropLocation != null) {
        _markers.add(Marker(
          markerId: const MarkerId("drop"),
          position: dropLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: "Drop Location"),
          draggable: false,
        ));
      }
    });
  }

  void _onMapTap(LatLng position) {
    setState(() {
      pickupLocation = position;
      _updateMarkers();
    });

    _updatePickupAddress(position);

    if (dropLocation != null) {
      _drawRoute();
    }
  }

  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 14));
  }

  Future<void> _fitMarkersInView() async {
    if (pickupLocation != null && dropLocation != null) {
      final GoogleMapController controller = await _mapController.future;

      double minLat = pickupLocation!.latitude < dropLocation!.latitude
          ? pickupLocation!.latitude
          : dropLocation!.latitude;
      double maxLat = pickupLocation!.latitude > dropLocation!.latitude
          ? pickupLocation!.latitude
          : dropLocation!.latitude;
      double minLng = pickupLocation!.longitude < dropLocation!.longitude
          ? pickupLocation!.longitude
          : dropLocation!.longitude;
      double maxLng = pickupLocation!.longitude > dropLocation!.longitude
          ? pickupLocation!.longitude
          : dropLocation!.longitude;

      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          ),
          100.0,
        ),
      );
    }
  }

  Future<void> _drawRoute() async {
    if (pickupLocation == null || dropLocation == null) return;

    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${pickupLocation!.latitude},${pickupLocation!.longitude}&destination=${dropLocation!.latitude},${dropLocation!.longitude}&key=$googleApiKey";

    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);

      if (jsonData["status"] == "OK") {
        final route = jsonData["routes"][0];
        final points = route["overview_polyline"]["points"];
        final leg = route["legs"][0];

        final duration = leg["duration"]["text"];
        final distance = leg["distance"]["text"];

        List<LatLng> routeCoords = _decodePolyline(points);

        setState(() {
          _polylines.clear();
          _polylines.add(Polyline(
            polylineId: const PolylineId("route"),
            points: routeCoords,
            color: const Color(0xFF2196F3),
            width: 6,
            patterns: [PatternItem.dash(20), PatternItem.gap(10)],
          ));

          _estimatedTime = duration;
          _estimatedDistance = distance;
        });

        _fitMarkersInView();
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

  Widget _buildLocationInput({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required Color iconColor,
    required Function(String) onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.15)
                : Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[500],
            fontSize: 16,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(Map<String, dynamic> suggestion) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.15)
                : Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () => _selectSuggestion(suggestion["place_id"]),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2196F3).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.location_on,
            color: isDark ? Colors.blue[200] : const Color(0xFF2196F3),
            size: 20,
          ),
        ),
        title: Text(
          suggestion["structured_formatting"]["main_text"] ??
              suggestion["description"],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          suggestion["structured_formatting"]["secondary_text"] ?? "",
          style: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.grey[400] : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildTravelInfo() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (_estimatedTime == null || _estimatedDistance == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.blueGrey[900] : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isDark ? Colors.blueGrey[700]! : Colors.blue[200]!,
            width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.access_time,
                  color: isDark ? Colors.blue[200] : Colors.blue[600],
                  size: 20),
              const SizedBox(height: 4),
              Text(
                _estimatedTime!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.blue[100] : Colors.blue[800],
                  fontSize: 14,
                ),
              ),
              Text(
                "Duration",
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 40,
            color: isDark ? Colors.grey[800] : Colors.grey[300],
          ),
          Column(
            children: [
              Icon(Icons.straighten,
                  color: isDark ? Colors.blue[200] : Colors.blue[600],
                  size: 20),
              const SizedBox(height: 4),
              Text(
                _estimatedDistance!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.blue[100] : Colors.blue[800],
                  fontSize: 14,
                ),
              ),
              Text(
                "Distance",
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDragInstruction() {
    return AnimatedOpacity(
      opacity: _isDraggingPickup ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Builder(
        builder: (context) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Container(
            margin: const EdgeInsets.only(top: 80),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(isDark ? 0.7 : 0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Drag to adjust pickup location",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _modalBottomSheetMenu() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _slideAnimation.value) * 100),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Where to?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tap or drag the green marker to set pickup location",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                _buildLocationInput(
                  controller: _pickupController,
                  hintText: "Pickup Location",
                  icon: Icons.my_location,
                  iconColor: const Color(0xFF4CAF50),
                  onChanged: _fetchPickupSuggestions,
                ),
                const SizedBox(height: 16),
                _buildLocationInput(
                  controller: _dropController,
                  hintText: "Where to?",
                  icon: Icons.location_on,
                  iconColor: const Color(0xFFFF5722),
                  onChanged: _fetchDropSuggestions,
                ),
                const SizedBox(height: 20),
                _buildTravelInfo(),
                if (_suggestions.isNotEmpty)
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        return _buildSuggestionItem(_suggestions[index]);
                      },
                    ),
                  ),
                if (_suggestions.isEmpty) const SizedBox(height: 0),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: pickupLocation != null && dropLocation != null
                        ? [
                            BoxShadow(
                              color: (isDark
                                      ? const Color(0xFF1565C0)
                                      : const Color(0xFF2196F3))
                                  .withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : [],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: pickupLocation != null && dropLocation != null
                          ? () {
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
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      "Please select both pickup and drop locations"),
                                  backgroundColor: AppColors.secondary,
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {},
                                    textColor: Colors.white,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.directions_car,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Confirm Ride",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _mapController.complete(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: _markers,
              polylines: _polylines,
              onTap: _onMapTap,
              style: isDark
                  ? '''
                [
                  {"elementType": "geometry","stylers": [{"color": "#242f3e"}]},
                  {"elementType": "labels.text.stroke","stylers": [{"color": "#242f3e"}]},
                  {"elementType": "labels.text.fill","stylers": [{"color": "#746855"}]},
                  {"featureType": "administrative.locality","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},
                  {"featureType": "poi","elementType": "labels","stylers": [{"visibility": "off"}]},
                  {"featureType": "poi.park","elementType": "geometry","stylers": [{"color": "#263c3f"}]},
                  {"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#6b9a76"}]},
                  {"featureType": "road","elementType": "geometry","stylers": [{"color": "#38414e"}]},
                  {"featureType": "road","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},
                  {"featureType": "road","elementType": "labels.text.fill","stylers": [{"color": "#9ca5b3"}]},
                  {"featureType": "road.highway","elementType": "geometry","stylers": [{"color": "#746855"}]},
                  {"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#1f2835"}]},
                  {"featureType": "road.highway","elementType": "labels.text.fill","stylers": [{"color": "#f3d19c"}]},
                  {"featureType": "transit","stylers": [{"visibility": "off"}]},
                  {"featureType": "water","elementType": "geometry","stylers": [{"color": "#17263c"}]},
                  {"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#515c6d"}]},
                  {"featureType": "water","elementType": "labels.text.stroke","stylers": [{"color": "#17263c"}]}
                ]
              '''
                  : '''
                [
                  {
                    "featureType": "poi",
                    "elementType": "labels",
                    "stylers": [{"visibility": "off"}]
                  },
                  {
                    "featureType": "transit",
                    "stylers": [{"visibility": "off"}]
                  }
                ]
              ''',
              initialCameraPosition: CameraPosition(
                target: currentLocation ?? const LatLng(37.7749, -122.4194),
                zoom: 14,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: _buildDragInstruction(),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.18)
                            : Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: isDark ? Colors.white : Colors.black87,
                    size: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: _getCurrentLocation,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.18)
                            : Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF2196F3),
                            ),
                          ),
                        )
                      : Icon(
                          Icons.my_location,
                          color: isDark
                              ? Colors.blue[200]
                              : const Color(0xFF2196F3),
                          size: 20,
                        ),
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
