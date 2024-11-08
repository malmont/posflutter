import 'package:pos_flutter/features/order/domain/entities/monthly_order_count.dart';

class MonthlyOrderCountModel extends MonthlyOrderCount {
  MonthlyOrderCountModel({
    required String month,
    required int orderCount,
  }) : super(
          month: month,
          orderCount: orderCount,
        );

  factory MonthlyOrderCountModel.fromJson(Map<String, dynamic> json) {
    return MonthlyOrderCountModel(
      month: json['month'],
      orderCount: json['orderCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'orderCount': orderCount,
    };
  }

  // Conversion depuis une entité de type MonthlyOrderCount
  factory MonthlyOrderCountModel.fromEntity(MonthlyOrderCount entity) {
    return MonthlyOrderCountModel(
      month: entity.month,
      orderCount: entity.orderCount,
    );
  }
}
