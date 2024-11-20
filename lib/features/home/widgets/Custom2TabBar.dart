import 'package:flutter/material.dart';

class Custom2TabBar extends StatelessWidget {
  const Custom2TabBar({
    Key? key,
    required this.tabController,
    required this.tabName1,
    required this.tabName2,
    this.tabName3,
  }) : super(key: key);

  final TabController? tabController;
  final String tabName1;
  final String tabName2;
  final String? tabName3;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: const Color(0xFFFF6E40),
        unselectedLabelColor: Colors.grey[600],
        dividerColor: Colors.transparent,
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            text: tabName1,
            height: 32,
          ),
          Tab(
            text: tabName2,
            height: 32,
          ),
          if (tabName3 != null)
            Tab(
              text: tabName3,
              height: 32,
            ),
        ],
      ),
    );
  }
}
