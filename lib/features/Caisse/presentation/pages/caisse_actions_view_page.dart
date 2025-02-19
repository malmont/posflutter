import 'package:flutter/material.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';
import 'package:intl/intl.dart';
import '../../../../design/design.dart';

class CaisseActionsPage extends StatefulWidget {
  final Caisse? caisseDetails;
  final VoidCallback onOpenCaisse;
  final VoidCallback onCloseCaisse;
  final VoidCallback onWithdraw;
  final VoidCallback onDeposit;
  final VoidCallback onCashFundWithdraw;
  final VoidCallback onCashFundDeposit;

  const CaisseActionsPage({
    super.key,
    required this.caisseDetails,
    required this.onOpenCaisse,
    required this.onCloseCaisse,
    required this.onWithdraw,
    required this.onDeposit,
    required this.onCashFundWithdraw,
    required this.onCashFundDeposit,
  });

  @override
  State<CaisseActionsPage> createState() => _CaisseActionsPageState();
}

class _CaisseActionsPageState extends State<CaisseActionsPage> {
  String formaterDate(String dateString, {String format = 'yyyy-MM-dd'}) {
    try {
      DateTime date = DateTime.parse(dateString);
      DateFormat formatter = DateFormat(format);
      return formatter.format(date);
    } catch (e) {
      print('Erreur lors du formatage de la date : $e');
      return 'Date invalide';
    }
  }

  _isButtonActivated() {
    setState(() {
      widget.caisseDetails != null;
    });
    return widget.caisseDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primaryPalette,
      body: Column(
        children: [
          Expanded(
            flex: 4,
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
        child: widget.caisseDetails != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Caisse ouverte: ID ${widget.caisseDetails!.id}',
                    style: TextStyles.interBoldH6
                        .copyWith(color: Colours.colorsButtonMenu),
                  ),
                  const SizedBox(height: Units.sizedbox_10),
                  Text(
                    'Montant total : \$${double.parse((widget.caisseDetails!.amountTotal / 100).toStringAsFixed(2))}',
                    style: TextStyles.interRegularBody1
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: Units.sizedbox_10),
                  Text(
                    'Fond de caisse : \$${(widget.caisseDetails!.fondDeCaisse / 100).toStringAsFixed(2)}',
                    style: TextStyles.interRegularBody1
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: Units.sizedbox_10),
                  Text(
                    'Date de création : ${formaterDate(widget.caisseDetails!.createdAt)}',
                    style: TextStyles.interRegularBody1
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: Units.sizedbox_10),
                  Text(
                    'Statut : ${widget.caisseDetails!.isOpen ? "Ouverte" : "Fermée"}',
                    style: TextStyles.interBoldBody1.copyWith(
                        color: widget.caisseDetails!.isOpen
                            ? Colors.green
                            : Colors.red),
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
        padding: const EdgeInsets.all(Units.edgeInsetsXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: double.infinity,
              height: Units.u56,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed:
                    widget.caisseDetails == null ? widget.onOpenCaisse : null,
                child: const Text('Ouvrir Caisse',
                    style: TextStyles.interBoldBody1),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Units.u48,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed:
                    widget.caisseDetails != null ? widget.onCloseCaisse : null,
                child: const Text('Fermer Caisse',
                    style: TextStyles.interBoldBody1),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Units.u48,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed:
                    widget.caisseDetails != null ? widget.onDeposit : null,
                child: const Text('Dépôt', style: TextStyles.interBoldBody1),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Units.u48,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed:
                    widget.caisseDetails != null ? widget.onWithdraw : null,
                child: const Text('Retrait', style: TextStyles.interBoldBody1),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Units.u48,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed: widget.caisseDetails != null
                    ? widget.onCashFundDeposit
                    : null,
                child: const Text('Dépôt fond de caisse',
                    style: TextStyles.interBoldBody1),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Units.u48,
              child: ElevatedButton(
                style: CustomButtonStyle.customButtonStyle(
                  type: ButtonType.cancelButton,
                  isSelected: isSelected,
                ),
                onPressed: widget.caisseDetails != null
                    ? widget.onCashFundWithdraw
                    : null,
                child: const Text('Retrait fond de caisse',
                    style: TextStyles.interBoldBody1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
