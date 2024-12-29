import 'dart:async';

import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresDriver/CabBookingFlow/Screens/RideDetails.dart';
import 'package:buzzcab/featuresDriver/CabBookingFlow/Screens/SearchScreen.dart';
import 'package:buzzcab/featuresRider/screen/mapScreen/mapScreen.dart';
import 'package:buzzcab/featuresRider/screen/mapScreen/searchLocationScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreenMapContainer extends StatefulWidget {
  const HomeScreenMapContainer({super.key});

  @override
  State<HomeScreenMapContainer> createState() => _HomeScreenMapContainerState();
}

class _HomeScreenMapContainerState extends State<HomeScreenMapContainer> {
  final Completer<GoogleMapController> _mapController = Completer();
  late Location _location;
  LatLng? _currentLocation;
  String _scheduleText = 'Schedule';
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _location = Location();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final isServiceEnabled = await _location.serviceEnabled();
    if (!isServiceEnabled && !await _location.requestService()) return;

    final permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied &&
        await _location.requestPermission() != PermissionStatus.granted) return;

    _location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          _moveCameraToCurrentLocation(_currentLocation!);
        });
      }
    });
  }

  Future<void> _moveCameraToCurrentLocation(LatLng position) async {
    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15),
      ),
    );
  }

  void _showScheduleOverlay(BuildContext context) {
    _overlayEntry = _createScheduleOverlay(context);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeScheduleOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createScheduleOverlay(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        right: offset.dx,
        top: offset.dy - 10,
        child: Material(
          elevation: 4.0,
          child: Container(
            height: 60,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _scheduleText = 'Now';
                      });
                      _removeScheduleOverlay();
                    },
                    child: Text(
                      'Now',
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.subText),
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.subText)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _scheduleText = 'Schedule';
                      });
                      _removeScheduleOverlay();
                    },
                    child: Text(
                      'Schedule',
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.subText),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ride Ready? Let\'s Roll!',
          style:
              AppTextStyles.h6.copyWith(color: AppColors.background),
        ),
        const SizedBox(height: 15),
        _buildSearchBar(context),
        const SizedBox(height: 10),
        _buildMapContainer(context),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const RideDetails())),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(Icons.search, color: AppColors.background),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF292929),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Search any location, place...",
                      style: AppTextStyles.label
                          .copyWith(color: AppColors.background),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 4,
          bottom: 6,
          child: InkWell(
            onTap: () => _showScheduleOverlay(context),
            child: Container(
              height: 28,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Text(
                    _scheduleText,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.background),
                  ),
                  const Icon(Icons.expand_more_rounded, size: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapContainer(BuildContext context) {
    return GestureDetector(
      onLongPress: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const MapScreen())),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey),
              BoxShadow(
                  color: Colors.transparent, spreadRadius: -5, blurRadius: 20),
            ],
          ),
          child:
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? LatLng(37.7749, -122.4194), // Default to San Francisco
              zoom: 13,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
          )
        ),
      ),
    );
  }
}
