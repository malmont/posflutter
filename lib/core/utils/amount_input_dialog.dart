import 'package:flutter/material.dart';

class AmountInputDialog extends StatelessWidget {
  final String title;
  final Function(double) onConfirm;

  AmountInputDialog({
    Key? key,
    required this.title,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController amountController = TextEditingController();

    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text('Veuillez entrer le montant en centimes:'),
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                prefixText: '\$', // Indication de la devise
                hintText: 'Montant en centimes',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Confirmer'),
          onPressed: () {
            double amountInCents =
                double.tryParse(amountController.text) ?? 0.0;
            double amountInDollars =
                amountInCents * 100; // Conversion en dollars
            Navigator.of(context).pop();
            onConfirm(amountInDollars);
          },
        ),
      ],
    );
  }
}
