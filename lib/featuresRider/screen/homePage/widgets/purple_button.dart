import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:flutter/material.dart';

class PurpleButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const PurpleButton({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(title,
                style: AppTextStyles.text
                    .copyWith(color: AppColors.background)),
          ),
        ),
      ),
    );
  }
}
