import 'package:flutter/material.dart';
import 'package:pos_flutter/features/order/domain/entities/payment_method.dart';
import 'package:pos_flutter/features/order/presentation/widgets/payment_method_selection.dart';

import '../../../../design/design.dart';

class MultiPaymentDialog extends StatefulWidget {
  final double totalAmount;
  final Function(List<PaymentMethod>) onPaymentComplete;

  const MultiPaymentDialog({
    super.key,
    required this.totalAmount,
    required this.onPaymentComplete,
  });

  @override
  _MultiPaymentDialogState createState() => _MultiPaymentDialogState();
}

class _MultiPaymentDialogState extends State<MultiPaymentDialog> {
  double remainingAmount = 0.0;
  final List<PaymentMethod> selectedPayments = [];

  @override
  void initState() {
    super.initState();
    remainingAmount = widget.totalAmount;
  }

  Future<int?> _showPaymentMethodDialog(BuildContext context) async {
    int? selectedMethod;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Sélectionnez un mode de paiement',
            style: TextStyles.interBoldH6.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 200,
            child: PaymentMethodSelection(
              onSelectMethod: (method) {
                selectedMethod = method;
                Navigator.pop(context);
              },
              selectedMethodId: null,
              showMultiPaymentOption: false,
            ),
          ),
        );
      },
    );

    return selectedMethod;
  }

  Future<double?> _showPaymentAmountDialog(
      BuildContext context, int paymentMethod) async {
    double enteredAmount = 0.0;

    return showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Entrez le montant pour le mode $paymentMethod',
            style: TextStyles.interBoldH6.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:
                        'Montant restant : \$${remainingAmount.toStringAsFixed(2)}',
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
                  style: TextStyles.interRegularBody1.copyWith(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    enteredAmount = double.tryParse(value) ?? 0.0;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text(
                'Annuler',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, enteredAmount),
              style: TextButton.styleFrom(
                backgroundColor: Colours.colorsButtonMenu,
              ),
              child: const Text(
                'Confirmer',
                style: TextStyle(color: Colours.primaryPalette),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showChangeDialog(BuildContext context, double change) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Monnaie à rendre',
            style: TextStyles.interBoldH6,
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Rendre \$${change.toStringAsFixed(2)} au client.',
            style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colours.colorsButtonMenu,
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Colours.primaryPalette),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showExcessAmountDialog(
      BuildContext context, double remainingAmount) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Montant trop élevé',
            style: TextStyles.interBoldH6,
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Le montant saisi dépasse le montant restant à payer : \$${remainingAmount.toStringAsFixed(2)}.',
            style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colours.colorsButtonMenu,
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Colours.primaryPalette),
              ),
            ),
          ],
        );
      },
    );
  }

  void _processMultiPayment(BuildContext context) async {
    double remainingPayment = 0.0;
    while (remainingAmount > 0) {
      final selectedPaymentMethod = await _showPaymentMethodDialog(context);
      if (selectedPaymentMethod == null) break;

      final enteredAmount = await _showPaymentAmountDialog(
        context,
        selectedPaymentMethod,
      );

      if (enteredAmount == null || enteredAmount <= 0) break;
      setState(() {
        remainingPayment = remainingAmount - enteredAmount;
      });
      if (remainingPayment <= 0 && selectedPaymentMethod == 1) {
        await _showExcessAmountDialog(context, remainingAmount);
        break;
      }
      if (remainingPayment <= 0 && selectedPaymentMethod == 2) {
        final change = -remainingPayment;
        if (change > 0) {
          await _showChangeDialog(context, change);
        }
      }
      setState(() {
        final adjustedAmount =
            (remainingAmount < enteredAmount) ? remainingAmount : enteredAmount;

        selectedPayments.add(
          PaymentMethod(
            type: selectedPaymentMethod,
            amount: adjustedAmount,
          ),
        );

        remainingAmount -= adjustedAmount;
      });
    }

    if (remainingAmount <= 0) {
      Navigator.pop(context, selectedPayments);
    } else {
      Navigator.pop(context, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Scaffold(
          backgroundColor: Colours.primaryPalette,
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'MultiPaiement',
                    style: TextStyles.interBoldH6.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Montant total : \$${widget.totalAmount.toStringAsFixed(2)}',
                    style: TextStyles.interRegularBody1
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Montant restant : \$${remainingAmount.toStringAsFixed(2)}',
                    style: TextStyles.interBoldBody1.copyWith(
                      color: Colours.colorsButtonMenu,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _processMultiPayment(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.colorsButtonMenu,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Commencer',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
