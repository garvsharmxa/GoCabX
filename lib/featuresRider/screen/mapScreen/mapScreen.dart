import 'dart:async';

import 'package:buzzcab/featuresRider/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  Set<Marker> _markers = {};
  LatLng? centerMarkerPosition;

  GoogleMapController? _controller;
  Location _location = new Location();
  LatLng? currentP = null;
  Map<PolylineId, Polyline> _polylines = {};
  bool _initialCameraMoveDone = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> cameraMove(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;

    if (_controller != null) {
      await _controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 13,
        ),
      ));
    }
  }

  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          debugPrint(
              "lat: ${currentLocation.latitude}, lng: ${currentLocation.longitude}");

          cameraMove(currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolyline() async {
    List<LatLng> polyline = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result;

    if (_markers.length == 1) {
      result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: dirApiKey,
        request: PolylineRequest(
          mode: TravelMode.driving,
          origin: PointLatLng(currentP!.latitude, currentP!.longitude),
          destination: PointLatLng(_markers.first.position.latitude,
              _markers.first.position.longitude),
        ),
      );
    } else if (_markers.length == 2) {
      result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: dirApiKey,
        request: PolylineRequest(
          mode: TravelMode.driving,
          origin: PointLatLng(_markers.first.position.latitude,
              _markers.first.position.longitude),
          destination: PointLatLng(_markers.last.position.latitude,
              _markers.last.position.longitude),
        ),
      );
    } else {
      return polyline;
    }

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyline.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      debugPrint(result.errorMessage);
    }
    return polyline;
  }

  Future<void> _addMarker(LatLng position, String id) async {
    setState(() {
      if (_markers.length >= 2) {
        _markers.clear();
      }
      final marker = Marker(
        markerId: MarkerId(id),
        position: position,
      );
      _markers.add(marker);
    });
    if (_markers.length > 0) {
      List<LatLng> polylineCoords = await getPolyline();
      generatePolyline(polylineCoords);
    }
  }

  void generatePolyline(List<LatLng> polylineCoords) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoords,
      width: 2,
    );
    setState(() {
      _polylines[id] = polyline;
    });
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: dirApiKey,
      mode: Mode.overlay, // Mode.fullscreen
      language: "en",
      components: [Component(Component.country, "us")],
    );

    if (p != null) {
      PlacesDetailsResponse detail = await GoogleMapsPlaces(apiKey: dirApiKey)
          .getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      _addMarker(LatLng(lat, lng), 'searched_location');
      cameraMove(LatLng(lat, lng));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: currentP == null
          ? Center(
              child: Text("Loading..."),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                    _controller = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: currentP!,
                    zoom: 13,
                  ),
                  markers: _markers,
                  polylines: Set<Polyline>.of(_polylines.values),
                  onCameraMove: (CameraPosition position) {
                    setState(() {
                      centerMarkerPosition = position.target;
                    });
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Icon(
                      Icons.location_pin,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (centerMarkerPosition != null) {
                          _addMarker(centerMarkerPosition!, 'center_marker');
                        }
                      },
                      child: Text("Confirm Location"),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 10,
                  right: 10,
                  child:
                      // textfield with borders, and white bg
                      Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF292929),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search any location, place...",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
