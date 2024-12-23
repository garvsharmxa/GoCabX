import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:flutter/material.dart';

class BookCabsIcon extends StatelessWidget {
  const BookCabsIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 3,
              color: Color(0xFFCAB3E1),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 1.4,
            widthFactor: 0.9,
            child: SizedBox(
                height: 20,
                child: Image.asset('assets/images/content/img1.png'))),
      ],
    );
  }
}
