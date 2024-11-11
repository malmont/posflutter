import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/presentation/widgets/dashboard_card.dart';
import 'package:pos_flutter/features/payment/application/blocs/Payment_bloc/payment_bloc.dart';
import 'package:pos_flutter/features/payment/domain/entities/payment_details.dart';
import 'package:pos_flutter/features/products/presentation/widgets/generic_list.dart';

import '../../../../design/design.dart';

class PaymentsListPage extends StatefulWidget {
  final List<PaymentDetails> payments;
  final Function(PaymentDetails) onSelectPayment;

  const PaymentsListPage({
    super.key,
    required this.payments,
    required this.onSelectPayment,
  });

  @override
  State<PaymentsListPage> createState() => _PaymentsListPageState();
}

int selectedDayIndex = 0;

final List<DaySelection> daySelections = [
  DaySelection(name: "1 jours", days: 1),
  DaySelection(name: "10 jours", days: 10),
  DaySelection(name: "20 jours", days: 20),
  DaySelection(name: "2 mois", days: 60),
  DaySelection(name: "6 mois", days: 180),
];

class _PaymentsListPageState extends State<PaymentsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary100,
      appBar: AppBar(
        title: Text(
          'Payments',
          style: TextStyles.interRegularH5
              .copyWith(color: Colours.colorsButtonMenu),
        ),
        backgroundColor: Colours.primary100,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: DashboardCard(
                  title: "titre",
                  icon: Icons.attach_money,
                  currentValue: '5000',
                  currentLabel: 'Total amount',
                  lastValue: '4000',
                  lastLabel: 'Last month',
                ),
              ),
              Expanded(
                child: DashboardCard(
                  title: "titre",
                  icon: Icons.credit_card,
                  currentValue: '2000',
                  currentLabel: 'Total amount',
                  lastValue: '1500',
                  lastLabel: 'Last month',
                ),
              ),
            ],
          ),
          GenericList<DaySelection>(
            items: daySelections,
            selectedIndex: selectedDayIndex,
            onItemSelected: (index) {
              setState(() {
                selectedDayIndex = index;
                final selectedDays = daySelections[index].days;
                context.read<PaymentBloc>().add(GetPayments(
                      FilterOrderParams(days: selectedDays),
                    ));
              });
            },
            itemBuilder: (daySelection, isSelected) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSelected ? Colours.colorsButtonMenu : Colors.grey[200],
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                daySelection.name,
                style: TextStyles.interBoldH6.copyWith(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          // Displaying the payments list
          Expanded(
            child: widget.payments.isEmpty
                ? Center(
                    child: Text(
                      'Pas de paiement aujourd\'hui',
                      style: TextStyles.interRegularH5.copyWith(
                        color: Colours.colorsButtonMenu,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.payments.length,
                    itemBuilder: (context, index) {
                      final payment = widget.payments[index];
                      return GestureDetector(
                        onTap: () {
                          widget.onSelectPayment(payment);
                        },
                        child: Card(
                          color: Colours.primaryPalette,
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildHeaderRow(payment),
                                const SizedBox(width: 20),
                                _buildDetailsRow(
                                    'Amount',
                                    '\$${(payment.amount / 100).toStringAsFixed(2)}',
                                    Colors.greenAccent),
                                const SizedBox(width: 20),
                                _buildDetailsRow(
                                    'Date',
                                    payment.paymentDate.toString(),
                                    Colors.grey),
                                const SizedBox(width: 20),
                                _buildDetailsRow('TypePayment',
                                    payment.paymentMethod, Colors.grey),
                                const SizedBox(width: 20),
                                _buildStatusRow(payment),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(PaymentDetails payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment ID: ${payment.id}',
          style: TextStyles.interBoldH6.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          payment.orderReference,
          style: TextStyles.interSemiBoldBody1
              .copyWith(color: Colours.colorsButtonMenu),
        ),
      ],
    );
  }

  Widget _buildDetailsRow(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.interSemiBoldBody1.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyles.interSemiBoldBody1
              .copyWith(color: Colours.colorsButtonMenu),
        ),
      ],
    );
  }

  Widget _buildStatusRow(PaymentDetails payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: TextStyles.interSemiBoldBody1.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: _getStatusColor(payment.paymentStatus),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            payment.paymentStatus,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Complété':
        return Colors.green;
      case 'En attente':
        return Colors.orange;
      case 'Échoué':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class DaySelection {
  final String name;
  final int days;

  DaySelection({required this.name, required this.days});
}
