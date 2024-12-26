import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/design/design.dart';
import 'package:pos_flutter/features/order/application/blocs/order_bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/revenu_statistique_bloc/revenue_statistics_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/statistique_order/statistique_order_bloc.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/domain/entities/order_details.dart';
import 'package:pos_flutter/features/order/presentation/widgets/dashboard_card.dart';
import 'package:pos_flutter/features/order/presentation/widgets/day_selection_card.dart';
import 'package:pos_flutter/features/products/presentation/widgets/generic_list.dart';
import 'package:pos_flutter/widget/detail_row.dart';
import 'package:pos_flutter/widget/header_row.dart';
import 'package:pos_flutter/widget/status_row.dart';

class OrdersListPage extends StatefulWidget {
  final List<OrderDetails> orders;
  final Function(OrderDetails) onSelectOrder;

  const OrdersListPage({
    super.key,
    required this.orders,
    required this.onSelectOrder,
  });

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
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _showTopSection ? null : 0,
                child: Column(
                  children: [
                    BlocBuilder<StatistiqueOrderBloc, StatistiqueOrderState>(
                      builder: (context, statistiqueState) {
                        return BlocBuilder<RevenueStatisticsBloc,
                            RevenueStatisticsState>(
                          builder: (context, revenueState) {
                            if (revenueState
                                    is RevenueStatisticsLoadInProgress ||
                                statistiqueState
                                    is StatistiqueOrderLoadInProgress) {
                              EasyLoading.show(
                                  status: 'Chargement des statistiques...');
                            } else {
                              EasyLoading.dismiss();
                            }

                            if (statistiqueState
                                    is StatistiqueOrderLoadSuccess &&
                                revenueState is RevenueStatisticsLoadSuccess) {
                              EasyLoading.dismiss();
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: DashboardCard(
                                      title: "Chiffres d'affaires",
                                      icon: Icons.monetization_on,
                                      currentValue:
                                          '\$${(revenueState.revenueStatisticsModel.currentWeekRevenue / 100).toStringAsFixed(2)}',
                                      currentLabel: "semaine en cours",
                                      lastValue:
                                          '\$${(revenueState.revenueStatisticsModel.lastWeekRevenue / 100).toStringAsFixed(2)}',
                                      lastLabel: 'Semaine dernière',
                                    ),
                                  ),
                                  Expanded(
                                    child: DashboardCard(
                                      title: "Commandes",
                                      icon: Icons.shopping_cart,
                                      currentValue: statistiqueState
                                          .statistiqueOrderModel
                                          .currentWeekCountAchatClientCompletee
                                          .toString(),
                                      currentLabel: 'semaine en cours',
                                      lastValue: statistiqueState
                                          .statistiqueOrderModel
                                          .lastWeekCountAchatClientCompletee
                                          .toString(),
                                      lastLabel: 'semaine dernière',
                                    ),
                                  ),
                                  Expanded(
                                    child: DashboardCard(
                                      title: "Annulation",
                                      icon: Icons.cancel,
                                      currentValue: statistiqueState
                                          .statistiqueOrderModel
                                          .currentWeekCountAchatClientAnnulation
                                          .toString(),
                                      currentLabel: 'semaine en cours',
                                      lastValue: statistiqueState
                                          .statistiqueOrderModel
                                          .lastWeekCountAchatClientAnnulation
                                          .toString(),
                                      lastLabel: 'Semaine dernière',
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox();
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
                          context.read<OrderBloc>().add(GetOrders(
                                FilterOrderParams(
                                  orderSource: 2,
                                  days: daySelections[index].days,
                                ),
                              ));
                        });
                      },
                      itemBuilder: (daySelection, isSelected) =>
                          DaySelectionCard(
                        name: daySelection.name,
                        isSelected: isSelected,
                      ),
                    ),
                  ],
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
                          controller: _scrollController,
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
                                    horizontal: Units.edgeInsetsLarge),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      Units.edgeInsetsLarge),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: _buildHeaderRow(order),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: _buildDetailsRow(
                                            'Total Amount',
                                            '\$${(order.totalAmount / 100).toStringAsFixed(2)}',
                                            Colors.greenAccent),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: _buildDetailsRow(
                                            'Order Date',
                                            order.orderDate,
                                            Colours.colorsButtonMenu),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: _buildStatusRow(order),
                                      ),
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
        ],
      ),
    );
  }

  Widget _buildHeaderRow(OrderDetails order) {
    return HeaderRow(
      title: 'Order ID: ${order.id}',
      subtitle: order.reference,
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

  Widget _buildStatusRow(OrderDetails order) {
    return StatusRow(
      label: 'Status',
      statusColor: order.status,
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
