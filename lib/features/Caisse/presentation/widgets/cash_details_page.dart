import 'package:flutter/material.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/transaction_caisse.dart';
import 'package:pos_flutter/widget/detail_row.dart';
import '../../../../design/design.dart';

class CashDetailsPage extends StatelessWidget {
  final TransactionCaisse transaction;
  final VoidCallback onBack;

  const CashDetailsPage({
    Key? key,
    required this.transaction,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary100,
      appBar: AppBar(
        backgroundColor: Colours.primary100,
        title: Text(
          'Détails de la transaction',
          style: TextStyles.interRegularH5
              .copyWith(color: Colours.colorsButtonMenu),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack, // Utilisation de onBack pour gérer le retour
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionInfo(),
            const SizedBox(height: Units.sizedbox_20),
            _buildCashDetailsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionInfo() {
    return Card(
      color: Colours.primaryPalette,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: Units.edgeInsetsXLarge),
      child: Padding(
        padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Montant : \$${(transaction.amount / 100).toStringAsFixed(2)}',
              style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
            ),
            const SizedBox(height: Units.sizedbox_10),
            Text(
              'Date : ${transaction.transactionDate}',
              style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
            ),
            const SizedBox(height: Units.sizedbox_10),
            Text(
              'Type : ${transaction.transactionType}',
              style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCashDetailsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: transaction.cashDetails.length,
        itemBuilder: (context, index) {
          final cashDetail = transaction.cashDetails[index];
          return Card(
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
                      'Type cash',
                      cashDetail.typeCash,
                      Colours.colorsButtonMenu,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildDetailsRow(
                      'Montant',
                      '\$${(cashDetail.total / 100).toStringAsFixed(2)}',
                      Colours.colorsButtonMenu,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildDetailsRow(
                      'Quantité',
                      '${cashDetail.nombreItems}',
                      Colours.colorsButtonMenu,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
