import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/cart/domain/entities/cart_item.dart';
import 'package:pos_flutter/features/cart/presentation/widgets/input_form_button.dart';
import 'package:pos_flutter/features/order/application/blocs/order_bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/domain/entities/order_detail_response.dart';
import 'package:pos_flutter/features/order/domain/entities/payment_method.dart';
import 'package:pos_flutter/features/order/presentation/widgets/multi_payment_dialog.dart';
import 'package:pos_flutter/features/order/presentation/widgets/receipt_printer.dart';

import '../../../../design/design.dart';

class BottomNavigationBarWithCashDialog extends StatelessWidget {
  final int? selectedPaymentMethodId;
  final List<CartItem> items;
  final Function(OrderDetailResponse) onAddOrder;
  final double totalAmount;
  final int? typeOrder;

  const BottomNavigationBarWithCashDialog({
    super.key,
    required this.selectedPaymentMethodId,
    required this.items,
    required this.onAddOrder,
    required this.totalAmount,
    required this.typeOrder,
  });

  Future<double?> _showCashDialog(
      BuildContext context, double totalAmount) async {
    double enteredAmount = 0.0;
    return showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Coins arrondis
          ),
          title: Text(
            'Montant en espèces',
            style: TextStyles.interBoldH6.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Montant total : \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyles.interRegularBody1
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Entrez le montant donné par le client',
                    labelStyle: TextStyles.interRegularBody1
                        .copyWith(color: Colors.white),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colours.colorsButtonMenu),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyles.interRegularBody1
                      .copyWith(color: Colors.white),
                  onChanged: (value) {
                    enteredAmount = double.tryParse(value) ?? 0.0;
                  },
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, null); // Annule
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Annuler'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, enteredAmount); // Valide
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colours.colorsButtonMenu,
                      foregroundColor: Colours.primaryPalette,
                    ),
                    child: const Text('Valider'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showChangeDialog(
      BuildContext context, double cashGiven, double totalAmount) async {
    final change = cashGiven - totalAmount;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Coins arrondis
          ),
          title: Text(
            'Rendre la monnaie',
            style: TextStyles.interBoldH6.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.8, // Largeur 80% de l'écran
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Montant donné : \$${cashGiven.toStringAsFixed(2)}',
                  style: TextStyles.interRegularBody1
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Montant total : \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyles.interRegularBody1
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Monnaie à rendre : \$${change.toStringAsFixed(2)}',
                  style: TextStyles.interBoldBody1
                      .copyWith(color: Colours.colorsButtonMenu),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Ferme le popup
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colours.colorsButtonMenu,
                  foregroundColor: Colours.primaryPalette,
                ),
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInsufficientAmountDialog(
      BuildContext context, double totalAmount, double cashGiven) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Coins arrondis
          ),
          title: Text(
            'Montant insuffisant',
            style: TextStyles.interBoldH6.copyWith(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Montant total : \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyles.interRegularBody1
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Montant donné : \$${cashGiven.toStringAsFixed(2)}',
                  style: TextStyles.interRegularBody1
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Veuillez entrer un montant suffisant.',
                  style: TextStyles.interBoldBody1
                      .copyWith(color: Colours.colorsButtonMenu),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Ferme la boîte de dialogue
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colours.colorsButtonMenu,
                  foregroundColor: Colours.primaryPalette,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Coins arrondis
          ),
          title: Text(
            'Erreur',
            style: TextStyles.interBoldH6.copyWith(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.8, // Largeur 80% de l'écran
            child: Text(
              'Échec de l\'ajout de la commande.',
              style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Ferme le popup
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colours.colorsButtonMenu,
                  foregroundColor: Colours.primaryPalette,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleAddOrder(BuildContext context) async {
    List<CartItem> itemsThis = new List<CartItem>.from(items);
    if (selectedPaymentMethodId == 4) {
      // MultiPaiement sélectionné
      final payments = await showDialog<List<PaymentMethod>>(
        context: context,
        builder: (context) {
          return MultiPaymentDialog(
            totalAmount: totalAmount,
            onPaymentComplete: (payments) {
              Navigator.pop(context, payments);
            },
          );
        },
      );

      if (payments != null && payments.isNotEmpty) {
        context.read<OrderBloc>().add(
              AddOrder(
                OrderDetailResponse(
                  orderSource: 2,
                  addressId: 38,
                  paymentMethods: payments,
                  carrierId: 7,
                  typeOrder: typeOrder ?? 1,
                  items: items
                      .map(
                        (e) => OrderItemDetail(
                          productVariantId: e.variant.id,
                          quantity: e.quantity,
                        ),
                      )
                      .toList(),
                ),
              ),
            );

        // Écouter les changements d'état pour l'impression
        context.read<OrderBloc>().stream.listen((state) async {
          if (state is OrderAddSuccess) {
            await ReceiptPrinter.printReceipt(
              storeName: 'Votre magasin',
              items: itemsThis,
              totalAmount: totalAmount,
              cashGiven: 0.0, // Montant donné n'est pas pertinent ici
            );
          }
        });
      }
    } else if (selectedPaymentMethodId == 2) {
      // Paiement en espèces
      final cashGiven = await _showCashDialog(context, totalAmount);
      if (cashGiven != null) {
        if (cashGiven < totalAmount) {
          // Montant donné insuffisant
          await _showInsufficientAmountDialog(context, totalAmount, cashGiven);
        } else {
          context.read<OrderBloc>().add(
                AddOrder(
                  OrderDetailResponse(
                    orderSource: 2,
                    addressId: 38,
                    paymentMethods: [
                      PaymentMethod(
                        type: selectedPaymentMethodId ?? 1,
                        amount: totalAmount ?? 0.0,
                      ),
                    ],
                    carrierId: 7,
                    typeOrder: typeOrder ?? 1,
                    items: items
                        .map(
                          (e) => OrderItemDetail(
                            productVariantId: e.variant.id,
                            quantity: e.quantity,
                          ),
                        )
                        .toList(),
                  ),
                ),
              );

          context.read<OrderBloc>().stream.listen((state) async {
            if (state is OrderAddSuccess) {
              await _showChangeDialog(context, cashGiven, totalAmount);
              await ReceiptPrinter.printReceipt(
                storeName: 'Votre magasin',
                items: itemsThis,
                totalAmount: totalAmount,
                cashGiven: cashGiven,
              );
            } else if (state is OrderAddFailure) {
              await _showErrorDialog(context);
            }
          });
        }
      }
    } else {
      // Paiement autre que espèces
      context.read<OrderBloc>().add(
            AddOrder(
              OrderDetailResponse(
                orderSource: 2,
                addressId: 38,
                paymentMethods: [
                  PaymentMethod(
                    type: selectedPaymentMethodId ?? 1,
                    amount: totalAmount ?? 0.0,
                  ),
                ],
                carrierId: 7,
                typeOrder: typeOrder ?? 1,
                items: items
                    .map(
                      (e) => OrderItemDetail(
                        productVariantId: e.variant.id,
                        quantity: e.quantity,
                      ),
                    )
                    .toList(),
              ),
            ),
          );

      context.read<OrderBloc>().stream.listen((state) async {
        if (state is OrderAddSuccess) {
          await ReceiptPrinter.printReceipt(
            storeName: 'Votre magasin',
            items: itemsThis,
            totalAmount: totalAmount,
            cashGiven: 0.0, // Montant donné n'est pas pertinent ici
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: InputFormButton(
          color: Colors.black87,
          onClick: () => _handleAddOrder(context),
          titleText: 'Confirm',
        ),
      ),
    );
  }
}

class TaxRates {
  static const double tpsRate = 0.05; // TPS (5 %)
  static const double tvqRate = 0.10; // TVQ (10 %)
}
