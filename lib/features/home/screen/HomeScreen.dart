import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/BorrowerRequestCard.dart';
import '../widgets/Custom2TabBar.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/RequestCard.dart';
import '../widgets/SearchWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
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
      body: SafeArea(
        child: Column(
          children: [
            SearchWidget(),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Custom2TabBar(
                tabController: _tabController,
                tabName1: 'Renter Requests',
                tabName2: 'Borrower Requests',
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            RenterRequestCard(),
                            SizedBox(height: 16.0),
                          ],
                        );
                      },
                    ),
                  ),
                  // Borrower Requests
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            BorrowerRequestCard(),
                            SizedBox(height: 16.0),
                          ],
                        );
                      },
                    ),
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
