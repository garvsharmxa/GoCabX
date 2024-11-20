import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../home/widgets/Custom2TabBar.dart';
import '../widgets/MachinePartsCard.dart';
import '../widgets/RequestButton.dart';

class MachineProfile extends StatefulWidget {
  const MachineProfile({super.key});

  @override
  State<MachineProfile> createState() => _MachineProfileState();
}

class _MachineProfileState extends State<MachineProfile>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _showPartDetails(String partName, String partNumber, String imagePath) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      imagePath,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'क्रमांक: $partNumber',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'यह कृषि उपकरण मिट्टी को हल्का करने और जुताई करने के लिए घूमते ब्लेड का उपयोग करता है।',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Table(
                children: [
                  TableRow(children: [
                    Text('आकार', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('24inch'),
                  ]),
                  TableRow(children: [
                    Text('मॉडल', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('638x'),
                  ]),
                  TableRow(children: [
                    Text('वजन', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('50kg'),
                  ]),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: RequestButton(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_circle_left, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30.0)),
                child: Image.asset(
                  'assets/images/content/Harrow.png', // Replace with your image asset
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Details Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('Harrow',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text('123456789',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'हैरो एक कृषि उपकरण है जो मिट्टी को समतल और ढीला करता है, जिससे बीज बोने के लिए उपयुक्त भूमि तैयार होती है और खरपतवार नियंत्रित रहते हैं।',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Custom2TabBar(
              tabController: _tabController,
              tabName1: "विस्तार",
              tabName2: "पार्ट्स",
              tabName3: "निर्देश",
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'यह कृषि उपकरण मिट्टी को हल्का करने और जुताई करने के लिए घूमते ब्लेड का उपयोग करता है।',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showPartDetails(
                            "Disc",
                            "1234567890",
                            "assets/images/content/Machine Part - Disc.png",
                          );
                        },
                        child: const MachinePartsCard(
                          partImageLocation:
                              "assets/images/content/Machine Part - Disc.png",
                          partName: "Disc",
                          partDescription:
                              "यह कृषि उपकरण मिट्टी को हल्का करने और जुताई करने के लिए घूमते ब्लेड का उपयोग करता है।",
                          partNumber: "1234567890",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showPartDetails(
                            "Frame",
                            "1234567890",
                            "assets/images/content/Machine Part - Frame.png",
                          );
                        },
                        child: const MachinePartsCard(
                          partImageLocation:
                              "assets/images/content/Machine Part - Frame.png",
                          partName: "Frame",
                          partDescription:
                              "यह कृषि उपकरण मिट्टी को हल्का करने और जुताई करने के लिए घूमते ब्लेड का उपयोग करता है।",
                          partNumber: "1234567890",
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'यह कृषि उपकरण मिट्टी को हल्का करने और जुताई करने के लिए घूमते ब्लेड का उपयोग करता है।',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),

          // Request Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: RequestButton(),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  splashColor: Colors.transparent,
                  elevation: 0,
                  onPressed: () {},
                  child: Icon(Icons.shopping_cart),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
