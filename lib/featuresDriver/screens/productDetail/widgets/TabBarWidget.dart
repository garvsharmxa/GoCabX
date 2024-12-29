import 'package:flutter/material.dart';

import '../../../home/widgets/Custom2TabBar.dart';
import '../../tools/widgets/machineCard.dart';
import 'bottomSheet.dart';

class tabBarWidget extends StatelessWidget {
  const tabBarWidget({
    super.key,
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Custom2TabBar(
            tabController: _tabController,
            tabName1: 'विस्तार',
            tabName2: 'पार्ट्स',
            tabName3: 'निर्देश',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'यह कृषि उपकरण मिट्टी को हल्का करने और जुताई करने के लिए घूमते ब्लेड का उपयोग करता है।',
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Machinecard(
                        ontap: () {
                          showModalBottomSheet(
                              showDragHandle: false,
                              context: context,
                              builder: (context) {
                                return const MachineDetailsBottomSheet();
                              });
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Image(
                      image: AssetImage("assets/images/content/Harrow.png")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
