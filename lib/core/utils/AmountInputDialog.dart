import 'package:flutter/material.dart';
import 'amount_input_dialog.dart';

Future<void> showAmountDialog(
    BuildContext context, String title, Function(double) onConfirm) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AmountInputDialog(title: title, onConfirm: onConfirm);
    },
  );
}
