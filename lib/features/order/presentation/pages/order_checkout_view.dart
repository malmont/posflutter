import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/design/design.dart';
import 'package:pos_flutter/di/injection_container.dart';
import 'package:pos_flutter/features/Caisse/application/blocs/caisse_bloc.dart';
import 'package:pos_flutter/features/cart/application/blocs/cart_bloc.dart';
import 'package:pos_flutter/features/cart/domain/entities/cart_item.dart';
import 'package:pos_flutter/features/cart/presentation/widgets/input_form_button.dart';
import 'package:pos_flutter/features/order/application/blocs/order_bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/revenu_statistique_bloc/revenue_statistics_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/statistique_order/statistique_order_bloc.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/domain/entities/order_detail_response.dart';
import 'package:pos_flutter/features/order/presentation/widgets/order_type_selection.dart';
import 'package:pos_flutter/features/order/presentation/widgets/outline_label_card.dart';
import 'package:pos_flutter/features/order/presentation/widgets/payment_method_selection.dart';
import 'package:pos_flutter/features/payment/application/blocs/Payment_bloc/payment_bloc.dart';

class OrderCheckoutView extends StatefulWidget {
  final VoidCallback onOrderPlaced;
  final List<CartItem> items;

  const OrderCheckoutView({
    super.key,
    required this.items,
    required this.onOrderPlaced,
  });

  @override
  OrderCheckoutViewState createState() => OrderCheckoutViewState();
}

