import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/design/design.dart';
import 'package:pos_flutter/features/cart/application/blocs/cart_bloc.dart';
import 'package:pos_flutter/features/cart/domain/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function? onClick;
  final Function()? onLongClick;

  const CartItemCard({
    super.key,
    required this.cartItem,
    this.onClick,
    this.onLongClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onClick as void Function()?,
        onLongPress: onLongClick,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colours.primary100,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: SizedBox(
                width: 90,
                height: 110,
                child: Card(
                  color: Colours.primaryPalette,
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CachedNetworkImage(
                      imageUrl: cartItem.product.image,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                    child: Text(
                      cartItem.product.name.length > 13
                          ? '${cartItem.product.name.substring(0, 13)}...'
                          : cartItem.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.interBoldBody1
                          .copyWith(color: Colours.colorsButtonMenu),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: Row(
                      children: [
                        Text(
                          '\$${(cartItem.product.price / 100).toStringAsFixed(2)}',
                          style: TextStyles.interBoldBody1
                              .copyWith(color: Colours.colorsButtonMenu),
                        ),
                        const Spacer(), // Ajout d'un Spacer pour adapter l'espace
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Wrap(
                            children: [
                              if (cartItem.variant?.size?.name != null &&
                                  cartItem.variant!.size!.name!.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colours.colorsButtonMenu,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    cartItem.variant.size!.name.substring(0, 1),
                                    style: TextStyles.interBoldBody1.copyWith(
                                        color: Colours.colorsButtonMenu),
                                  ),
                                )
                              else
                                Container(),
                            ],
                          ),
                        ],
                      ),
                      Spacer(), // Ajout d'un Spacer ici aussi
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Wrap(
                            children: [
                              if (cartItem.variant.color?.codeHexa != null)
                                Container(
                                  margin: const EdgeInsets.all(4),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(int.parse(
                                            cartItem.variant.color!.codeHexa
                                                .replaceFirst('#', ''),
                                            radix: 16) +
                                        0xFF000000),
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                  ),
                                )
                              else
                                Container(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<CartBloc>()
                        .add(AddProduct(cartItem: cartItem));
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${cartItem.quantity}',
                  style: TextStyles.interBoldBody1
                      .copyWith(color: Colours.colorsButtonMenu),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    context
                        .read<CartBloc>()
                        .add(RemoveProduct(cartItem: cartItem));
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: const Icon(
                      Icons.remove,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
