import 'package:flutter/material.dart';
import '../../../../design/design.dart';

class HeaderRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const HeaderRow({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ??
              TextStyles.interBoldH6.copyWith(color: Colors.white),
        ),
        const SizedBox(height: Units.sizedbox_10),
        Text(
          subtitle,
          style: subtitleStyle ??
              TextStyles.interRegularBody1
                  .copyWith(color: Colours.colorsButtonMenu),
        ),
      ],
    );
  }
}
