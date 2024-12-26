import 'package:flutter/material.dart';
import 'package:pos_flutter/features/products/domain/entities/product/variant.dart';

import '../../../../design/design.dart';

class VariantInfo extends StatelessWidget {
  final Variant selectedVariant;

  const VariantInfo({super.key, required this.selectedVariant});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Couleur",
              style: TextStyles.interBoldBody1.copyWith(
                color: Colours.primaryPalette,
              ),
            ),
            Text(
              ' ${selectedVariant.color.name}',
              style: TextStyles.interBoldBody1.copyWith(
                color: Colours.colorsButtonMenu,
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
        Column(
          children: [
            Text(
              "Taille",
              style: TextStyles.interBoldBody1.copyWith(
                color: Colours.primaryPalette,
              ),
            ),
            Text(
              selectedVariant.size.name,
              style: TextStyles.interBoldBody1.copyWith(
                color: Colours.colorsButtonMenu,
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quantité en stock",
              style: TextStyles.interBoldBody1.copyWith(
                color: Colours.primaryPalette,
              ),
            ),
            Text(
              '${selectedVariant.stockQuantity}',
              style: TextStyles.interBoldBody1.copyWith(
                color: Colours.colorsButtonMenu,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
