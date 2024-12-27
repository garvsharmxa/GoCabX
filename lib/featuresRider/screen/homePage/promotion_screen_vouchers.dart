import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/offers_card.dart';
import 'package:flutter/material.dart';

class PromotionScreenVouchers extends StatefulWidget {
  const PromotionScreenVouchers({super.key});

  @override
  State<PromotionScreenVouchers> createState() =>
      _PromotionScreenVouchersState();
}

class _PromotionScreenVouchersState extends State<PromotionScreenVouchers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.background,
        iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.background
                : AppColors.accent),
        centerTitle: true,
        title: Text(
          'Exclusive Offers',
          style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/content/exclusive_offers.png'),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Vouchers', style: AppTextStyles.text.copyWith()),
                      SizedBox(width: 5),
                      Icon(
                        Icons.local_offer_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ],
                  ),
                  Text(
                    'Grab amazing discounts and rewards tailored just for you.',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 560,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 0,
                childAspectRatio: 174 / 135,
                padding: EdgeInsets.all(10),
                children: List.generate(8, (index) {
                  return OffersCard(
                      parentContext: context,
                      offersAsset:
                          'assets/images/content/offers_weekend_saver.svg');
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('You\'ve reached the end',
                        style: AppTextStyles.caption
                            .copyWith(color: AppColors.subText)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
