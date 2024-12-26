import 'package:flutter/material.dart';

import '../../../../design/design.dart';

class SelectCard extends StatelessWidget {
  final int id;
  final String label;
  final IconData icon;
  final int selectedMethodId;
  final Function(int) onSelectMethod;

  const SelectCard({
    super.key,
    required this.id,
    required this.label,
    required this.icon,
    required this.selectedMethodId,
    required this.onSelectMethod,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedMethodId == id;

    return GestureDetector(
      onTap: () {
        onSelectMethod(id);
      },
      child: Card(
        color: isSelected ? Colours.colorsButtonMenu : Colours.primaryPalette,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Units.iconXXSmall),
          side: BorderSide(
            color: isSelected ? Colours.colorsButtonMenu : Colors.grey,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Units.edgeInsetsSmall,
              horizontal: Units.edgeInsetsLarge),
          child: Column(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(height: Units.sizedbox_8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colours.colorsButtonMenu,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
