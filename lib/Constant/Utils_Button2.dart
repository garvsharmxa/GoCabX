import 'package:buzzcab/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class UtilsButton2 extends StatefulWidget {
  final String text;
  final Function press;
  final double fontSize;
  const UtilsButton2(
      {super.key,
      required this.text,
      required this.press,
      required this.fontSize});

  @override
  State<UtilsButton2> createState() => _UtilsButton2State();
}

class _UtilsButton2State extends State<UtilsButton2> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15.0, bottom: 25),
      child: InkWell(
        onTap: () => widget.press,
        child: Container(
          height: 50,
          width: size.width,
          decoration: BoxDecoration(
              color: TColors.utilsButton,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
      ),
    );
  }
}
