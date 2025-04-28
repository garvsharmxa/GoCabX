import 'package:buzzcab/featuresDriver/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class UtilsButton extends StatefulWidget {
  final String text;
  final VoidCallback press; // Change Function to VoidCallback
  const UtilsButton({super.key, required this.text, required this.press});

  @override
  State<UtilsButton> createState() => _UtilsButtonState();
}

class _UtilsButtonState extends State<UtilsButton> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    Size size = MediaQuery.of(context).size;
    return  Padding(
      padding: const EdgeInsets.only(right: 15, left: 15.0, bottom: 25),
      child: InkWell(
        onTap: widget.press, // No more type issues
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
