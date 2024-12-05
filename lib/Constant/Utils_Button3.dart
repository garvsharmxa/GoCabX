import 'package:flutter/material.dart';

class UtilsButton3 extends StatefulWidget {
  final String text;
  final Function press;
  final Color color;
  final double FontSize;
  const UtilsButton3(
      {super.key,
      required this.text,
      required this.press,
      required this.color, required this.FontSize});

  @override
  State<UtilsButton3> createState() => _UtilsButton3State();
}

class _UtilsButton3State extends State<UtilsButton3> {
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : Colors.white;
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
              border: Border.all(color: textColor),
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: widget.FontSize,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
      ),
    );
  }
}
