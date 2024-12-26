import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/presentation/widgets/dashboard_card.dart';
import 'package:pos_flutter/features/order/presentation/widgets/day_selection_card.dart';
import 'package:pos_flutter/features/payment/application/blocs/Payment_bloc/payment_bloc.dart';
import 'package:pos_flutter/features/payment/application/blocs/payment_statistic_bloc/payment_statistic_bloc.dart';
import 'package:pos_flutter/features/payment/domain/entities/payment_details.dart';
import 'package:pos_flutter/features/products/presentation/widgets/generic_list.dart';
import 'package:pos_flutter/widget/detail_row.dart';
import 'package:pos_flutter/widget/header_row.dart';
import 'package:pos_flutter/widget/status_row.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool _showTopSection = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.pixels > 150 && _showTopSection) {
      setState(() {
        _showTopSection = false;
      });
    } else if (_scrollController.position.pixels <= 50 && !_showTopSection) {
      setState(() {
        _showTopSection = true;
      });
    }
  }

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
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showTopSection ? null : 0,
            child: Column(
              children: [
                BlocBuilder<PaymentStatisticBlocBloc,
                    PaymentStatisticBlocState>(
                  builder: (context, state) {
                    if (state is PaymentStatisticLoading) {
                      EasyLoading.show(
                          status: 'Chargement des statistiques...');
                    } else {
                      EasyLoading.dismiss();
                    }

                    if (state is PaymentStatisticSuccess) {
                      final currentMonth =
                          state.paymentsStatisticsModel.currentMonth;
                      final currentWeek =
                          state.paymentsStatisticsModel.currentWeek;
                      final currentYear =
                          state.paymentsStatisticsModel.currentYear;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: DashboardCard(
                              title: "Current Week",
                              icon: Icons.credit_card,
                              currentValue:
                                  '\$${(currentWeek.paymentClient.total / 100).toStringAsFixed(2)}',
                              currentLabel: 'Paiement total',
                              lastValue:
                                  '\$${(currentWeek.remboursementClient.total / 100).toStringAsFixed(2)}',
                              lastLabel: 'remboursement total',
                            ),
                          ),
                          Expanded(
                            child: DashboardCard(
                              title: "Current Month",
                              icon: Icons.credit_card,
                              currentValue:
                                  '\$${(currentMonth.paiementClient / 100).toStringAsFixed(2)}',
                              currentLabel: 'Paiement total',
                              lastValue:
                                  '\$${(currentMonth.remboursementClient / 100).toStringAsFixed(2)}',
                              lastLabel: 'remboursement total',
                            ),
                          ),
                          Expanded(
                            child: DashboardCard(
                              title: "Current Year",
                              icon: Icons.credit_card,
                              currentValue:
                                  '\$${(currentYear.paiementClient / 100).toStringAsFixed(2)}',
                              currentLabel: 'Paiement total',
                              lastValue:
                                  '\$${(currentYear.remboursementClient / 100).toStringAsFixed(2)}',
                              lastLabel: 'remboursement total',
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
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
                  itemBuilder: (daySelection, isSelected) => DaySelectionCard(
                    name: daySelection.name,
                    isSelected: isSelected,
                  ),
                ),

                // Displaying the payments list
              ],
            ),
          ),
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
                    controller: _scrollController,
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
                              vertical: Units.edgeInsetsLarge,
                              horizontal: Units.edgeInsetsLarge),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(Units.edgeInsetsLarge),
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
                                    Colours.colorsButtonMenu),
                                const SizedBox(width: 20),
                                _buildDetailsRow(
                                    'TypePayment',
                                    payment.paymentMethod,
                                    Colours.colorsButtonMenu),
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
    return HeaderRow(
      title: 'Payment ID: ${payment.id}',
      subtitle: payment.orderReference,
      titleStyle: TextStyles.interBoldBody1.copyWith(color: Colors.white),
      subtitleStyle: TextStyles.interRegularBody1
          .copyWith(color: Colours.colorsButtonMenu),
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

  Widget _buildStatusRow(PaymentDetails payment) {
    return StatusRow(
      label: 'Status',
      statusColor: payment.paymentStatus,
      labelStyle: TextStyles.interRegularBody1.copyWith(color: Colors.white),
      statusStyle: TextStyles.interRegularBody1.copyWith(color: Colors.white),
    );
  }
}

class DaySelection {
  final String name;
  final int days;

  DaySelection({required this.name, required this.days});
}
