import 'dart:async';

import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/consts.dart';
import 'package:buzzcab/featuresRider/screen/mapScreen/mapScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreenMapContainer extends StatefulWidget {
  const HomeScreenMapContainer({
    super.key,
  });

  @override
  State<HomeScreenMapContainer> createState() => _HomeScreenMapContainerState();
}

class _HomeScreenMapContainerState extends State<HomeScreenMapContainer> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  Set<Marker> _markers = {};

  GoogleMapController? _controller;
  Location _location = new Location();
  LatLng? currentP = LatLng(0, 0);
  Map<PolylineId, Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> cameraMove(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;

    await _controller!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: 13,
      ),
    ));
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
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: dirApiKey,
      request: PolylineRequest(
        mode: TravelMode.driving,
        origin: PointLatLng(currentP!.latitude, currentP!.longitude),
        destination: PointLatLng(_markers.first.position.latitude,
            _markers.first.position.longitude),
      ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyline.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      debugPrint(result.errorMessage);
    }
    return polyline;
  }

  void _addMarker(LatLng position, String id) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
    );
    setState(() {
      _markers.add(marker);
    });
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ride Ready? Let\'s Roll!',
            style: AppTextStyles.h6(context).copyWith(color: AppColors.background)),
        SizedBox(height: 15),
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.search,
                color: AppColors.background,
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFF292929),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Search any location, place...",
                      style: AppTextStyles.label(context)
                          .copyWith(color: AppColors.background)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        GestureDetector(
          onLongPress: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MapScreen(),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                  ),
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: -5.0,
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) =>
                    _mapController.complete(controller),
                initialCameraPosition: CameraPosition(
                  target: currentP!,
                  zoom: 13,
                ),
                onTap: (LatLng position) {
                  _addMarker(position, 'marker_${_markers.length}');
                  getPolyline().then((coordinates) {
                    generatePolyline(coordinates);
                  });
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
          ),
        )
      ],
    );
  }
}
