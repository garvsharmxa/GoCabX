import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/purple_button.dart';
import 'package:flutter/material.dart';

class PromotionScreenSingleOffer extends StatefulWidget {
  const PromotionScreenSingleOffer({super.key});

  @override
  State<PromotionScreenSingleOffer> createState() =>
      _PromotionScreenSingleOfferState();
}

class _PromotionScreenSingleOfferState
    extends State<PromotionScreenSingleOffer> {
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
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : const Color(0xFFE6F5F3),
        body: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                        'assets/images/content/offers_single_offer.png'),
                    Positioned(
                      bottom: -1,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 20,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF121212)
                              : const Color(0xFFE6F5F3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('What\'s Inside', style: AppTextStyles.text),
                      SizedBox(height: 10),
                      Text(
                          '• Get Flat ₹75 off on all rides between 10 AM and 4 PM, every Wednesday.',
                          style: AppTextStyles.label
                              .copyWith(color: AppColors.subText)),
                      SizedBox(height: 20),
                      Text('Description', style: AppTextStyles.text),
                      SizedBox(height: 10),
                      Text(
                          '• Enjoy Flat ₹75 off on all rides every Wednesday from 10 AM to 4 PM. No code needed; discount applies automatically at checkout!',
                          style: AppTextStyles.label
                              .copyWith(color: AppColors.subText)),
                      SizedBox(height: 20),
                      Text('How to Redeem', style: AppTextStyles.text),
                      SizedBox(height: 10),
                      Text(
                          '• Just book a ride within the specified hours, and the discount will be automatically applied.',
                          style: AppTextStyles.label
                              .copyWith(color: AppColors.subText)),
                      SizedBox(height: 20),
                      Text('Terms & Conditions Apply',
                          style: AppTextStyles.text),
                      SizedBox(height: 10),
                      Text(
                          '• Offer valid only on Wednesdays. \n• Available for rides booked between 10 AM and 4 PM. \n• Cannot be combined with other promotions. \n• Offer valid for a limited time.',
                          style: AppTextStyles.label
                              .copyWith(color: AppColors.subText)),
                      SizedBox(height: 100),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: PurpleButton(title: 'BOOK RIDE NOW'),
              ),
            ),
          ],
        ));
  }
}
