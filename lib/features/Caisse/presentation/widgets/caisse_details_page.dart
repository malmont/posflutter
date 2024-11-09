import 'package:flutter/material.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';

import '../../../../design/design.dart';

class CaisseDetailsPage extends StatelessWidget {
  final Caisse caisseDetails;
  final VoidCallback onBack;

  const CaisseDetailsPage({
    Key? key,
    required this.caisseDetails,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary100,
      appBar: AppBar(
        backgroundColor: Colours.primary100,
        title: Text(
          'Détails de la Caisse',
          style: TextStyles.interRegularH5
              .copyWith(color: Colours.colorsButtonMenu),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCaisseInfo(),
            const SizedBox(height: Units.sizedbox_20),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCaisseInfo() {
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
              'ID de la caisse : ${caisseDetails.id}',
              style: TextStyles.interBoldH6
                  .copyWith(color: Colours.colorsButtonMenu),
            ),
            const SizedBox(height: Units.sizedbox_10),
            Text(
              'Montant total : \$${(caisseDetails.amountTotal / 100).toStringAsFixed(2)}',
              style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
            ),
            const SizedBox(height: Units.sizedbox_10),
            Text(
              'Date de création : ${caisseDetails.createdAt}',
              style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
            ),
            const SizedBox(height: Units.sizedbox_10),
            Text(
              'Statut : ${caisseDetails.isOpen ? "Ouverte" : "Fermée"}',
              style: TextStyles.interRegularBody1.copyWith(
                  color: caisseDetails.isOpen ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: ListView.builder(
        itemCount: caisseDetails.transactionCaisses.length,
        itemBuilder: (context, index) {
          final transaction = caisseDetails.transactionCaisses[index];
          return Card(
            color: Colours.primaryPalette,
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: Units.edgeInsetsLarge),
            child: ListTile(
              leading: Icon(
                Icons.monetization_on,
                color: transaction.amount > 0 ? Colors.green : Colors.red,
              ),
              title: Text(
                'Montant : \$${(transaction.amount / 100).toStringAsFixed(2)}',
                style: TextStyles.interBoldH6.copyWith(color: Colors.white),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date : ${transaction.transactionDate}',
                    style: TextStyles.interRegularBody1
                        .copyWith(color: Colours.colorsButtonMenu),
                  ),
                  Text(
                    'Type : ${transaction.transactionType}',
                    style: TextStyles.interRegularBody1.copyWith(
                      color: transaction.amount > 0 ? Colors.green : Colors.red,
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
}
