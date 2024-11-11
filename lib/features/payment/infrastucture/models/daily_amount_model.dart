import 'package:pos_flutter/features/payment/domain/entities/daily_amount.dart';

class DailyAmountModel extends DailyAmount {
  DailyAmountModel({
    required DateTime date,
    required double amount,
  }) : super(
          date: date,
          amount: amount,
        );

  factory DailyAmountModel.fromJson(Map<String, dynamic> json) {
    return DailyAmountModel(
      date: DateTime.parse(json['date']),
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }

  factory DailyAmountModel.fromEntity(DailyAmount entity) {
    return DailyAmountModel(
      date: entity.date,
      amount: entity.amount,
    );
  }
}
