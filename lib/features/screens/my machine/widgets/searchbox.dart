import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/searchbar/searchbar.dart';
import '../../AddMachine/AddMachine.dart';

class searchBox extends StatelessWidget {
  const searchBox({
    super.key,
    required TextEditingController textController,
    required FocusNode textFieldFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeSearchBar(),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Get.to(() => AddMachine());
          },
          child: const Text('Next'),
          style: ElevatedButton.styleFrom(
            side: BorderSide.none,
            backgroundColor: Colors.orange,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
