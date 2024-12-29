import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecentRidesHomeScreenCard extends StatelessWidget {
  const RecentRidesHomeScreenCard({
    super.key,
    required this.recentRidesAsset,
    required this.recentRidesAddress,
    required this.parentContext,
  });

  final String recentRidesAsset;
  final BuildContext parentContext;

  final String recentRidesAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 170,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF090826)
              : Color(0xFFE9E9F5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(recentRidesAsset)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 121,
                        child: Text(
                          recentRidesAddress,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.label,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 20,
                        width: 70,
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(
                            'Ride Again',
                            style: AppTextStyles.caption.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
