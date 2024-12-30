import 'package:pos_flutter/features/order/domain/entities/payment_method.dart';

class PaymentMethodModel extends PaymentMethod {
  const PaymentMethodModel({
    required int type,
    required double amount,
  }) : super(
          type: type,
          amount: amount,
        );

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        type: json["type"],
        amount: json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
      };

  factory PaymentMethodModel.fromEntity(PaymentMethod entity) =>
      PaymentMethodModel(
        type: entity.type,
        amount: entity.amount,
      );

  PaymentMethod toEntity() => PaymentMethod(
        type: type,
        amount: amount,
      );
}
