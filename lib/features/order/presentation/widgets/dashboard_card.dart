import 'package:flutter/material.dart';

import '../../../../design/design.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String currentValue;
  final String currentLabel;
  final String lastValue;
  final String lastLabel;
  final String title;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.currentValue,
    required this.currentLabel,
    required this.lastValue,
    required this.lastLabel,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colours.primaryPalette,
      elevation: 5,
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Units.radiusXXXXLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Units.edgeInsetsLarge, horizontal: Units.edgeInsetsLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyles.interBoldH6
                  .copyWith(color: Colours.colorsButtonMenu),
            ),
            Padding(
              padding: const EdgeInsets.all(Units.edgeInsetsMedium),
              child: Icon(
                icon,
                size: 30,
                color: Colours.colorsButtonMenu,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Units.edgeInsetsSmall),
              child: Text(currentLabel,
                  style: TextStyles.interRegularBody1.copyWith(
                    color: Colours.colorsButtonMenu,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(Units.edgeInsetsSmall),
              child: Text(currentValue,
                  style: TextStyles.interRegularBody1
                      .copyWith(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(Units.edgeInsetsSmall),
              child: Text(lastLabel,
                  style: TextStyles.interRegularBody1.copyWith(
                    color: Colours.colorsButtonMenu,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(Units.edgeInsetsSmall),
              child: Text(lastValue,
                  style: TextStyles.interRegularBody1
                      .copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
