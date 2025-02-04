import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/features/products/application/blocs/product_bloc.dart';
import 'package:pos_flutter/features/products/domain/entities/product/product.dart';

import '../../../../design/design.dart';

class VariantSelector extends StatefulWidget {
  final List<String> uniqueColors;
  final List<String> uniqueSizes;
  final Product product;
  final ProductBloc productBloc;
  final String? selectedColor;
  final String? selectedSize;

  const VariantSelector({
    super.key,
    required this.uniqueColors,
    required this.uniqueSizes,
    required this.product,
    required this.productBloc,
    this.selectedColor,
    this.selectedSize,
  });

  @override
  _VariantSelectorState createState() => _VariantSelectorState();
}

class _VariantSelectorState extends State<VariantSelector> {
  String? selectedColor;
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.selectedColor;
    selectedSize = widget.selectedSize;
  }

  List<String> getAvailableSizes(String color) {
    return widget.product.variants
        .where((variant) => variant.color?.codeHexa == color)
        .map((variant) => variant.size?.name ?? "Aucune")
        .toSet()
        .toList();
  }

  List<String> getAvailableColors(String size) {
    return widget.product.variants
        .where((variant) => variant.size?.name == size)
        .map((variant) => variant.color?.codeHexa ?? "#CCCCCC")
        .toSet()
        .toList();
  }

  Color getColorFromHex(String colorString) {
    return Color(
        int.parse(colorString.replaceFirst('#', ''), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    final availableSizes = selectedColor != null
        ? getAvailableSizes(selectedColor!)
        : widget.uniqueSizes;
    final availableColors = selectedSize != null
        ? getAvailableColors(selectedSize!)
        : widget.uniqueColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Size Selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Taille',
              style: TextStyles.interBoldBody1.copyWith(
                color: Colours.primaryPalette,
              ),
            ),
            const SizedBox(width: Units.sizedbox_10),
            Wrap(
              children: availableSizes.map((size) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                      final newAvailableColors = getAvailableColors(size);
                      if (selectedColor != null &&
                          !newAvailableColors.contains(selectedColor)) {
                        selectedColor = null;
                        EasyLoading.showInfo(
                            "La couleur sélectionnée n'est plus disponible pour cette taille.");
                      }
                      if (selectedColor != null) {
                        widget.productBloc.add(SelectVariantEvent(
                          productId: widget.product.id,
                          color: selectedColor!,
                          size: selectedSize!,
                        ));
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedSize == size
                            ? Colours.colorsButtonMenu
                            : Colours.primaryPalette,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(size.substring(0, 1)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(width: Units.sizedbox_50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Couleur',
              style: TextStyles.interBoldBody1.copyWith(
                color: Colours.primaryPalette,
              ),
            ),
            const SizedBox(width: 20),
            Wrap(
              children: availableColors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                      final newAvailableSizes = getAvailableSizes(color);

                      if (selectedSize != null &&
                          !newAvailableSizes.contains(selectedSize)) {
                        selectedSize = null;
                        EasyLoading.showInfo(
                            "La taille sélectionnée n'est plus disponible pour cette couleur.");
                      }

                      if (selectedSize != null) {
                        widget.productBloc.add(SelectVariantEvent(
                          productId: widget.product.id,
                          color: selectedColor!,
                          size: selectedSize!,
                        ));
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColorFromHex(color),
                      border: selectedColor == color
                          ? Border.all(
                              color: Colours.colorsButtonMenu, width: 2)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(width: 50),
        ElevatedButton(
          style: CustomButtonStyle.customButtonStyle(
              type: ButtonType.cancelButton,
              isSelected: selectedColor != null && selectedSize != null),
          onPressed: () {
            setState(() {
              selectedColor = null;
              selectedSize = null;
            });
            widget.productBloc.add(const ResetVariantEvent());
          },
          child: const Text("Réinitialiser la sélection"),
        ),
      ],
    );
  }
}
