import 'package:flutter/material.dart';
import 'package:pos_flutter/design/colours.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/cash_details_response_model.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/transaction_caisse_response_model.dart';

import '../../../../design/design.dart';

void showTransactionDialog({
  required BuildContext context,
  required String title,
  required double amountTotalCaisse,
  required double amountTotalCashFund,
  required void Function(TransactionCaisseResponseModel) onSubmit,
}) {
  List<CashDetailResponseModel> cashDetails = [];

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          void addCashDetail() {
            setState(() {
              cashDetails.add(
                  const CashDetailResponseModel(typeCash: 1, nombreItems: 0));
            });
          }

          void removeCashDetail(int index) {
            setState(() {
              cashDetails.removeAt(index);
            });
          }

          void updateCashDetail(
              int index, CashDetailResponseModel updatedDetail) {
            setState(() {
              cashDetails[index] = updatedDetail;
            });
          }

          double calculateTotalAmount() {
            const values = {
              1: 100.0, // Billet de 100$
              2: 50.0, // Billet de 50$
              3: 10.0, // Billet de 10$
              4: 5.0, // Billet de 5$
              5: 2.0, // Pièce de 2$
              6: 1.0, // Pièce de 1$
              7: 0.25, // Pièce de 25¢
              8: 0.10, // Pièce de 10¢
              9: 0.05, // Pièce de 5¢
              10: 0.01, // Pièce de 1¢
            };

            return cashDetails.fold(
                0.0,
                (sum, detail) =>
                    sum +
                    (values[detail.typeCash] ?? 0.0) * detail.nombreItems);
          }

          return AlertDialog(
            backgroundColor: Colours.primaryPalette,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              title,
              style: TextStyles.interBoldH6.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Montant total ',
                                style: TextStyles.interBoldBody1
                                    .copyWith(color: Colours.colorsButtonMenu),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                ' \$${calculateTotalAmount().toStringAsFixed(2)}',
                                style: TextStyles.interBoldBody2
                                    .copyWith(color: Colours.white),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                'Caisse ',
                                style: TextStyles.interBoldBody1
                                    .copyWith(color: Colours.colorsButtonMenu),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                ' \$${(amountTotalCaisse / 100).toStringAsFixed(2)}',
                                style: TextStyles.interBoldBody2
                                    .copyWith(color: Colours.white),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                ' Fond de caisse ',
                                style: TextStyles.interBoldBody1
                                    .copyWith(color: Colours.colorsButtonMenu),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '\$${(amountTotalCashFund / 100).toStringAsFixed(2)}',
                                style: TextStyles.interBoldBody2
                                    .copyWith(color: Colours.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cashDetails.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Quatre colonnes
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5, // Ajuste la hauteur des éléments
                      ),
                      itemBuilder: (context, index) {
                        final detail = cashDetails[index];
                        return Row(
                          children: [
                            Expanded(
                              flex:
                                  3, // Premier bloc : Dropdown et TextField empilés
                              child: Column(
                                children: [
                                  DropdownButton<int>(
                                    value: detail.typeCash,
                                    dropdownColor: Colours.primaryPalette,
                                    isExpanded: true,
                                    items: const [
                                      DropdownMenuItem(
                                          value: 1,
                                          child: Text(
                                            "Billet de 100\$",
                                            style:
                                                TextStyle(color: Colours.white),
                                          )),
                                      DropdownMenuItem(
                                          value: 2,
                                          child: Text("Billet de 50\$",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                      DropdownMenuItem(
                                          value: 3,
                                          child: Text("Billet de 10\$",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                      DropdownMenuItem(
                                          value: 4,
                                          child: Text("Billet de 5\$",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                      DropdownMenuItem(
                                          value: 5,
                                          child: Text("Pièce de 2\$",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                      DropdownMenuItem(
                                          value: 6,
                                          child: Text("Pièce de 1\$",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                      DropdownMenuItem(
                                          value: 7,
                                          child: Text("Pièce de 25 ¢",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                      DropdownMenuItem(
                                          value: 8,
                                          child: Text("Pièce de 10¢",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                      DropdownMenuItem(
                                          value: 9,
                                          child: Text("Pièce de 5¢",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                      DropdownMenuItem(
                                          value: 10,
                                          child: Text("Pièce de 1¢",
                                              style: TextStyle(
                                                  color: Colours.white))),
                                    ],
                                    onChanged: (newValue) {
                                      if (newValue != null) {
                                        updateCashDetail(
                                            index,
                                            detail.copyWith(
                                                typeCash: newValue));
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "Nombre",
                                      labelStyle:
                                          TextStyle(color: Colours.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colours.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colours.colorsButtonMenu),
                                      ),
                                    ),
                                    style:
                                        const TextStyle(color: Colours.white),
                                    onChanged: (value) {
                                      updateCashDetail(
                                        index,
                                        detail.copyWith(
                                            nombreItems:
                                                int.tryParse(value) ?? 0),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1, // Icône de suppression à droite
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => removeCashDetail(index),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: addCashDetail,
                      icon: const Icon(Icons.add,
                          color: Colours.colorsButtonMenu),
                      label: const Text(
                        "Ajouter un détail",
                        style: TextStyle(color: Colours.colorsButtonMenu),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Annuler"),
              ),
              ElevatedButton(
                onPressed: () {
                  onSubmit(
                    TransactionCaisseResponseModel(
                      amount: calculateTotalAmount() * 100,
                      cashDetails: cashDetails,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.colorsButtonMenu,
                ),
                child: const Text("Soumettre"),
              ),
            ],
          );
        },
      );
    },
  );
}
