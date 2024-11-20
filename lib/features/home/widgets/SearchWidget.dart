import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/search/HomeSearch.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF1E7),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
                "assets/images/content/organic-farming-concept-with-man-field 1.png"),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Find Farming rental tools here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Iconsax.setting_4),
                    ],
                  ),
                  SizedBox(height: 8),
                  CustomSearchField(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
