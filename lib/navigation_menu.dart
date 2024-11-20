import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';


import 'features/explore/screens/ExploreScreen.dart';
import 'features/history/screens/HistoryScreen.dart';
import 'features/home/screen/HomeScreen.dart';
import 'features/screens/forms/form.dart';
import 'features/screens/my machine/myMachine.dart';
import 'features/tools/screens/MyMachine.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(
            () => NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              height: 70,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) {
                if (index >= 2) {
                  controller.selectedIndex.value = index - 1;
                } else {
                  controller.selectedIndex.value = index;
                }
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Iconsax.home,
                    color: controller.selectedIndex.value == 0
                        ? Colors.orange
                        : Colors.black,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Iconsax.shop,
                    color: controller.selectedIndex.value == 1
                        ? Colors.orange
                        : Colors.black,
                  ),
                  label: 'Explore',
                ),
                const SizedBox(width: 64), // Spacing for the center button
                NavigationDestination(
                  icon: Icon(
                    Iconsax.user,
                    color: controller.selectedIndex.value == 2
                        ? Colors.orange
                        : Colors.black,
                  ),
                  label: 'Tools',
                ),
                NavigationDestination(
                  icon: Icon(
                    Iconsax.heart,
                    color: controller.selectedIndex.value == 3
                        ? Colors.orange
                        : Colors.black,
                  ),
                  label: 'History',
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  showDragHandle: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'What do you want to post?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    // Re-direct to Whatsapp.
                                  },
                                  icon: Image.asset(
                                    "assets/logos/whatsapp.png",
                                    height: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          Obx(() => SizedBox(
                                height: 40,
                                child: CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: Text(
                                    'Seek request from borrower',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  value: controller.selectedOption.value == 0,
                                  onChanged: (bool? value) {
                                    controller.selectedOption.value =
                                        value == true ? 0 : -1;
                                  },
                                ),
                              )),
                          Obx(() => SizedBox(
                                height: 40,
                                child: CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: Text(
                                    'Get request from renters',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  value: controller.selectedOption.value == 1,
                                  onChanged: (bool? value) {
                                    controller.selectedOption.value =
                                        value == true ? 1 : -1;
                                  },
                                ),
                              )),
                          Obx(() => SizedBox(
                                height: 40,
                                child: CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: Text(
                                    'My Machine',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  value: controller.selectedOption.value == 2,
                                  onChanged: (bool? value) {
                                    controller.selectedOption.value =
                                        value == true ? 2 : -1;
                                  },
                                ),
                              )),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Close the bottom sheet
                              if (controller.selectedOption.value == 0) {
                                Get.to(() => const FormWidget());
                              } else if (controller.selectedOption.value == 1) {
                                Get.to(() => const FormWidget());
                              } else if (controller.selectedOption.value == 2) {
                                Get.to(() => const Mymachine());
                              }
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "Create",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  Rx<int> selectedIndex = 0.obs;
  Rx<int> selectedOption = (-1).obs;

  final screens = [
    const HomeScreen(),
    const ExploreScreen(),
    // ProfileScreen(),
    MyMachineScreen(),
    // Container(color: Colors.green),
    const HistoryScreen(),
    // Container(color: Colors.deepPurple),
    // Container(color: Colors.lightGreenAccent),
    // Container(color: Colors.lightBlue),
  ];
}
