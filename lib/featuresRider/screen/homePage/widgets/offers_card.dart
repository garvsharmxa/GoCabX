import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/screen/homePage/promotion_screen_single_offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OffersCard extends StatelessWidget {
  final String offersAsset;
  final BuildContext parentContext;

  const OffersCard({
    super.key,
    required this.offersAsset,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(parentContext).push(
          MaterialPageRoute(
            builder: (context) => PromotionScreenSingleOffer(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          height: 125,
          width: 174,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF121212)
                : const Color(0xFFE6F5F3),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.grey.withOpacity(0.3), // Shadow color with opacity
                spreadRadius: 1, // Spread of the shadow
                blurRadius: 5, // Softness of the shadow
                offset: Offset(0, 3), // Horizontal and vertical shadow offset
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                SvgPicture.asset(offersAsset),
                SizedBox(height: 5),
                Container(
                  height: 25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Apply for Coupon Code',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.w700,
                      ),
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
}
