import 'package:pos_flutter/features/payment/domain/entities/payment_statistics.dart';

import 'daily_amount_model.dart';

class PaymentStatisticsModel extends PaymentStatistics {
  PaymentStatisticsModel({
    required double total,
    required List<DailyAmountModel> daily,
  }) : super(
          total: total,
          daily: daily,
        );

  factory PaymentStatisticsModel.fromJson(Map<String, dynamic> json) {
    return PaymentStatisticsModel(
      total: (json['total'] as num).toDouble(),
      daily: (json['daily'] as List)
          .map((item) => DailyAmountModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'daily': daily
          .map((item) => DailyAmountModel.fromEntity(item).toJson())
          .toList(),
    };
  }

  factory PaymentStatisticsModel.fromEntity(PaymentStatistics entity) {
    return PaymentStatisticsModel(
      total: entity.total,
      daily: entity.daily
          .map((item) => DailyAmountModel.fromEntity(item))
          .toList(),
    );
  }
}
