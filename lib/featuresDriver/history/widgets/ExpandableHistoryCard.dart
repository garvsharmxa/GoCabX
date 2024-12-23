import 'package:flutter/material.dart';

class ExpandableHistoryCard extends StatefulWidget {
  ExpandableHistoryCard({
    super.key,
    required this.label,
    required this.isRented,
  });

  String label;
  bool isRented;

  @override
  State<ExpandableHistoryCard> createState() => _ExpandableHistoryCardState();
}

class _ExpandableHistoryCardState extends State<ExpandableHistoryCard> {
  bool isExpanded = false;

  void toggleHistoryCard() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleHistoryCard,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: !isExpanded ? 25 : 16,
                  backgroundImage: AssetImage('assets/images/content/user.png'),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amaan Ansari',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (!isExpanded)
                      Text(
                        '09 Aug 2024',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    if (!isExpanded)
                      Text(
                        widget.label,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    if (isExpanded)
                      Text(
                        'Chandigarh University',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isExpanded) const SizedBox(height: 4.0),
                    if (!isExpanded)
                      Text(
                        'Rs 3000',
                        style: TextStyle(
                          color: widget.isRented ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    if (isExpanded)
                      Text(
                        '09 Aug 2024',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (isExpanded)
              Text(
                widget.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            if (isExpanded) ...[
              const SizedBox(height: 8.0),
              Text(
                'Rs 3000',
                style: TextStyle(
                  color: widget.isRented ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
            if (isExpanded) ...[
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut la...',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.message_rounded, color: Colors.orange),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.location_on_rounded, color: Colors.orange),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
