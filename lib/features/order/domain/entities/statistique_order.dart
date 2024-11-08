import 'package:pos_flutter/features/order/domain/entities/daily_order_count.dart';
import 'package:pos_flutter/features/order/domain/entities/monthly_order_count.dart';
import 'package:pos_flutter/features/order/domain/entities/weekly_order_count.dart';

class StatistiqueOrder {
  final int currentWeekCountAchatClientCompletee;
  final int lastWeekCountAchatClientCompletee;
  final List<DailyOrderCount> dailyCountAchatClientCompleteeForCurrentWeek;

  final int currentWeekCountAchatClientLivree;
  final int lastWeekCountAchatClientLivree;
  final List<DailyOrderCount> dailyCountAchatClientLivreeForCurrentWeek;

  final int currentWeekCountAchatClientAnnulation;
  final int lastWeekCountAchatClientAnnulation;
  final List<DailyOrderCount> dailyCountAchatClientAnnulationForCurrentWeek;

  final int currentWeekCountRetourClientCompletee;
  final int lastWeekCountRetourClientCompletee;
  final List<DailyOrderCount> dailyCountRetourClientCompleteeForCurrentWeek;

  final int currentWeekCountRetourClientLivree;
  final int lastWeekCountRetourClientLivree;
  final List<DailyOrderCount> dailyCountRetourClientLivreeForCurrentWeek;

  final int currentMonthCount;
  final int lastMonthCount;
  final List<WeeklyOrderCount> weeklyCountForCurrentMonth;

  final int currentYearCount;
  final int lastYearCount;
  final List<MonthlyOrderCount> monthlyCountForCurrentYear;

  StatistiqueOrder({
    required this.currentWeekCountAchatClientCompletee,
    required this.lastWeekCountAchatClientCompletee,
    required this.dailyCountAchatClientCompleteeForCurrentWeek,
    required this.currentWeekCountAchatClientLivree,
    required this.lastWeekCountAchatClientLivree,
    required this.dailyCountAchatClientLivreeForCurrentWeek,
    required this.currentWeekCountAchatClientAnnulation,
    required this.lastWeekCountAchatClientAnnulation,
    required this.dailyCountAchatClientAnnulationForCurrentWeek,
    required this.currentWeekCountRetourClientCompletee,
    required this.lastWeekCountRetourClientCompletee,
    required this.dailyCountRetourClientCompleteeForCurrentWeek,
    required this.currentWeekCountRetourClientLivree,
    required this.lastWeekCountRetourClientLivree,
    required this.dailyCountRetourClientLivreeForCurrentWeek,
    required this.currentMonthCount,
    required this.lastMonthCount,
    required this.weeklyCountForCurrentMonth,
    required this.currentYearCount,
    required this.lastYearCount,
    required this.monthlyCountForCurrentYear,
  });
}
