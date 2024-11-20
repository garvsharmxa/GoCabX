import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selected ? Iconsax.tick_circle : Icons.radio_button_unchecked,
            size: 16,
            color: selected ? Colors.white : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Colors.orange,
      checkmarkColor: Colors.white,
      backgroundColor: Colors.white,
      showCheckmark: false,
    );
  }
}
