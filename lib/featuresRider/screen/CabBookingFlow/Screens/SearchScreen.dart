import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const Color kDarkBackgroundColor = Color(0xFF212121);
const Color kLightBackgroundColor = Colors.white;
const Color kPrimaryAccentColor = Color(0xFF1F9686);

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: const Text(
          "Today's destination? 👀",
          style: TextStyle(
            fontSize: 22.5,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // TODO: Handle profile button tap
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: kPrimaryAccentColor,
              child: SvgPicture.asset(
                'assets/icons/Vector.svg',
                height: 22,
                width: 22,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchCard(
                isDarkMode: isDarkMode,
                screenSize: screenSize,
                onMapCreated: _onMapCreated,
                center: _center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Your Current Address",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  final bool isDarkMode;
  final Size screenSize;
  final void Function(GoogleMapController) onMapCreated;
  final LatLng center;

  const SearchCard({
    Key? key,
    required this.isDarkMode,
    required this.screenSize,
    required this.onMapCreated,
    required this.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height / 2.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? kLightBackgroundColor : kDarkBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Ride Ready? Let's Roll!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color:
                    isDarkMode ? kDarkBackgroundColor : kLightBackgroundColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryAccentColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/icon.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                    child: Row(
                      children: [
                        // Search Text Field
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search any location, place...",
                              hintStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              border: InputBorder.none, // Remove the default border
                              enabledBorder: InputBorder.none, // Remove the border when enabled
                              focusedBorder: InputBorder.none, // Remove the border when focused
                            ),
                          ),
                        ),
                        // Schedule Button
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white : Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Schedule",
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.black : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.arrow_drop_down,
                                color: isDarkMode ? Colors.black : Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 11.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
