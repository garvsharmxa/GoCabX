import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../home/widgets/CustomAppBar.dart';
import '../widgets/ExpandableHistoryCard.dart';
import '../widgets/FilterChipWidget.dart';

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
    //            Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => UserListScreen()), // Replace with your destination screen
    // );
            },
            icon: const Icon(Iconsax.notification),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          icon: Icon(
                            Iconsax.search_status_1,
                            color: Colors.grey,
                          ),
                          hintText: "Enter Location"),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: toggleFilters,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Center(
                      child: Icon(Iconsax.setting_4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AnimatedOpacity(
              opacity: showFilters ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: showFilters
                  ? Column(
                      children: [
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            FilterChipWidget(
                              label: 'Location',
                              selected: selectedFilters.contains('Location'),
                              onSelected: (isSelected) {
                                toggleFilter('Location');
                              },
                            ),
                            FilterChipWidget(
                              label: 'Borrowed',
                              selected: selectedFilters.contains('Borrowed'),
                              onSelected: (isSelected) {
                                toggleFilter('Borrowed');
                              },
                            ),
                            FilterChipWidget(
                              label: 'Rented',
                              selected: selectedFilters.contains('Rented'),
                              onSelected: (isSelected) {
                                toggleFilter('Rented');
                              },
                            ),
                            FilterChipWidget(
                              label: 'Date',
                              selected: selectedFilters.contains('Date'),
                              onSelected: (isSelected) {
                                toggleFilter('Date');
                              },
                            ),
                            FilterChipWidget(
                              label: 'Price (low to high)',
                              selected: selectedFilters
                                  .contains('Price (low to high)'),
                              onSelected: (isSelected) {
                                toggleFilter('Price (low to high)');
                              },
                            ),
                            FilterChipWidget(
                              label: 'Price (high to low)',
                              selected: selectedFilters
                                  .contains('Price (high to low)'),
                              onSelected: (isSelected) {
                                toggleFilter('Price (high to low)');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            ExpandableHistoryCard(
              label: "Rotavator Rented",
              isRented: true,
            ),
            const SizedBox(height: 16),
            ExpandableHistoryCard(
              label: "Harrow Borrowed",
              isRented: false,
            ),
          ],
        ),
      ),
    );
  }
}
