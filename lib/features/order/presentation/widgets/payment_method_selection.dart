import 'package:flutter/material.dart';
import 'package:pos_flutter/features/order/presentation/widgets/select_card.dart';

import '../../../../design/design.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter/features/order/presentation/widgets/select_card.dart';

import '../../../../design/design.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter/features/order/presentation/widgets/select_card.dart';

import '../../../../design/design.dart';

class PaymentMethodSelection extends StatelessWidget {
  final Function(int) onSelectMethod;
  final int? selectedMethodId;
  final bool showMultiPaymentOption;

  const PaymentMethodSelection({
    super.key,
    required this.onSelectMethod,
    required this.selectedMethodId,
    this.showMultiPaymentOption = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: TextStyles.interBoldBody2.copyWith(
            color: Colours.white,
          ),
        ),
        const SizedBox(height: Units.sizedbox_10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectCard(
                id: 1,
                label: 'Credit Card',
                icon: Icons.credit_card,
                selectedMethodId:
                    selectedMethodId ?? 0, // Default value (e.g., 0)
                onSelectMethod: onSelectMethod,
              ),
              SelectCard(
                id: 3,
                label: 'Paypal',
                icon: Icons.payment,
                selectedMethodId:
                    selectedMethodId ?? 0, // Default value (e.g., 0)
                onSelectMethod: onSelectMethod,
              ),
              SelectCard(
                id: 2,
                label: 'Cash',
                icon: Icons.money,
                selectedMethodId:
                    selectedMethodId ?? 0, // Default value (e.g., 0)
                onSelectMethod: onSelectMethod,
              ),
              if (showMultiPaymentOption) // Condition d'affichage
                SelectCard(
                  id: 4,
                  label: 'Multi',
                  icon: Icons.merge_type,
                  selectedMethodId:
                      selectedMethodId ?? 0, // Default value (e.g., 0)
                  onSelectMethod: onSelectMethod,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
