import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final int id;
  final int quantity;
  final num unitPrice;
  final num totalPrice;
  final int productId;
  final String productVariantName;
  final String productVariantColor;
  final String productVariantSize;
  final String productImage;

  const OrderItem({
    required this.id,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.productId,
    required this.productVariantName,
    required this.productVariantColor,
    required this.productVariantSize,
    required this.productImage,
  });

  @override
  List<Object> get props => [
        id,
        quantity,
        unitPrice,
        totalPrice,
        productId,
        productVariantName,
        productVariantColor,
        productVariantSize,
        productImage,
      ];
}
