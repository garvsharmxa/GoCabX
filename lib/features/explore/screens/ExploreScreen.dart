import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import '../../home/widgets/BorrowerRequestCard.dart';
import '../../home/widgets/Custom2TabBar.dart';
import '../../home/widgets/CustomAppBar.dart';
import '../../home/widgets/RenterRequestCard.dart';
import '../../screens/tools/widgets/toolSearchBar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column to contain the search bar and its suggestions
                const Expanded(
                  child: Column(
                    children: [
                      Toolsearchbar(),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Icon(Iconsax.setting_4),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Custom2TabBar(
              tabController: _tabController,
              tabName1: "Renter Requests",
              tabName2: "Borrower Requests",
            ),
            SizedBox(height: 16),
            // Requests according to the TabBar
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          RenterRequestCard(),
                          SizedBox(height: 16.0),
                        ],
                      );
                    },
                  ),
                  // Borrower Requests
                  ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BorrowerRequestCard(),
                          SizedBox(height: 16.0),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
