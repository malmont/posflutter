import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/features/order/application/blocs/order_bloc.dart';
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
    context.read<OrderBloc>().add(const GetStatistiqueOrder());
    context.read<OrderBloc>().add(const GetRevenueStatistics());
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   context
  //       .read<OrderBloc>()
  //       .add(const GetOrders(FilterOrderParams(orderSource: 2, days: 1)));
  //   context.read<OrderBloc>().add(const GetStatistiqueOrder());
  //   context.read<OrderBloc>().add(const GetRevenueStatistics());
  // }

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
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderFetchLoading) {
            EasyLoading.show(status: 'Chargement...');
          } else {
            EasyLoading.dismiss();
          }

          return Row(
            children: [
              Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    if (selectedOrder == null) ...[
                      if (state is OrderFetchSuccess)
                        OrdersListPage(
                          orders: state.orders,
                          onSelectOrder: navigateToDetails,
                        )
                      else if (state is OrderFetchFail)
                        const Center(
                          child: Text('Échec du chargement des commandes.'),
                        )
                      else
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 6,
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom:
                                (10 + MediaQuery.of(context).padding.bottom),
                            top: 10,
                          ),
                          itemBuilder: (context, index) => const SizedBox(),
                        ),
                    ],
                    if (selectedOrder != null)
                      OrderDetailsPage(
                        orderDetails: selectedOrder!,
                        onBack: goBackToList,
                        statistiqueOrderModel:
                            state is OrderFetchSuccessStatistiqueOrder
                                ? state.statistiqueOrderModel
                                : null,
                        revenueStatisticsModel:
                            state is OrderFetchSuccessRevenueStatistics
                                ? state.revenueStatisticsModel
                                : null,
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: StatistiquePageView(
                  statistiqueOrderModel:
                      state is OrderFetchSuccessStatistiqueOrder
                          ? state.statistiqueOrderModel
                          : null,
                  revenueStatisticsModel:
                      state is OrderFetchSuccessRevenueStatistics
                          ? state.revenueStatisticsModel
                          : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
