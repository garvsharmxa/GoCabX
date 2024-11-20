import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'popupContainer.dart';

class MachineDetailsBottomSheet extends StatelessWidget {
  const MachineDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // Ensure the bottom sheet only takes up the necessary space
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Disc',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'यह कृषि उपकरण मिट्टी को हल्का करने और जुताई करने के लिए घूमते ब्लेड का उपयोग करता है। .',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns text to start
            children: [
              Text(
                'क्रमांक:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              SizedBox(width: 4), // Space between label and value
              Text(
                '123456789',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey, // Border color
              width: 1, // Border width
              style: BorderStyle.solid, // Border style
            ),
            columnWidths: const {
              0: FixedColumnWidth(120),
              1: FixedColumnWidth(150),
            },
            children: const [
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('व्यास'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('24-inch'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('बियरिंग'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('6308'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('व्यास'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('24-inch'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('बियरिंग '),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('6308'),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const RequestPopup();
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange),
                    child: const Center(
                      child: Text(
                        'Request',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.clear,
                      color: Colors.orange,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
