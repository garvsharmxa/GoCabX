import 'package:flutter/material.dart';
import 'package:get/get.dart';

class divider extends StatelessWidget {
  const divider({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: Color.fromARGB(255, 113, 113, 113),
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          text.capitalize!,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
              color: Color.fromARGB(255, 113, 113, 113),
              thickness: 0.5,
              indent: 5,
              endIndent: 060),
        ),
      ],
    );
  }
}
