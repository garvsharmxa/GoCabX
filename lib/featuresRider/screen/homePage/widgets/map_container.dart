import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../mapScreen/mapScreen.dart';

class HomeScreenMapContainer extends StatelessWidget {
  const HomeScreenMapContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ride Ready? Let\'s Roll!',
            style: AppTextStyles.h6.copyWith(color: AppColors.background)),
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
                      style: AppTextStyles.label
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
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.42796133580664, -122.085749655962),
                  zoom: 14.4746,
                ),
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {},
              ),
            ),
          ),
        )
      ],
    );
  }
}
