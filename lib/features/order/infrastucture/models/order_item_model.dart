import 'package:pos_flutter/features/order/domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required int id,
    required int quantity,
    required num unitPrice,
    required num totalPrice,
    required int productId,
    required String productVariantName,
    required String productVariantColor,
    required String productVariantSize,
    required String productImage,
  }) : super(
          id: id,
          quantity: quantity,
          unitPrice: unitPrice,
          totalPrice: totalPrice,
          productId: productId,
          productVariantName: productVariantName,
          productVariantColor: productVariantColor,
          productVariantSize: productVariantSize,
          productImage: productImage,
        );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: json['unitPrice'] as num? ?? 0,
      totalPrice: json['totalPrice'] as num? ?? 0,
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productVariantName: json['productVariantName'] as String? ?? '',
      productVariantColor: json['productVariantColor'] as String? ?? '',
      productVariantSize: json['productVariantSize'] as String? ?? '',
      productImage: json['productImage'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'productId': productId,
      'productVariantName': productVariantName,
      'productVariantColor': productVariantColor,
      'productVariantSize': productVariantSize,
      'productImage': productImage,
    };
  }

  factory OrderItemModel.fromEntity(OrderItem entity) {
    return OrderItemModel(
      id: entity.id,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
      totalPrice: entity.totalPrice,
      productId: entity.productId,
      productVariantName: entity.productVariantName,
      productVariantColor: entity.productVariantColor,
      productVariantSize: entity.productVariantSize,
      productImage: entity.productImage,
    );
  }

  Map<String, dynamic> toJsonBody() {
    return {
      "id": id,
      "quantity": quantity,
      "unitPrice": unitPrice,
      "totalPrice": totalPrice,
      "productId": productId,
      "productVariantName": productVariantName,
      "productVariantColor": productVariantColor,
      "productVariantSize": productVariantSize,
      "productImage": productImage,
    };
  }
}
