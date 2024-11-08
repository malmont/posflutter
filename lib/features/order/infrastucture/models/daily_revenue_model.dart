import 'package:pos_flutter/features/order/domain/entities/daily_revenue.dart';

class DailyRevenueModel extends DailyRevenue {
  DailyRevenueModel({
    required DateTime date,
    required double revenue,
  }) : super(
          date: date,
          revenue: revenue,
        );

  factory DailyRevenueModel.fromJson(Map<String, dynamic> json) {
    return DailyRevenueModel(
      date: DateTime.parse(json['date']),
      revenue:
          (json['revenue'] as num).toDouble(), // Conversion explicite en double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'revenue': revenue,
    };
  }

  factory DailyRevenueModel.fromEntity(DailyRevenue entity) {
    return DailyRevenueModel(
      date: entity.date,
      revenue: entity.revenue,
    );
  }
}
