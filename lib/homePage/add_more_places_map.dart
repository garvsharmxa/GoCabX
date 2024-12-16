import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/homePage/widgets/purple_button.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/images/content/add_more_places_map_bg.png"),
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
                            borderRadius: BorderRadius.circular(5)),
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
                            color: AppColors.background,
                            border: Border.all(width: 0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("New Delhi , Delhi, 01234....",
                                style: AppTextStyles.label),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PurpleButton(title: "ADD LOCATION"),
          )
        ],
      ),
    );
  }
}
