import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Machinecard extends StatelessWidget {
  const Machinecard({
    Key? key,
    required this.ontap,
  }) : super(key: key);
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to start
          children: [
            Container(
              height: 100,
              width: 100, // Set width to maintain aspect ratio
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/content/machineImg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10), // Space between image and text
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Aligns text to start
                children: [
                  Text(
                    'रोटावेटर',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 4), // Adds spacing between texts
                  Text(
                    'यह कृषि उपकरण मिट्टी को हल्का करने और जुताई करने के लिए घूमते ब्लेड का उपयोग करता है।',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  SizedBox(height: 4),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
