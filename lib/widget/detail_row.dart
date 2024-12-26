import 'package:flutter/material.dart';
import '../../../../design/design.dart';

class DetailsRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final double spacing;

  const DetailsRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.spacing = Units.sizedbox_10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle ??
              TextStyles.interRegularBody1.copyWith(color: Colors.white),
        ),
        SizedBox(height: spacing),
        Text(
          value,
          style: valueStyle ??
              TextStyles.interRegularBody1
                  .copyWith(color: Colours.colorsButtonMenu),
        ),
      ],
    );
  }
}
