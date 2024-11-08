import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/features/order/application/blocs/order_bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/revenu_statistique_bloc/revenue_statistics_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/statistique_order/statistique_order_bloc.dart';

import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/domain/entities/order_details.dart';
import 'package:pos_flutter/features/order/presentation/widgets/orders_list_page.dart';
import 'package:pos_flutter/features/order/presentation/widgets/order_details_page.dart';
import 'package:pos_flutter/features/order/presentation/pages/statistic_view_page.dart';
import '../../../../design/design.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  OrderDetails? selectedOrder;

  @override
  void initState() {
    super.initState();
    context
        .read<OrderBloc>()
        .add(const GetOrders(FilterOrderParams(orderSource: 2, days: 1)));
    context.read<StatistiqueOrderBloc>().add(const GetStatistiqueOrder());
    context.read<RevenueStatisticsBloc>().add(const GetRevenueStatistics());
  }

  void navigateToDetails(OrderDetails order) {
    setState(() {
      selectedOrder = order;
    });
  }

  void goBackToList() {
    setState(() {
      selectedOrder = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary100,
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                if (selectedOrder == null)
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      if (state is OrderLoadInProgress) {
                        EasyLoading.show(status: 'Chargement des commandes...');
                        return const SizedBox(); // Placeholder while loading
                      } else {
                        EasyLoading.dismiss();
                      }

                      if (state is OrderLoadSuccess) {
                        return OrdersListPage(
                          orders: state.orders,
                          onSelectOrder: navigateToDetails,
                        );
                      }

                      if (state is OrderLoadFailure) {
                        return const Center(
                          child: Text('Échec du chargement des commandes.'),
                        );
                      }

                      // Placeholder when no orders or no state match
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10 + MediaQuery.of(context).padding.bottom,
                          top: 10,
                        ),
                        itemBuilder: (context, index) => const SizedBox(),
                      );
                    },
                  ),
                if (selectedOrder != null)
                  OrderDetailsPage(
                    orderDetails: selectedOrder!,
                    onBack: goBackToList,
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<StatistiqueOrderBloc, StatistiqueOrderState>(
              builder: (context, statistiqueState) {
                return BlocBuilder<RevenueStatisticsBloc,
                    RevenueStatisticsState>(
                  builder: (context, revenueState) {
                    return StatistiquePageView(
                      statistiqueOrderModel:
                          statistiqueState is StatistiqueOrderLoadSuccess
                              ? statistiqueState.statistiqueOrderModel
                              : null,
                      revenueStatisticsModel:
                          revenueState is RevenueStatisticsLoadSuccess
                              ? revenueState.revenueStatisticsModel
                              : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
