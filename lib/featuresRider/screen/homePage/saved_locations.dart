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
                  style: AppTextStyles.h5.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Quick Access to Your Go-To Spots!",
                  style: AppTextStyles.text,
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                title == 'Home' ? Icons.home_rounded :
                title == 'Work' ? Icons.work_rounded : Icons.location_on_rounded,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.text.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: AppTextStyles.caption.copyWith(
                      color: isDark ? Colors.white60 : const Color(0xFF6B7280),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_rounded,
                color: isDark ? Colors.white60 : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
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
                style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                "Your saved rides will appear here once you add",
                style: AppTextStyles.text,
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
