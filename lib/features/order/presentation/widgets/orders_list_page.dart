import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/design/design.dart';
import 'package:pos_flutter/features/order/application/blocs/order_bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/revenu_statistique_bloc/revenue_statistics_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/statistique_order/statistique_order_bloc.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/domain/entities/order_details.dart';
import 'package:pos_flutter/features/order/presentation/widgets/dashboard_card.dart';
import 'package:pos_flutter/features/products/presentation/widgets/generic_list.dart';

class OrdersListPage extends StatefulWidget {
  final List<OrderDetails> orders;
  final Function(OrderDetails) onSelectOrder; // Add the onSelectOrder callback

  const OrdersListPage(
      {super.key, required this.orders, required this.onSelectOrder});

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

int selectedDayIndex = 0;

final List<DaySelection> daySelections = [
  DaySelection(name: "1 jours", days: 1),
  DaySelection(name: "10 jours", days: 10),
  DaySelection(name: "20 jours", days: 20),
  DaySelection(name: "2 mois", days: 60),
  DaySelection(name: "6 mois", days: 180),
];

class _OrdersListPageState extends State<OrdersListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary100,
      appBar: AppBar(
        title: Text(
          'Orders',
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
          BlocBuilder<StatistiqueOrderBloc, StatistiqueOrderState>(
            builder: (context, statistiqueState) {
              return BlocBuilder<RevenueStatisticsBloc, RevenueStatisticsState>(
                builder: (context, revenueState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: DashboardCard(
                          title: "Chiffres d'affaires",
                          icon: Icons.monetization_on,
                          currentValue: revenueState
                                  is RevenueStatisticsLoadSuccess
                              ? '\$${(revenueState.revenueStatisticsModel.currentWeekRevenue / 100).toStringAsFixed(2)}'
                              : 'N/A',
                          currentLabel: "semaine en cours",
                          lastValue: revenueState
                                  is RevenueStatisticsLoadSuccess
                              ? '\$${(revenueState.revenueStatisticsModel.lastWeekRevenue / 100).toStringAsFixed(2)}'
                              : 'N/A',
                          lastLabel: 'Semaine dernière',
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          title: "Commandes",
                          icon: Icons.shopping_cart,
                          currentValue:
                              statistiqueState is StatistiqueOrderLoadSuccess
                                  ? statistiqueState.statistiqueOrderModel
                                      .currentWeekCountAchatClientCompletee
                                      .toString()
                                  : 'N/A',
                          currentLabel: 'semaine en cours',
                          lastValue:
                              statistiqueState is StatistiqueOrderLoadSuccess
                                  ? statistiqueState.statistiqueOrderModel
                                      .lastWeekCountAchatClientCompletee
                                      .toString()
                                  : 'N/A',
                          lastLabel: 'semaine dernière',
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          title: "Annulation",
                          icon: Icons.cancel,
                          currentValue:
                              statistiqueState is StatistiqueOrderLoadSuccess
                                  ? statistiqueState.statistiqueOrderModel
                                      .currentWeekCountAchatClientAnnulation
                                      .toString()
                                  : 'N/A',
                          currentLabel: 'semaine en cours',
                          lastValue:
                              statistiqueState is StatistiqueOrderLoadSuccess
                                  ? statistiqueState.statistiqueOrderModel
                                      .lastWeekCountAchatClientAnnulation
                                      .toString()
                                  : 'N/A',
                          lastLabel: 'Semaine dernière',
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          GenericList<DaySelection>(
            items: daySelections,
            selectedIndex: selectedDayIndex,
            onItemSelected: (index) {
              setState(() {
                selectedDayIndex = index;
                final selectedDays = daySelections[index].days;
                context.read<OrderBloc>().add(GetOrders(
                      FilterOrderParams(
                        orderSource: 2,
                        days: daySelections[index].days,
                      ),
                    ));
              });
            },
            itemBuilder: (daySelection, isSelected) => Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Units.edgeInsetsXLarge,
                  vertical: Units.edgeInsetsXLarge),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Units.radiusXXLarge),
                color:
                    isSelected ? Colours.colorsButtonMenu : Colours.primary100,
              ),
              padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
              child: Text(
                daySelection.name,
                style: TextStyles.interBoldH6.copyWith(
                  color: isSelected ? Colours.primary100 : Colours.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              color: Colours.primary100,
              child: widget.orders.isEmpty
                  ? Center(
                      child: Text(
                        'Pas de commandes aujourd\'hui',
                        style: TextStyles.interRegularH5.copyWith(
                          color: Colours.colorsButtonMenu,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.orders.length,
                      itemBuilder: (context, index) {
                        final order = widget.orders[index];
                        return GestureDetector(
                          onTap: () {
                            widget.onSelectOrder(order);
                          },
                          child: Card(
                            color: Colours.primaryPalette,
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(
                                vertical: Units.edgeInsetsLarge,
                                horizontal: Units.edgeInsetsXXLarge),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(Units.edgeInsetsXXLarge),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHeaderRow(order),
                                  const SizedBox(width: Units.sizedbox_80),
                                  _buildDetailsRow(
                                      'Total Amount',
                                      '\$${(order.totalAmount / 100).toStringAsFixed(2)}',
                                      Colors.greenAccent),
                                  const SizedBox(width: Units.sizedbox_80),
                                  _buildDetailsRow('Order Date',
                                      order.orderDate, Colors.grey),
                                  const SizedBox(width: Units.sizedbox_80),
                                  _buildStatusRow(order),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(OrderDetails order) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Order ID: ${order.id}',
          style: TextStyles.interBoldH6.copyWith(color: Colors.white),
        ),
        const SizedBox(height: Units.sizedbox_10),
        Text(
          order.reference,
          style: TextStyles.interRegularBody1
              .copyWith(color: Colours.colorsButtonMenu),
        ),
      ],
    );
  }

  Widget _buildDetailsRow(String label, String value, Color valueColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
        ),
        const SizedBox(height: Units.sizedbox_10),
        Text(
          value,
          style: TextStyles.interRegularBody1
              .copyWith(color: Colours.colorsButtonMenu),
        ),
      ],
    );
  }

  Widget _buildStatusRow(OrderDetails order) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Status',
          style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
        ),
        const SizedBox(height: Units.sizedbox_10),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: Units.edgeInsetsMedium,
              horizontal: Units.edgeInsetsXLarge),
          decoration: BoxDecoration(
            color: _getStatusColor(order.status),
            borderRadius: BorderRadius.circular(Units.radiusXXLarge),
          ),
          child: Text(
            order.status,
            style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Complétée':
        return Colors.green;
      case 'En cours':
        return Colors.orange;
      case 'En cours de préparation':
        return Colors.purple;
      case 'En cours de livraison':
        return Colors.blueAccent;
      case 'Livrée':
        return Colors.greenAccent;
      case 'Annulation':
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
