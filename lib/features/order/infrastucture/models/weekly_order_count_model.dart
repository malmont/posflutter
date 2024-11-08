import 'package:pos_flutter/features/order/domain/entities/weekly_order_count.dart';

class WeeklyOrderCountModel extends WeeklyOrderCount {
  WeeklyOrderCountModel({
    required int week,
    required int orderCount,
  }) : super(
          week: week,
          orderCount: orderCount,
        );

  factory WeeklyOrderCountModel.fromJson(Map<String, dynamic> json) {
    return WeeklyOrderCountModel(
      week: json['week'],
      orderCount: json['orderCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'orderCount': orderCount,
    };
  }

  // Conversion depuis une entité de type WeeklyOrderCount
  factory WeeklyOrderCountModel.fromEntity(WeeklyOrderCount entity) {
    return WeeklyOrderCountModel(
      week: entity.week,
      orderCount: entity.orderCount,
    );
  }
}
