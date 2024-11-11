import 'package:pos_flutter/features/payment/domain/entities/payments_statistics.dart';

import 'current_week_model.dart';
import 'current_month_model.dart';
import 'current_year_model.dart';

class PaymentsStatisticsModel extends PaymentsStatistics {
  PaymentsStatisticsModel({
    required CurrentWeekModel currentWeek,
    required CurrentMonthModel currentMonth,
    required CurrentYearModel currentYear,
  }) : super(
          currentWeek: currentWeek,
          currentMonth: currentMonth,
          currentYear: currentYear,
        );

  factory PaymentsStatisticsModel.fromJson(Map<String, dynamic> json) {
    return PaymentsStatisticsModel(
      currentWeek: CurrentWeekModel.fromJson(json['current_week']),
      currentMonth: CurrentMonthModel.fromJson(json['current_month']),
      currentYear: CurrentYearModel.fromJson(json['current_year']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_week': (currentWeek as CurrentWeekModel).toJson(),
      'current_month': (currentMonth as CurrentMonthModel).toJson(),
      'current_year': (currentYear as CurrentYearModel).toJson(),
    };
  }

  factory PaymentsStatisticsModel.fromEntity(PaymentsStatistics entity) {
    return PaymentsStatisticsModel(
      currentWeek: CurrentWeekModel.fromEntity(entity.currentWeek),
      currentMonth: CurrentMonthModel.fromEntity(entity.currentMonth),
      currentYear: CurrentYearModel.fromEntity(entity.currentYear),
    );
  }
}
