import 'package:pos_flutter/features/order/domain/entities/daily_revenue.dart';
import 'package:pos_flutter/features/order/domain/entities/monthly_revenue.dart';
import 'package:pos_flutter/features/order/domain/entities/weekly_revenue.dart';

class RevenueStatistics {
  final double currentWeekRevenue;
  final double lastWeekRevenue;
  final List<DailyRevenue> dailyRevenueForCurrentWeek;
  final double currentMonthRevenue;
  final double lastMonthRevenue;
  final List<WeeklyRevenue> weeklyRevenueForCurrentMonth;
  final double currentYearRevenue;
  final double lastYearRevenue;
  final List<MonthlyRevenue> monthlyRevenueForCurrentYear;

  RevenueStatistics({
    required this.currentWeekRevenue,
    required this.lastWeekRevenue,
    required this.dailyRevenueForCurrentWeek,
    required this.currentMonthRevenue,
    required this.lastMonthRevenue,
    required this.weeklyRevenueForCurrentMonth,
    required this.currentYearRevenue,
    required this.lastYearRevenue,
    required this.monthlyRevenueForCurrentYear,
  });
}
