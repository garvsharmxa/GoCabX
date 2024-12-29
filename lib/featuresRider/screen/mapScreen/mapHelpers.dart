import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapHelpers {
  static Future<void> cameraMove(Completer<GoogleMapController> mapController,
      GoogleMapController? controller, LatLng position) async {
    final GoogleMapController mapCtrl = await mapController.future;
    await controller!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: 13,
      ),
    ));
  }

  static Future<void> getCurrentLocation(
      Location location,
      Function(LatLng) onLocationUpdate,
      Completer<GoogleMapController> mapController,
      GoogleMapController? controller) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        LatLng currentP =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        onLocationUpdate(currentP);
        cameraMove(mapController, controller, currentP);
      }
    });
  }

  static Future<List<LatLng>> getPolyline(
      LatLng currentP, Set<Marker> markers) async {
    List<LatLng> polyline = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM",
      request: PolylineRequest(
        mode: TravelMode.driving,
        origin: PointLatLng(currentP.latitude, currentP.longitude),
        destination: PointLatLng(
            markers.first.position.latitude, markers.first.position.longitude),
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

  static void addMarker(
      LatLng position, String id, Set<Marker> markers, Function() updateState) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
    );
    markers.add(marker);
    updateState();
  }
}
