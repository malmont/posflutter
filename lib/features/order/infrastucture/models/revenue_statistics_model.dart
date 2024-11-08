import 'package:pos_flutter/features/order/domain/entities/revenue_statistics.dart';
import 'package:pos_flutter/features/order/infrastucture/models/daily_revenue_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/monthly_revenue_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/weekly_revenue_model.dart';

class RevenueStatisticsModel extends RevenueStatistics {
  RevenueStatisticsModel({
    required double currentWeekRevenue,
    required double lastWeekRevenue,
    required List<DailyRevenueModel> dailyRevenueForCurrentWeek,
    required double currentMonthRevenue,
    required double lastMonthRevenue,
    required List<WeeklyRevenueModel> weeklyRevenueForCurrentMonth,
    required double currentYearRevenue,
    required double lastYearRevenue,
    required List<MonthlyRevenueModel> monthlyRevenueForCurrentYear,
  }) : super(
          currentWeekRevenue: currentWeekRevenue,
          lastWeekRevenue: lastWeekRevenue,
          dailyRevenueForCurrentWeek: dailyRevenueForCurrentWeek,
          currentMonthRevenue: currentMonthRevenue,
          lastMonthRevenue: lastMonthRevenue,
          weeklyRevenueForCurrentMonth: weeklyRevenueForCurrentMonth,
          currentYearRevenue: currentYearRevenue,
          lastYearRevenue: lastYearRevenue,
          monthlyRevenueForCurrentYear: monthlyRevenueForCurrentYear,
        );

  factory RevenueStatisticsModel.fromJson(Map<String, dynamic> json) {
    return RevenueStatisticsModel(
      currentWeekRevenue: (json['currentWeekRevenue'] as num).toDouble(),
      lastWeekRevenue: (json['lastWeekRevenue'] as num).toDouble(),
      dailyRevenueForCurrentWeek: (json['dailyRevenueForCurrentWeek'] as List)
          .map((item) => DailyRevenueModel.fromJson(item))
          .toList(),
      currentMonthRevenue: (json['currentMonthRevenue'] as num).toDouble(),
      lastMonthRevenue: (json['lastMonthRevenue'] as num).toDouble(),
      weeklyRevenueForCurrentMonth:
          (json['weeklyRevenueForCurrentMonth'] as List)
              .map((item) => WeeklyRevenueModel.fromJson(item))
              .toList(),
      currentYearRevenue: (json['currentYearRevenue'] as num).toDouble(),
      lastYearRevenue: (json['lastYearRevenue'] as num).toDouble(),
      monthlyRevenueForCurrentYear:
          (json['monthlyRevenueForCurrentYear'] as List)
              .map((item) => MonthlyRevenueModel.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentWeekRevenue': currentWeekRevenue,
      'lastWeekRevenue': lastWeekRevenue,
      'dailyRevenueForCurrentWeek': dailyRevenueForCurrentWeek
          .map((item) => DailyRevenueModel.fromEntity(item).toJson())
          .toList(),
      'currentMonthRevenue': currentMonthRevenue,
      'lastMonthRevenue': lastMonthRevenue,
      'weeklyRevenueForCurrentMonth': weeklyRevenueForCurrentMonth
          .map((item) => WeeklyRevenueModel.fromEntity(item).toJson())
          .toList(),
      'currentYearRevenue': currentYearRevenue,
      'lastYearRevenue': lastYearRevenue,
      'monthlyRevenueForCurrentYear': monthlyRevenueForCurrentYear
          .map((item) => MonthlyRevenueModel.fromEntity(item).toJson())
          .toList(),
    };
  }
}
