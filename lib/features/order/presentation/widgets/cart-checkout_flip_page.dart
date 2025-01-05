import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/cart/application/blocs/cart_bloc.dart';
import 'package:pos_flutter/features/cart/presentation/pages/cart_view_page.dart';
import 'package:pos_flutter/features/order/presentation/pages/order_checkout_view.dart';
import 'package:pos_flutter/features/order/presentation/widgets/flip_card.dart';

class CartCheckoutFlipPage extends StatefulWidget {
  const CartCheckoutFlipPage({super.key});

  @override
  CartCheckoutFlipPageState createState() => CartCheckoutFlipPageState();
}

class CartCheckoutFlipPageState extends State<CartCheckoutFlipPage> {
  bool isCheckoutView = false;

  void _onOrderPlaced() {
    setState(() {
      isCheckoutView = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Commande validée !')),
      );
    });
  }

  void _onCheckoutPressed(BuildContext context) {
    final cartState = context.read<CartBloc>().state;
    if (cartState.cart.isNotEmpty) {
      setState(() {
        isCheckoutView = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le panier est vide')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: FlipCard(
            isFront: !isCheckoutView,
            front: CartViewPage(
              onCheckoutPressed: () => _onCheckoutPressed(context),
            ),
            back: OrderCheckoutView(
              items: state.cart,
              onOrderPlaced: _onOrderPlaced,
            ),
          ),
        );
      },
    );
  }
}
