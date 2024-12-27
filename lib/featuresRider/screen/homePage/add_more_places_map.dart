import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/purple_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddMorePlacesMapScreen extends StatefulWidget {
  const AddMorePlacesMapScreen({super.key});

  @override
  State<AddMorePlacesMapScreen> createState() => _AddMorePlacesMapScreenState();
}

class _AddMorePlacesMapScreenState extends State<AddMorePlacesMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GoogleMap(
            buildingsEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194), // Example coordinates
              zoom: 10,
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.location_pin,
                      color: AppColors.background,
                      size: 15,
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.background.withOpacity(0.7),
                        border: Border.all(width: 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "New Delhi , Delhi, 01234....",
                          style: AppTextStyles.label
                              .copyWith(color: AppColors.accent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: PurpleButton(title: "ADD LOCATION"),
          ),
        ],
      ),
    );
  }
}
