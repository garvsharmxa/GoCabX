import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
              'https://s3-alpha-sig.figma.com/img/5ec8/8bb7/b0e3d1a1eaed399cc32d8f036c47c01c?Expires=1734307200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=RCWe3aAeCbXNeQBwDf6vEeXaU6vbUyCYwJNGo4Bk2h79gbRnI2ytGL9mW3Tg540v6CVJvkyK2OBvr~7j2Y1j10vanmp2e1I17-DzZ3x87UUs~rZcMOlcV1W13RGlmC9Ab569qmc0hkiup6do7OHkHVQv1XnYZDNNxM9CJridJ3-HFH6622myxqXE6r0q0wNbJ31DjkQFZExkkTdVOmVbCo~kwv3AZTVVZyQkiD5W65okzr4y8ZVTvIitcBCPv3d9YeoQtXyuae37vgczBXD-3MmnxS8nBjdOu9x6XdwGimJ2MJGRO6IBKWHZXsnrkinqVcc~-nxuyrbUZtc00A71rg__',
            ),
          ),
          Icon(Icons.arrow_drop_down),
          SizedBox(width: 10),
          Text(
            "Welcome, ${username} 👋🏻",
            style: AppTextStyles.h6(context).copyWith(color: AppColors.background),
          ),
          Spacer(),
          CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 15,
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/128/1827/1827425.png',
              color: AppColors.background,
              scale: 7.5,
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.accent,
            child: Icon(
              Icons.menu,
              color: AppColors.background,
            ),
          ),
        ],
      ),
    );
  }
}
