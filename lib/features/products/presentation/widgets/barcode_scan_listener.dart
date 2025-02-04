import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/cart/application/blocs/cart_bloc.dart';
import 'package:pos_flutter/features/cart/domain/entities/cart_item.dart';
import 'package:pos_flutter/features/products/application/scannerblocs/scanner_bloc.dart';
import 'package:pos_flutter/features/products/domain/entities/product/product.dart';
import 'package:pos_flutter/features/products/domain/entities/product/variant.dart';
import 'package:pos_flutter/features/products/presentation/pages/product_details_view_page.dart';

class BarcodeScanListener extends StatefulWidget {
  final Widget child;

  const BarcodeScanListener({Key? key, required this.child}) : super(key: key);

  @override
  State<BarcodeScanListener> createState() => _BarcodeScanListenerState();
}

class _BarcodeScanListenerState extends State<BarcodeScanListener> {
  final FocusNode _focusNode = FocusNode();
  String _buffer = '';

  @override
  void initState() {
    super.initState();
    // S'assurer que ce widget a le focus après le build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  /// Méthode déclenchée quand on considère que le scan est terminé (Enter reçu)
  void _handleBarcodeScan(String scannedBarcode) {
    context.read<ScannerBloc>().add(ScanProductEvent(scannedBarcode));
  }

  /// Capte toutes les frappes clavier
  void _onKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final keyLabel = event.logicalKey.keyLabel;
      // Si on détecte Enter => fin du scan
      if (keyLabel == LogicalKeyboardKey.enter.keyLabel) {
        if (_buffer.isNotEmpty) {
          _handleBarcodeScan(_buffer);
          _buffer = '';
        }
      } else {
        _buffer += keyLabel;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Utilise un BlocListener pour réagir aux états du ScannerBloc en background
    return BlocListener<ScannerBloc, ScannerState>(
      listener: (context, state) {
        if (state is ScannerLoaded) {
          final productScanned = state.product;
          // Vérifie si le produit a un variant "simple"
          final Variant? simpleVariant = (productScanned.variants.length == 1 &&
                  productScanned.variants.first.color == null &&
                  productScanned.variants.first.size == null
              ? Variant(
                  id: productScanned.variants.first.id,
                  color: null,
                  size: null,
                  stockQuantity: productScanned.variants.first.stockQuantity,
                )
              : null);

          if (simpleVariant != null) {
            // Ajoute direct au panier
            context.read<CartBloc>().add(
                  AddProduct(
                    cartItem: CartItem(
                      product: productScanned,
                      variant: simpleVariant,
                    ),
                  ),
                );
            // Optionnel : message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${productScanned.name} ajouté au panier (scan)"),
              ),
            );
          } else {
            // Navigue vers page détails
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailsViewPage(
                  product: productScanned,
                  onBack: () => Navigator.of(context).pop(),
                ),
              ),
            );
          }
        } else if (state is ScannerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Produit non trouvé ou erreur réseau"),
            ),
          );
        }
      },
      // RawKeyboardListener pour intercepter les frappes
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _onKey,
        // On renvoie simplement le child passé
        child: widget.child,
      ),
    );
  }
}
