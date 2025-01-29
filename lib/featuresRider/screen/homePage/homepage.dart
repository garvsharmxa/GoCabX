import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/screen/homePage/promotion_screen_vouchers.dart';
import 'package:buzzcab/featuresRider/screen/homePage/saved_locations.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/home_screen_app_bar.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/map_container.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/offers_card.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/oppurtunity_black_button.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/recent_rides_card.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/widget_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'Vinay';
  String recentRidesAddress = '123 Main Street, New York, NY 10001';
  String recentRidesAsset = 'assets/images/content/recent_rides_car.svg';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: AppColors.background,
        title: HomeScreenAppBar(username: username),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF121212)
          : const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cabs
            Container(
              color: AppColors.accent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          BookCabsIcon(),
                          SizedBox(width: 10),
                          Text(
                            'Book Cabs',
                            style: AppTextStyles.text(context)
                                .copyWith(color: AppColors.background),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    // Map Container
                    HomeScreenMapContainer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recent Rides Title

                  Text(
                    'Your Saved Places',
                    style: AppTextStyles.text(context),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Your Go-To Rides, Just a Tap Away',
                          style: AppTextStyles.caption(context)
                              .copyWith(color: AppColors.subText)),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => SavedLocationsScreen()));
                        },
                        child: Row(
                          children: [
                            Text(
                              'See More',
                              style: AppTextStyles.caption(context),
                            ),
                            Icon(
                              Icons.arrow_right_alt,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  SavedLocationsCard(
                    title: "Home",
                    address: "123 Main Street, New York, NY 10001",
                  ),
                  SizedBox(height: 10),
                  SavedLocationsCard(
                    title: "Gym",
                    address: "123 Main Street, New York, NY 10001",
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Promotions & Offers',
                    style: AppTextStyles.text(context),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('More Rides, More Discounts!',
                          style: AppTextStyles.caption(context)
                              .copyWith(color: AppColors.subText)),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PromotionScreenVouchers(),
                            ),
                          );
                        },
                        child: Text(
                          'See More',
                          style: AppTextStyles.caption(context),
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        size: 14,
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  SizedBox(
                    height: 135,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        OffersCard(
                          parentContext: context,
                          offersAsset:
                              'assets/images/content/offers_weekend_saver.svg',
                        ),
                        SizedBox(width: 10),
                        OffersCard(
                          parentContext: context,
                          offersAsset:
                              'assets/images/content/offers_midweek_madness.svg',
                        ),
                        SizedBox(width: 10),
                        OffersCard(
                          parentContext: context,
                          offersAsset:
                              'assets/images/content/offers_midweek_madness.svg',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Your Recent Rides',
                          style: AppTextStyles.text(context)),
                      Spacer(),
                      Text(
                        'See More',
                        style: AppTextStyles.caption(context),
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        size: 14,
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Recent Rides Cards

                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        RecentRidesHomeScreenCard(
                            parentContext: context,
                            recentRidesAsset: recentRidesAsset,
                            recentRidesAddress: recentRidesAddress),
                        SizedBox(width: 10),
                        RecentRidesHomeScreenCard(
                            parentContext: context,
                            recentRidesAsset:
                                'assets/images/content/recent_rides_bike.svg',
                            recentRidesAddress: recentRidesAddress),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  // Opportunities Section
                  Text('Opportunities for Professional Drivers',
                      style: AppTextStyles.text(context)),

                  SizedBox(height: 10),

                  Container(
                    height: 150,
                    width: w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1A1A1A)
                          : Color(0xFFE6F5F3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: 0,
                          bottom: 0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              height: 102,
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Apply to Drive with Us',
                                      style: AppTextStyles.text(context)),
                                  SizedBox(height: 10),
                                  Text(
                                    'Join our trusted team for flexible work opportunities and higher earnings!',
                                    style: AppTextStyles.caption(context),
                                  ),
                                  SizedBox(height: 10),
                                  BlackHuggingButton(title: 'Apply Now!'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(
                                'assets/images/content/oppurtunity_car.svg'))
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  Text('Stay Updated on Offers',
                      style: AppTextStyles.text(context)),
                  SizedBox(height: 10),
                  Container(
                      height: 122,
                      width: w,
                      decoration: BoxDecoration(
                        color: Color(0xFF8F52CC),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.notifications_active_rounded,
                                    color: AppColors.background),
                                SizedBox(width: 5),
                                Text(
                                  'Stay Up-to-date!',
                                  style: AppTextStyles.text(context)
                                      .copyWith(color: AppColors.background),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                                'Enable notifications to receive updates on new deals and special promotions directly on your device. Follow us on social media for more giveaways!',
                                style: AppTextStyles.caption(context).copyWith(
                                    color: AppColors.background, fontSize: 12))
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedPlacesCard extends StatelessWidget {
  const SavedPlacesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 120,
      decoration: BoxDecoration(
        color: Color(0xFFE9E9F5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
