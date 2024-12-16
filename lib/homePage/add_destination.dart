import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:buzzcab/homePage/add_more_places_manually.dart';
import 'package:flutter/material.dart';

class AddDestinationScreen extends StatefulWidget {
  const AddDestinationScreen({super.key});

  @override
  State<AddDestinationScreen> createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add a Destination",
                style: AppTextStyles.h5.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE6E6E6),
                child:
                    const Icon(Icons.home_outlined, color: AppColors.subText),
              ),
              title: Text(
                "Add Home",
                style: AppTextStyles.label,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE6E6E6),
                child: const Icon(Icons.work_outline, color: AppColors.subText),
              ),
              title: Text("Add Work", style: AppTextStyles.label),
              onTap: () {},
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            SavedLocationItem(
                title: 'Xyz North Town, Steet No. 45, Chandigarh, Punjab',
                onEdit: () {}),
            SavedLocationItem(
                title: 'Xyz North Town, Steet No. 45, Chandigarh, Punjab',
                onEdit: () {}),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE6E6E6),
                child: const Icon(Icons.add, color: AppColors.subText),
              ),
              title: Text(
                "Add New",
                style:
                    AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
              ),
              subtitle: Text("Save your Favourite Places",
                  style:
                      AppTextStyles.caption.copyWith(color: AppColors.subText)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => AddMorePlacesManuallyScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SavedLocationItem extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;

  const SavedLocationItem({
    super.key,
    required this.title,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 40,
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Color(0xFFE6E6E6),
        child: const Icon(Icons.favorite, color: Colors.red),
      ),
      title: Text(
        title,
        style: AppTextStyles.label,
      ),
      subtitle: Text(
        "Edit",
        style: AppTextStyles.caption.copyWith(
          decoration: TextDecoration.underline,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
