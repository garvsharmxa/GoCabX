import 'dart:async';
import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/screen/mapScreen/mapScreen.dart';
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
    Overlay.of(context).insert(_overlayEntry!);
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
          elevation: 6.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 75,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.09),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverlayOption(
                  label: "Now",
                  onTap: () {
                    setState(() {
                      _scheduleText = 'Now';
                    });
                    _removeScheduleOverlay();
                  },
                  icon: Icons.flash_on_rounded,
                  color: AppColors.primary,
                ),
                 Divider(color: AppColors.subText, height: 0),
                _buildOverlayOption(
                  label: "Schedule",
                  onTap: () {
                    setState(() {
                      _scheduleText = 'Schedule';
                    });
                    _removeScheduleOverlay();
                  },
                  icon: Icons.schedule_rounded,
                  color: AppColors.accent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayOption({required String label, required VoidCallback onTap, required IconData icon, required Color color}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 9.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 17),
            const SizedBox(width: 7),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(color: AppColors.subText, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _buildSearchBar(context, isDark),
        const SizedBox(height: 14),
        _buildMapContainer(context, isDark),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => MapScreen()));
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey[50],
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            child: Row(
              children: [
                SizedBox(width: 5,),
                Container(
                  height: 37.5,
                  width: 37.5,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.25),
                        blurRadius: 9,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.search, color: AppColors.background, size: 22),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 36,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Search destination or place",
                      style: AppTextStyles.label.copyWith(
                        color: isDark
                            ? Colors.white.withOpacity(0.87)
                            : const Color(0xFF292929),
                        fontWeight: FontWeight.w700,
                        fontSize: 14.2,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Schedule button now on the right with pill shape
                AnimatedContainer(
                  duration: const Duration(milliseconds: 170),
                  height: 33,
                  margin: const EdgeInsets.only(left: 6, right: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => _showScheduleOverlay(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            _scheduleText == 'Now' ? Icons.flash_on_rounded : Icons.schedule_rounded,
                            color: AppColors.background,
                            size: 17,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _scheduleText,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.background,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.expand_more_rounded, size: 15, color: AppColors.background),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapContainer(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MapScreen()));
      },
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.09),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Map with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  if (!_mapController.isCompleted) {
                    _mapController.complete(controller);
                  }
                },
                initialCameraPosition: CameraPosition(
                  target: _currentLocation ?? const LatLng(37.7749, -122.4194), // Default to SF
                  zoom: 13,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                buildingsEnabled: true,
                indoorViewEnabled: true,
                compassEnabled: true,
              ),
            ),
            // Floating location button
            Positioned(
              bottom: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () async {
                    if (_currentLocation != null) {
                      await _moveCameraToCurrentLocation(_currentLocation!);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.my_location_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}