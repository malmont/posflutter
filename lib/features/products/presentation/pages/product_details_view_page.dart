import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/features/cart/application/blocs/cart_bloc.dart';
import 'package:pos_flutter/features/cart/domain/entities/cart_item.dart';
import 'package:pos_flutter/features/products/application/blocs/product_bloc.dart';
import 'package:pos_flutter/features/products/domain/entities/product/product.dart';
import 'package:pos_flutter/features/products/domain/entities/product/variant.dart';
import 'package:pos_flutter/features/products/presentation/widgets/carousel_indicator.dart';
import 'package:pos_flutter/features/products/presentation/widgets/product_details_bottom_bar.dart';
import 'package:pos_flutter/features/products/presentation/widgets/product_image_carousel.dart';
import 'package:pos_flutter/features/products/presentation/widgets/variant_info.dart';
import 'package:pos_flutter/features/products/presentation/widgets/variant_selector.dart';

import '../../../../design/design.dart';

class ProductDetailsViewPage extends StatefulWidget {
  final Product product;
  final VoidCallback onBack; // Add this parameter

  const ProductDetailsViewPage({
    super.key,
    required this.product,
    required this.onBack, // Add the onBack callback
  });

  @override
  State<ProductDetailsViewPage> createState() => _ProductDetailsViewPageState();
}

class _ProductDetailsViewPageState extends State<ProductDetailsViewPage> {
  int _currentIndex = 0;
  String? selectedColor;
  String? selectedSize;
  Variant? selectedVariant; // Declare selectedVariant here
  late ProductBloc productBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productBloc = BlocProvider.of<ProductBloc>(context);
  }

  @override
  void dispose() {
    productBloc.add(const ResetVariantEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uniqueColors = widget.product.variants
        .map((variant) => variant.color.codeHexa)
        .toSet()
        .toList();
    final uniqueSizes = widget.product.variants
        .map((variant) => variant.size.name)
        .toSet()
        .toList();

    return Scaffold(
      backgroundColor: Colours.primary100,
      appBar: AppBar(
        backgroundColor: Colours.primary100,
        title: Text(widget.product.name,
            style: TextStyles.interMediumH4
                .copyWith(color: Colours.colorsButtonMenu)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colours.colorsButtonMenu,
          ),
          onPressed: widget.onBack,
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductError) {
            EasyLoading.showSuccess("Variant non trouvé");
            Future.delayed(const Duration(seconds: 2), () {
              EasyLoading.dismiss();
              Navigator.pop(context);
            });
          }

          if (state is ProductLoaded) {
            selectedVariant = state.selectedVariant;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageCarousel(
                    product: widget.product,
                    currentIndex: _currentIndex,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  Center(
                    child: CarouselIndicator(
                      currentIndex: _currentIndex,
                      itemCount: 2,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyles.interMediumH5.copyWith(
                          color: Colours.colorsButtonMenu,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        '\$${(widget.product.price / 100).toStringAsFixed(2)}',
                        style: TextStyles.interMediumH5.copyWith(
                          color: Colours.colorsButtonMenu,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  VariantSelector(
                    uniqueColors: uniqueColors,
                    uniqueSizes: uniqueSizes,
                    product: widget.product,
                    productBloc: productBloc,
                    selectedColor: selectedColor,
                    selectedSize: selectedSize,
                  ),
                  const SizedBox(height: 10),
                  if (selectedVariant != null)
                    VariantInfo(selectedVariant: selectedVariant!)
                  else
                    const Text('Aucun variant sélectionné'),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          Variant? selectedVariant =
              state is ProductLoaded ? state.selectedVariant : null;
          bool isSelected = true;

          return ProductDetailsBottomBar(
            product: widget.product,
            selectedVariant: selectedVariant,
            onPressed: selectedVariant != null
                ? () {
                    context.read<CartBloc>().add(AddProduct(
                        cartItem: CartItem(
                            product: widget.product,
                            variant: selectedVariant!)));

                    context.read<ProductBloc>().add(const ResetVariantEvent());
                    // widget.onBack();
                  }
                : null,
          );
        },
      ),
    );
  }
}
