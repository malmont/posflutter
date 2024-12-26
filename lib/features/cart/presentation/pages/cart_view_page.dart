import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/cart/application/blocs/cart_bloc.dart';
import 'package:pos_flutter/features/cart/domain/entities/cart_item.dart';
import 'package:pos_flutter/features/cart/presentation/widgets/cart_item_card.dart';

import '../../../../design/design.dart';

class CartViewPage extends StatefulWidget {
  final VoidCallback onCheckoutPressed;
  const CartViewPage({super.key, required this.onCheckoutPressed});

  @override
  State<CartViewPage> createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  List<CartItem> selectedCartItems = [];

  String _getTotalItems(List<CartItem> cart) {
    int totalItems = cart.fold(0, (sum, item) => sum + item.quantity);
    return 'Total ($totalItems items)';
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',
            style: TextStyles.interMediumH4
                .copyWith(color: Colours.colorsButtonMenu)),
        backgroundColor: Colours.primaryPalette,
      ),
      backgroundColor: Colours.primaryPalette,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartError && state.cart.isEmpty) {
                          return const Center(
                              child: Column(
                            children: [
                              Text('Cart is Empty'),
                              Text('Please add items to cart'),
                            ],
                          ));
                        }
                        if (state.cart.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Cart is Empty',
                                    style: TextStyles.interMediumH4.copyWith(
                                      color: Colours.colorsButtonMenu,
                                    )),
                                const Icon(
                                  Icons.shopping_cart,
                                  size: 100,
                                  color: Colours.colorsButtonMenu,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.cart.length,
                          padding: EdgeInsets.only(
                              top: (MediaQuery.of(context).padding.top + 20),
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 200),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final cartItem = state.cart[index];
                            return CartItemCard(
                              cartItem: cartItem,
                              onLongClick: () {
                                setState(() {
                                  if (selectedCartItems.any((element) =>
                                      element.product.id ==
                                      cartItem.product.id)) {
                                    selectedCartItems.removeWhere((element) =>
                                        element.product.id ==
                                        cartItem.product.id);
                                  } else {
                                    selectedCartItems.add(cartItem);
                                  }
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              if (state.cart.isEmpty) {
                return const SizedBox();
              }
              return Positioned(
                bottom: (MediaQuery.of(context).padding.bottom + 10),
                left: 0,
                right: 0,
                child: Container(
                  color: Colours.primaryPalette,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<CartBloc>().add(const ClearCart());
                          },
                          style: CustomButtonStyle.customButtonStyle(
                              type: ButtonType.cancelButton,
                              isSelected: isSelected),
                          icon: const Icon(
                            Icons.delete,
                          ),
                          label: const Text(
                            'Clear Cart',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 4, left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total items: ${state.totalItems}',
                                  style: TextStyles.interRegularBody1.copyWith(
                                      color: Colours.colorsButtonMenu),
                                ),
                                Text(
                                  '\$${(state.cart.fold(0.0, (previousValue, element) => (element.product.price * element.quantity) + previousValue) / 100).toStringAsFixed(2)}',
                                  style: TextStyles.interRegularBody1.copyWith(
                                      color: Colours.colorsButtonMenu),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    widget.onCheckoutPressed();
                                  },
                                  style: CustomButtonStyle.customButtonStyle(
                                      type: ButtonType.cancelButton,
                                      isSelected: isSelected),
                                  child: const Text('Checkout'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
