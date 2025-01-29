import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/featuresRider/screen/homePage/add_destination.dart';
import 'package:buzzcab/featuresRider/screen/homePage/widgets/purple_button.dart';
import 'package:flutter/material.dart';

class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({super.key});

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}

class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.background
                : AppColors.accent),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF121212)
          : const Color(0xFFE6F5F3),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Favorites',
                  style: AppTextStyles.h5(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Quick Access to Your Go-To Spots!",
                  style: AppTextStyles.text(context),
                ),
                SizedBox(height: 20),
                SavedLocationsCard(
                  title: "Home",
                  address: "123 Main Street, New York, NY 10001",
                ),
                SizedBox(height: 10),
                SavedLocationsCard(
                  title: "Gym",
                  address: "123 Main Street, New York, NY 10001",
                ),
                SizedBox(height: 10),
                SavedLocationsCard(
                  title: "Work",
                  address: "123 Main Street, New York, NY 10001",
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: PurpleButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => AddDestinationScreen(),
                    ),
                  );
                },
                title: "+ Add More Destinations",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SavedLocationsCard extends StatelessWidget {
  final String title;
  final String address;
  const SavedLocationsCard({
    super.key,
    required this.title,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFFE9E9F5).withOpacity(0.6),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: AppColors.secondary,
                        size: 24,
                      ),
                      Text(
                        title,
                        style: AppTextStyles.label(context)
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    address,
                    style: AppTextStyles.label(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Icon(
                Icons.more_vert_rounded,
                size: 14,
              ),
            ],
          ),
        ));
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                    'assets/images/content/saved_locations_empty.png'),
              ),
              SizedBox(height: 20),
              Text(
                "No Saved Rides!",
                style: AppTextStyles.h4(context)
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                "Your saved rides will appear here once you add",
                style: AppTextStyles.text(context),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: PurpleButton(
              title: "ADD SAVED PLACES",
            ),
          ),
        ),
      ],
    );
  }
}
