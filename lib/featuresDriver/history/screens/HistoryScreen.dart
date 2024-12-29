import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../home/widgets/CustomAppBar.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool showFilters = false;

  void toggleFilters() {
    setState(() {
      showFilters = !showFilters;
    });
  }

  Set<String> selectedFilters = {};

  void toggleFilter(String filter) {
    setState(() {
      if (selectedFilters.contains(filter)) {
        selectedFilters.remove(filter);
      } else {
        selectedFilters.add(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FF),
      appBar: CustomAppBar(
        ActionWidgets: [
          IconButton(
            onPressed: () {
   
            },
            icon: const Icon(Iconsax.notification),
          ),
        ],
      ),
      
    );
  }
}
