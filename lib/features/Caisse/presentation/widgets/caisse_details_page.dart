import 'package:flutter/material.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/transaction_caisse.dart';
import 'package:pos_flutter/features/Caisse/presentation/widgets/cash_details_page.dart';
import 'package:pos_flutter/widget/detail_row.dart';

import '../../../../design/design.dart';

class CaisseDetailsPage extends StatefulWidget {
  final Caisse caisseDetails;
  final VoidCallback onBack;

  const CaisseDetailsPage({
    Key? key,
    required this.caisseDetails,
    required this.onBack,
  }) : super(key: key);

  @override
  State<CaisseDetailsPage> createState() => _CaisseDetailsPageState();
}

class _CaisseDetailsPageState extends State<CaisseDetailsPage> {
  TransactionCaisse? selectedTransaction;

  void navigateToTransactionDetails(TransactionCaisse transaction) {
    setState(() {
      selectedTransaction = transaction;
    });
  }

  void goBackToTransactionList() {
    setState(() {
      selectedTransaction = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Scaffold(
            backgroundColor: Colours.primary100,
            appBar: AppBar(
              backgroundColor: Colours.primary100,
              title: Text(
                'Transactions Caisse',
                style: TextStyles.interRegularH5
                    .copyWith(color: Colours.colorsButtonMenu),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBack,
              ),
            ),
            body: selectedTransaction == null
                ? _buildTransactionList()
                : CashDetailsPage(
                    transaction: selectedTransaction!,
                    onBack: goBackToTransactionList,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      itemCount: widget.caisseDetails.transactionCaisses.length,
      itemBuilder: (context, index) {
        final transaction = widget.caisseDetails.transactionCaisses[index];
        return GestureDetector(
          onTap: () => navigateToTransactionDetails(transaction),
          child: Card(
            color: Colours.primaryPalette,
            elevation: 3,
            margin: const EdgeInsets.symmetric(
                vertical: Units.edgeInsetsLarge,
                horizontal: Units.edgeInsetsLarge),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Units.edgeInsetsLarge),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildDetailsRow(
                      'Montant',
                      '\$${(transaction.amount / 100).toStringAsFixed(2)}',
                      transaction.amount > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildDetailsRow(
                      'Date',
                      transaction.transactionDate,
                      Colours.colorsButtonMenu,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildDetailsRow(
                      'Type',
                      transaction.transactionType,
                      transaction.amount > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailsRow(String label, String value, Color valueColor) {
    return DetailsRow(
      label: label,
      value: value,
      labelStyle: TextStyles.interRegularBody1.copyWith(color: Colors.white),
      valueStyle: TextStyles.interRegularBody1.copyWith(color: valueColor),
    );
  }
}
