import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/order/domain/entities/payment_method.dart';

class OrderDetailResponse extends Equatable {
  final int orderSource;
  final List<PaymentMethod> paymentMethods; // Liste de méthodes de paiement
  final int addressId;
  final int carrierId;
  final int typeOrder;
  final List<OrderItemDetail> items;

  const OrderDetailResponse({
    required this.orderSource,
    required this.paymentMethods,
    required this.addressId,
    required this.carrierId,
    required this.typeOrder,
    required this.items,
  });

  @override
  List<Object?> get props => [
        orderSource,
        paymentMethods,
        addressId,
        carrierId,
        typeOrder,
        items,
      ];
}

class OrderItemDetail extends Equatable {
  final int productVariantId;
  final int quantity;

  const OrderItemDetail({
    required this.productVariantId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productVariantId, quantity];
}
