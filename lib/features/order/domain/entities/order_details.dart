import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/authentification/domain/entities/delivery_info.dart';

import 'order_item.dart';

class OrderDetails extends Equatable {
  final int id;
  final String reference;
  final num totalAmount;
  final String orderDate;
  final int userId;
  final DeliveryInfo shippingAdress;
  final String orderSource;
  final String status;
  final List<OrderItem> orderItems;

  const OrderDetails({
    required this.id,
    required this.reference,
    required this.totalAmount,
    required this.orderDate,
    required this.userId,
    required this.shippingAdress,
    required this.orderSource,
    required this.status,
    required this.orderItems,
  });

  @override
  List<Object> get props => [
        id,
        reference,
        totalAmount,
        orderDate,
        userId,
        shippingAdress,
        orderSource,
        status,
        orderItems,
      ];
}
