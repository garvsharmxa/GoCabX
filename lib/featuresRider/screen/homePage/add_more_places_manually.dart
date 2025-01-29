import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/screen/homePage/add_more_places_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddMorePlacesManuallyScreen extends StatefulWidget {
  const AddMorePlacesManuallyScreen({super.key});

  @override
  State<AddMorePlacesManuallyScreen> createState() =>
      _AddMorePlacesManuallyScreenState();
}

class _AddMorePlacesManuallyScreenState
    extends State<AddMorePlacesManuallyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.background,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.background
                : AppColors.accent),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF121212)
          : const Color(0xFFE6F5F3),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Row(
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
                      color: Color(0xFFF2F2F2).withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("New Delhi , Delhi, 01234....",
                          style: AppTextStyles.label(context)),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => AddMorePlacesMapScreen()));
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/content/add_more_places_map.svg',
                        height: 15,
                        width: 15,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                      'assets/images/content/add_more_places_manually.png'),
                ),
                SizedBox(height: 15),
                Text(
                  "Add the Location",
                  style: AppTextStyles.h4(context)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text("Quickly access your top locations anytime!",
                    style: AppTextStyles.text(context)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
