import 'package:flutter/material.dart';
import '../../../../design/design.dart';

class StatusRow extends StatelessWidget {
  final String label;
  final String statusColor;
  final TextStyle? labelStyle;
  final TextStyle? statusStyle;
  final EdgeInsetsGeometry? padding;
  final double spacing;

  const StatusRow({
    super.key,
    required this.label,
    required this.statusColor,
    this.labelStyle,
    this.statusStyle,
    this.padding,
    this.spacing = Units.sizedbox_10,
  });
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Complétée':
        return Colors.green;
      case 'Complété':
        return Colors.green;
      case 'En cours':
        return Colors.orange;
      case 'En cours de préparation':
        return Colors.purple;
      case 'En cours de livraison':
        return Colors.blueAccent;
      case 'Livrée':
        return Colors.greenAccent;
      case 'Annulation':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
        Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: Units.edgeInsetsMedium,
                horizontal: Units.edgeInsetsXLarge,
              ),
          decoration: BoxDecoration(
            color: _getStatusColor(statusColor),
            borderRadius: BorderRadius.circular(Units.radiusXXLarge),
          ),
          child: Text(
            statusColor,
            style: statusStyle ??
                TextStyles.interRegularBody1.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
