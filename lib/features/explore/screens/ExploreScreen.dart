import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';



import '../../home/widgets/CustomAppBar.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FF),
      appBar: CustomAppBar(
        ActionWidgets: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.notification),
          ),
        ],
      ),
      
    );
  }
}
