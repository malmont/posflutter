import 'package:pos_flutter/features/order/domain/entities/monthly_revenue.dart';

class MonthlyRevenueModel extends MonthlyRevenue {
  MonthlyRevenueModel({
    required String month,
    required double revenue,
  }) : super(
          month: month,
          revenue: revenue,
        );

  factory MonthlyRevenueModel.fromJson(Map<String, dynamic> json) {
    return MonthlyRevenueModel(
      month: json['month'],
      revenue: json['revenue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'revenue': revenue,
    };
  }

  factory MonthlyRevenueModel.fromEntity(MonthlyRevenue entity) {
    return MonthlyRevenueModel(
      month: entity.month,
      revenue: entity.revenue,
    );
  }
}
