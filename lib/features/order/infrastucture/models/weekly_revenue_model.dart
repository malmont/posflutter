import 'package:pos_flutter/features/order/domain/entities/weekly_revenue.dart';

class WeeklyRevenueModel extends WeeklyRevenue {
  WeeklyRevenueModel({
    required int week,
    required double revenue,
  }) : super(
          week: week,
          revenue: revenue,
        );

  factory WeeklyRevenueModel.fromJson(Map<String, dynamic> json) {
    return WeeklyRevenueModel(
      week: json['week'],
      revenue: (json['revenue'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'revenue': revenue,
    };
  }

  factory WeeklyRevenueModel.fromEntity(WeeklyRevenue entity) {
    return WeeklyRevenueModel(
      week: entity.week,
      revenue: entity.revenue,
    );
  }
}
