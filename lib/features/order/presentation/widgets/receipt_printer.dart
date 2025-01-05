import 'package:pos_flutter/features/cart/domain/entities/cart_item.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_column.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class ReceiptPrinter {
  /// Prints the receipt
  static Future<void> printReceipt({
    required String storeName,
    required List<CartItem> items,
    required double totalAmount,
    required double cashGiven,
  }) async {
    final change = cashGiven - totalAmount;
    final SunmiPrinterPlus sunmiPrinterPlus = SunmiPrinterPlus();
    // Initialize the printer and begin the transaction
    // await SunmiPrinter.initPrinter();
    // await SunmiPrinter.startTransactionPrint(true);

    // Print header
    await SunmiPrinter.printText(storeName,
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
          fontSize: 40,
        ));
    await SunmiPrinter.printText('Receipt',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
          fontSize: 40,
        ));
    await SunmiPrinter.printText('------------------------------');

    //Print items
    for (final item in items) {
      await sunmiPrinterPlus.printRow(cols: [
        SunmiColumn(
          text: item.product.name,
          width: 6, // Nom du produit
          style: SunmiTextStyle(
            align: SunmiPrintAlign.LEFT,
          ),
        ),
        SunmiColumn(
          text: '\$${item.product.price.toStringAsFixed(2)}',
          width: 3, // Prix
          style: SunmiTextStyle(
            align: SunmiPrintAlign.CENTER,
          ),
        ),
        SunmiColumn(
          text: 'x${item.quantity}',
          width: 3, // Quantité
          style: SunmiTextStyle(
            align: SunmiPrintAlign.RIGHT,
          ),
        ),
      ]);
    }
    await SunmiPrinter.printText('Items',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
          fontSize: 30,
        ));
    await SunmiPrinter.printText('------------------------------');

    for (final item in items) {
      String name = item.product.name.length > 13
          ? '${item.product.name.substring(0, 13)}...'
          : item.product.name.padRight(20);
      String price =
          '\$${(item.product.price / 100).toStringAsFixed(2)}'.padLeft(10);
      String quantity = 'x${item.quantity}'.padLeft(5);

      await SunmiPrinter.printText('$name$price$quantity',
          style: SunmiTextStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: 26,
          ));
    }

    await SunmiPrinter.printText('------------------------------');

    await SunmiPrinter.printText('Total: \$${totalAmount.toStringAsFixed(2)}');
    await SunmiPrinter.printText(
        'Cash Given: \$${cashGiven.toStringAsFixed(2)}');
    await SunmiPrinter.printText('Change: \$${change.toStringAsFixed(2)}');
    await SunmiPrinter.printText('------------------------------');

    await SunmiPrinter.printBarCode(
      '1234567890',
      style: SunmiBarcodeStyle(
          align: SunmiPrintAlign.CENTER,
          height: 100,
          size: 2,
          type: SunmiBarcodeType.CODE39,
          textPos: SunmiBarcodeTextPos.NO_TEXT),
    );
    await SunmiPrinter.printText('------------------------------');

    // Print footer
    await SunmiPrinter.printText('Thank you for your purchase!',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
          fontSize: 20,
        ));
    // End the receipt transaction
    SunmiPrinter.cutPaper();
    await SunmiPrinter.exitTransactionPrint(true);
  }
}

class ReceiptPrinterTest {
  /// Prints the receipt
  static Future<void> printReceipt() async {
    // Initialize the printer and begin the transaction
    // await SunmiPrinter.initPrinter();
    // await SunmiPrinter.startTransactionPrint(true);

    // Print header
    await SunmiPrinter.printText('storeName',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
          fontSize: 40,
        ));
    await SunmiPrinter.printText('Receipt',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
          fontSize: 40,
        ));
    await SunmiPrinter.printText('------------------------------');

    // Print items

    await SunmiPrinter.printText('------------------------------');

    await SunmiPrinter.printRow(cols: [
      SunmiColumn(
        text: 'Item',
        width: 6,
        style: SunmiTextStyle(
          align: SunmiPrintAlign.LEFT,
        ),
      ),
      SunmiColumn(
        text: 'Price',
        width: 6,
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
        ),
      ),
    ]);

    await SunmiPrinter.printBarCode(
      '1234567890',
      style: SunmiBarcodeStyle(
          align: SunmiPrintAlign.RIGHT,
          height: 100,
          size: 2,
          type: SunmiBarcodeType.CODABAR,
          textPos: SunmiBarcodeTextPos.NO_TEXT),
    );
    await SunmiPrinter.printText('------------------------------');
    // Print footer
    await SunmiPrinter.printText('Thank you for your purchase!',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
          fontSize: 20,
        ));
    // End the receipt transaction
    SunmiPrinter.cutPaper();
    await SunmiPrinter.exitTransactionPrint(true);
  }
}