class OrderCheckoutViewState extends State<OrderCheckoutView> {
  int? selectedPaymentMethodId = 1;
  int? selectedOrderType = 1;
  @override
  Widget build(BuildContext context) {
    int deliveryCharge = 0;
    return BlocProvider(
      create: (context) => getIt<OrderBloc>(),
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if (state is OrderAddInProgress) {
            EasyLoading.show(status: 'Loading...');
          } else if (state is OrderAddSuccess) {
            context.read<CartBloc>().add(const ClearCart());
            setState(() {
              widget.items.clear();
            });
            widget.onOrderPlaced();
            context
                .read<PaymentBloc>()
                .add(const GetPayments(FilterOrderParams()));
            context.read<CaisseBloc>().add(const GetCaisse(days: 15));
            context.read<OrderBloc>().add(
                const GetOrders(FilterOrderParams(orderSource: 2, days: 1)));
            context
                .read<StatistiqueOrderBloc>()
                .add(const GetStatistiqueOrder());
            context
                .read<RevenueStatisticsBloc>()
                .add(const GetRevenueStatistics());

            EasyLoading.showSuccess("Order Placed Successfully");
          } else if (state is OrderAddFailure) {
            EasyLoading.showError("Error");
          }
        },
        child: Scaffold(
          backgroundColor: Colours.primaryPalette,
          appBar: AppBar(
            backgroundColor: Colours.primaryPalette,
            title: Text(
              'Order Checkout',
              style:
                  TextStyles.interRegularBody1.copyWith(color: Colours.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: widget.onOrderPlaced,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(Units.edgeInsetsLarge),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                OrderTypeSelection(
                  selectedMethodId: selectedOrderType,
                  onSelectMethod: (id) {
                    setState(() {
                      selectedOrderType = id;
                    });
                  },
                ),
                const SizedBox(
                  height: Units.edgeInsetsLarge,
                ),
                PaymentMethodSelection(
                  selectedMethodId: selectedPaymentMethodId,
                  onSelectMethod: (id) {
                    setState(() {
                      selectedPaymentMethodId = id;
                    });
                  },
                ),
                const SizedBox(
                  height: Units.edgeInsetsXXLarge,
                ),
                OutlineLabelCard(
                  title: 'Selected Products',
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: Units.edgeInsetsXXLarge,
                        bottom: Units.edgeInsetsLarge),
                    child: widget.items.isEmpty
                        ? Text(
                            'No items in the cart',
                            style: TextStyles.interRegularBody1
                                .copyWith(color: Colors.red),
                          )
                        : Column(
                            children: widget.items
                                .map((product) => Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: Units.edgeInsetsLarge),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 75,
                                            child: AspectRatio(
                                              aspectRatio: 0.88,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Units.radiusXXLarge),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(
                                                        Units.edgeInsetsLarge),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          product.product.image,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          const SizedBox(
                                              width: Units.sizedbox_20),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product.product.name,
                                                  style: TextStyles
                                                      .interRegularBody1
                                                      .copyWith(
                                                          color: Colours
                                                              .colorsButtonMenu),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '\$${(product.product.price / 100).toStringAsFixed(2)}',
                                                      style: TextStyles
                                                          .interRegularBody1
                                                          .copyWith(
                                                              color: Colours
                                                                  .colorsButtonMenu),
                                                    ),
                                                    const SizedBox(
                                                      width: Units.sizedbox_10,
                                                    ),
                                                    Text(
                                                      'x${product.quantity}',
                                                      style: TextStyles
                                                          .interRegularBody1
                                                          .copyWith(
                                                              color: Colours
                                                                  .colorsButtonMenu),
                                                    ),
                                                    const SizedBox(
                                                      width: Units.sizedbox_10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Wrap(
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: Units
                                                                      .edgeInsetsMedium,
                                                                  vertical: Units
                                                                      .edgeInsetsSmall),
                                                              margin: const EdgeInsets
                                                                  .all(Units
                                                                      .edgeInsetsMedium),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            Units.radiusXXLarge),
                                                              ),
                                                              child: Text(
                                                                product.variant
                                                                    .size.name
                                                                    .substring(
                                                                        0, 1),
                                                                style: TextStyles
                                                                    .interRegularBody1
                                                                    .copyWith(
                                                                        color: Colours
                                                                            .colorsButtonMenu),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Wrap(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets
                                                                  .all(Units
                                                                      .edgeInsetsMedium),
                                                              width: Units.u20,
                                                              height: Units.u20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(int.parse(
                                                                        product
                                                                            .variant
                                                                            .color
                                                                            .codeHexa
                                                                            .replaceFirst('#',
                                                                                ''),
                                                                        radix:
                                                                            16) +
                                                                    0xFF000000),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 2),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                  ),
                ),
                const SizedBox(
                  height: Units.sizedbox_16,
                ),
                OutlineLabelCard(
                  title: 'Order Summary',
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.symmetric(
                        vertical: Units.edgeInsetsLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Number of Items",
                              style: TextStyles.interRegularBody1
                                  .copyWith(color: Colours.colorsButtonMenu),
                            ),
                            BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                              if (state.cart.isEmpty) {
                                return const SizedBox();
                              }

                              return Text(
                                "x${state.totalItems}",
                                style: TextStyles.interRegularBody1
                                    .copyWith(color: Colours.colorsButtonMenu),
                              );
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Price",
                                style: TextStyles.interRegularBody1
                                    .copyWith(color: Colours.colorsButtonMenu)),
                            Text(
                                '\$${(widget.items.fold(0.0, (previousValue, element) => ((element.product.price * element.quantity) + previousValue)) / 100).toStringAsFixed(2)}',
                                style: TextStyles.interRegularBody1
                                    .copyWith(color: Colours.colorsButtonMenu)),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Charge",
                                    style: TextStyles.interRegularBody1
                                        .copyWith(
                                            color: Colours.colorsButtonMenu)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '\$${(deliveryCharge / 100).toStringAsFixed(2)}',
                                        style: TextStyles.interRegularBody1
                                            .copyWith(
                                                color:
                                                    Colours.colorsButtonMenu)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: TextStyles.interRegularBody1
                                        .copyWith(
                                            color: Colours.colorsButtonMenu)),
                                Text(
                                    '\$${((widget.items.fold(0.0, (previousValue, element) => (((element.product.price * element.quantity) + previousValue)) + deliveryCharge) / 100)).toStringAsFixed(2)}',
                                    style: TextStyles.interRegularBody1
                                        .copyWith(
                                            color: Colours.colorsButtonMenu))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Builder(builder: (context) {
                return InputFormButton(
                  color: Colors.black87,
                  onClick: () {
                    context.read<OrderBloc>().add(
                          AddOrder(OrderDetailResponse(
                              orderSource: 2,
                              addressId: 38,
                              paymentMethod: selectedPaymentMethodId ?? 1,
                              carrierId: 7,
                              typeOrder: selectedOrderType ?? 1,
                              items: widget.items
                                  .map((e) => OrderItemDetail(
                                        productVariantId: e.variant.id,
                                        quantity: e.quantity,
                                      ))
                                  .toList())),
                        );
                  },
                  titleText: 'Confirm',
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
