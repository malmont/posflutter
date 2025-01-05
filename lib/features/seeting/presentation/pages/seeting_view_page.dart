import 'package:flutter/material.dart';
import 'package:pos_flutter/features/cart/domain/entities/cart_item.dart';
import 'package:pos_flutter/features/order/presentation/widgets/receipt_printer.dart';
import 'package:pos_flutter/features/products/domain/entities/product/product.dart';

class SeatingViewPage extends StatelessWidget {
  const SeatingViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to SeatingViewPage'),
            ElevatedButton(
                onPressed: () async {
                  await ReceiptPrinterTest.printReceipt();
                },
                child: Text('print'))
          ],
        ),
      ),
    );
  }
}
