import 'package:pos_flutter/features/order/domain/entities/daily_order_count.dart';

class DailyOrderCountModel extends DailyOrderCount {
  DailyOrderCountModel({
    required DateTime date,
    required int orderCount,
  }) : super(
          date: date,
          orderCount: orderCount,
        );

  factory DailyOrderCountModel.fromJson(Map<String, dynamic> json) {
    return DailyOrderCountModel(
      date: DateTime.parse(json['date']),
      orderCount: json['orderCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'orderCount': orderCount,
    };
  }

  // Conversion depuis une entité de type DailyOrderCount
  factory DailyOrderCountModel.fromEntity(DailyOrderCount entity) {
    return DailyOrderCountModel(
      date: entity.date,
      orderCount: entity.orderCount,
    );
  }
}
