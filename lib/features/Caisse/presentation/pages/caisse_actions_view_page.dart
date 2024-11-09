import 'package:flutter/material.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';

import '../../../../design/design.dart';

class CaisseActionsPage extends StatelessWidget {
  final Caisse? caisseDetails;
  final VoidCallback onOpenCaisse;
  final VoidCallback onCloseCaisse;
  final VoidCallback onWithdraw;
  final VoidCallback onDeposit;

  const CaisseActionsPage({
    super.key,
    required this.caisseDetails,
    required this.onOpenCaisse,
    required this.onCloseCaisse,
    required this.onWithdraw,
    required this.onDeposit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primaryPalette,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: _buildCaisseInfoCard(),
          ),
          Expanded(
            flex: 7,
            child: _buildActionsCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildCaisseInfoCard() {
    return Card(
      color: Colours.primary100,
      elevation: 5,
      margin: const EdgeInsets.all(Units.edgeInsetsXXLarge),
      child: Padding(
        padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
        child: caisseDetails != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Caisse ouverte en cours: ID ${caisseDetails!.id}',
                    style: TextStyles.interBoldH6
                        .copyWith(color: Colours.colorsButtonMenu),
                  ),
                  const SizedBox(height: Units.sizedbox_20),
                  Text(
                    'Montant total : \$${(caisseDetails!.amountTotal / 100).toStringAsFixed(2)}',
                    style: TextStyles.interRegularBody1
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: Units.sizedbox_20),
                  Text(
                    'Date de création : ${caisseDetails!.createdAt}',
                    style: TextStyles.interRegularBody1
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: Units.sizedbox_20),
                  Text(
                    'Statut : ${caisseDetails!.isOpen ? "Ouverte" : "Fermée"}',
                    style: TextStyles.interBoldBody1.copyWith(
                        color:
                            caisseDetails!.isOpen ? Colors.green : Colors.red),
                  ),
                ],
              )
            : Center(
                child: Text(
                  'Pas de caisse ouverte',
                  style: TextStyles.interBoldH5.copyWith(color: Colors.red),
                ),
              ),
      ),
    );
  }

  Widget _buildActionsCard() {
    bool isSelected = false;
    return Card(
      color: Colours.primary100,
      elevation: 5,
      margin: const EdgeInsets.all(Units.edgeInsetsXXLarge),
      child: Padding(
        padding: const EdgeInsets.all(Units.edgeInsetsXXXXXXXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: double.infinity,
              height: Units.u64,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed: caisseDetails == null ? onOpenCaisse : null,
                child:
                    const Text('Ouvrir Caisse', style: TextStyles.interBoldH6),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Units.u64,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed: caisseDetails != null ? onCloseCaisse : null,
                child:
                    const Text('Fermer Caisse', style: TextStyles.interBoldH6),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Units.u64,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed: caisseDetails != null ? onDeposit : null,
                child: const Text('Dépôt', style: TextStyles.interBoldH6),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Units.u64,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed: caisseDetails != null ? onWithdraw : null,
                child: const Text('Retrait', style: TextStyles.interBoldH6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
