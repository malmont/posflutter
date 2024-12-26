import 'package:flutter/material.dart';
import 'package:pos_flutter/design/units.dart';
import 'package:pos_flutter/features/order/presentation/widgets/select_card.dart';

import '../../../../design/design.dart';

class OrderTypeSelection extends StatelessWidget {
  final Function(int) onSelectMethod;
  final int? selectedMethodId;

  const OrderTypeSelection({
    super.key,
    required this.onSelectMethod,
    required this.selectedMethodId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Type Order",
          style: TextStyles.interBoldBody2.copyWith(
            color: Colours.white,
          ),
        ),
        const SizedBox(height: Units.sizedbox_8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectCard(
                id: 1,
                label: 'Achat client',
                icon: Icons.shop,
                selectedMethodId: selectedMethodId ?? 1,
                onSelectMethod: onSelectMethod,
              ),
              SelectCard(
                id: 2,
                label: 'Retour client',
                icon: Icons.remove_from_queue_rounded,
                selectedMethodId: selectedMethodId ?? 1,
                onSelectMethod: onSelectMethod,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
