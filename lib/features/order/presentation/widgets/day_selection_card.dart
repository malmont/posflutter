import 'package:flutter/material.dart';
import '../../../../design/design.dart';

class DaySelectionCard extends StatelessWidget {
  final String name;
  final bool isSelected;

  const DaySelectionCard({
    super.key,
    required this.name,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Units.edgeInsetsLarge,
        vertical: Units.edgeInsetsLarge,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Units.radiusXXLarge),
        color: isSelected ? Colours.colorsButtonMenu : Colours.primary100,
      ),
      padding: const EdgeInsets.all(Units.edgeInsetsLarge),
      child: Text(
        name,
        style: TextStyles.interBoldBody1.copyWith(
          color: isSelected ? Colours.primary100 : Colours.white,
        ),
      ),
    );
  }
}
