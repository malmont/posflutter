import 'package:pos_flutter/features/order/domain/entities/daily_order_count.dart';
import 'package:pos_flutter/features/order/domain/entities/statistique_order.dart';
import 'package:pos_flutter/features/order/infrastucture/models/daily_order_count_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/monthly_order_count_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/weekly_order_count_model.dart';

class StatistiqueOrderModel extends StatistiqueOrder {
  StatistiqueOrderModel({
    required int currentWeekCountAchatClientCompletee,
    required int lastWeekCountAchatClientCompletee,
    required List<DailyOrderCountModel>
        dailyCountAchatClientCompleteeForCurrentWeek,
    required int currentWeekCountAchatClientLivree,
    required int lastWeekCountAchatClientLivree,
    required List<DailyOrderCountModel>
        dailyCountAchatClientLivreeForCurrentWeek,
    required int currentWeekCountAchatClientAnnulation,
    required int lastWeekCountAchatClientAnnulation,
    required List<DailyOrderCountModel>
        dailyCountAchatClientAnnulationForCurrentWeek,
    required int currentWeekCountRetourClientCompletee,
    required int lastWeekCountRetourClientCompletee,
    required List<DailyOrderCountModel>
        dailyCountRetourClientCompleteeForCurrentWeek,
    required int currentWeekCountRetourClientLivree,
    required int lastWeekCountRetourClientLivree,
    required List<DailyOrderCountModel>
        dailyCountRetourClientLivreeForCurrentWeek,
    required int currentMonthCount,
    required int lastMonthCount,
    required List<WeeklyOrderCountModel> weeklyCountForCurrentMonth,
    required int currentYearCount,
    required int lastYearCount,
    required List<MonthlyOrderCountModel> monthlyCountForCurrentYear,
  }) : super(
          currentWeekCountAchatClientCompletee:
              currentWeekCountAchatClientCompletee,
          lastWeekCountAchatClientCompletee: lastWeekCountAchatClientCompletee,
          dailyCountAchatClientCompleteeForCurrentWeek:
              dailyCountAchatClientCompleteeForCurrentWeek,
          currentWeekCountAchatClientLivree: currentWeekCountAchatClientLivree,
          lastWeekCountAchatClientLivree: lastWeekCountAchatClientLivree,
          dailyCountAchatClientLivreeForCurrentWeek:
              dailyCountAchatClientLivreeForCurrentWeek,
          currentWeekCountAchatClientAnnulation:
              currentWeekCountAchatClientAnnulation,
          lastWeekCountAchatClientAnnulation:
              lastWeekCountAchatClientAnnulation,
          dailyCountAchatClientAnnulationForCurrentWeek:
              dailyCountAchatClientAnnulationForCurrentWeek,
          currentWeekCountRetourClientCompletee:
              currentWeekCountRetourClientCompletee,
          lastWeekCountRetourClientCompletee:
              lastWeekCountRetourClientCompletee,
          dailyCountRetourClientCompleteeForCurrentWeek:
              dailyCountRetourClientCompleteeForCurrentWeek,
          currentWeekCountRetourClientLivree:
              currentWeekCountRetourClientLivree,
          lastWeekCountRetourClientLivree: lastWeekCountRetourClientLivree,
          dailyCountRetourClientLivreeForCurrentWeek:
              dailyCountRetourClientLivreeForCurrentWeek,
          currentMonthCount: currentMonthCount,
          lastMonthCount: lastMonthCount,
          weeklyCountForCurrentMonth: weeklyCountForCurrentMonth,
          currentYearCount: currentYearCount,
          lastYearCount: lastYearCount,
          monthlyCountForCurrentYear: monthlyCountForCurrentYear,
        );

  factory StatistiqueOrderModel.fromJson(Map<String, dynamic> json) {
    return StatistiqueOrderModel(
      currentWeekCountAchatClientCompletee:
          json['currentWeekCountAchatClientComplétée'],
      lastWeekCountAchatClientCompletee:
          json['lastWeekCountAchatClientComplétée'],
      dailyCountAchatClientCompleteeForCurrentWeek:
          (json['dailyCountAchatClient_ComplétéeForCurrentWeek'] as List)
              .map((item) => DailyOrderCountModel.fromJson(item))
              .toList(),
      currentWeekCountAchatClientLivree:
          json['currentWeekCountAchatClientLivrée'],
      lastWeekCountAchatClientLivree: json['lastWeekCountAchatClientLivrée'],
      dailyCountAchatClientLivreeForCurrentWeek:
          (json['dailyCountAchatClient_LivréeForCurrentWeek'] as List)
              .map((item) => DailyOrderCountModel.fromJson(item))
              .toList(),
      currentWeekCountAchatClientAnnulation:
          json['currentWeekCountAchatClientAnnulation'],
      lastWeekCountAchatClientAnnulation:
          json['lastWeekCountAchatClientAnnulation'],
      dailyCountAchatClientAnnulationForCurrentWeek:
          (json['dailyCountAchatClient_AnnulationForCurrentWeek'] as List)
              .map((item) => DailyOrderCountModel.fromJson(item))
              .toList(),
      currentWeekCountRetourClientCompletee:
          json['currentWeekCountRetourClientComplétée'],
      lastWeekCountRetourClientCompletee:
          json['lastWeekCountRetourClientComplétée'],
      dailyCountRetourClientCompleteeForCurrentWeek:
          (json['dailyCountRetourClient_ComplétéeForCurrentWeek'] as List)
              .map((item) => DailyOrderCountModel.fromJson(item))
              .toList(),
      currentWeekCountRetourClientLivree:
          json['currentWeekCountRetourClientLivrée'],
      lastWeekCountRetourClientLivree: json['lastWeekCountRetourClientLivrée'],
      dailyCountRetourClientLivreeForCurrentWeek:
          (json['dailyCountRetourClient_LivréeForCurrentWeek'] as List)
              .map((item) => DailyOrderCountModel.fromJson(item))
              .toList(),
      currentMonthCount: json['currentMonthCount'],
      lastMonthCount: json['lastMonthCount'],
      weeklyCountForCurrentMonth: (json['weeklyCountForCurrentMonth'] as List)
          .map((item) => WeeklyOrderCountModel.fromJson(item))
          .toList(),
      currentYearCount: json['currentYearCount'],
      lastYearCount: json['lastYearCount'],
      monthlyCountForCurrentYear: (json['monthlyCountForCurrentYear'] as List)
          .map((item) => MonthlyOrderCountModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentWeekCountAchatClientComplétée':
          currentWeekCountAchatClientCompletee,
      'lastWeekCountAchatClientComplétée': lastWeekCountAchatClientCompletee,
      'dailyCountAchatClient_ComplétéeForCurrentWeek': List<dynamic>.from(
          dailyCountAchatClientCompleteeForCurrentWeek
              .map((x) => DailyOrderCountModel.fromEntity(x).toJson())),
      'currentWeekCountAchatClientLivrée': currentWeekCountAchatClientLivree,
      'lastWeekCountAchatClientLivrée': lastWeekCountAchatClientLivree,
      'dailyCountAchatClient_LivréeForCurrentWeek': List<dynamic>.from(
          dailyCountAchatClientLivreeForCurrentWeek
              .map((x) => DailyOrderCountModel.fromEntity(x).toJson())),
      'currentWeekCountAchatClientAnnulation':
          currentWeekCountAchatClientAnnulation,
      'lastWeekCountAchatClientAnnulation': lastWeekCountAchatClientAnnulation,
      'dailyCountAchatClient_AnnulationForCurrentWeek': List<dynamic>.from(
          dailyCountAchatClientAnnulationForCurrentWeek
              .map((x) => DailyOrderCountModel.fromEntity(x).toJson())),
      'currentWeekCountRetourClientComplétée':
          currentWeekCountRetourClientCompletee,
      'lastWeekCountRetourClientComplétée': lastWeekCountRetourClientCompletee,
      'dailyCountRetourClient_ComplétéeForCurrentWeek': List<dynamic>.from(
          dailyCountRetourClientCompleteeForCurrentWeek
              .map((x) => DailyOrderCountModel.fromEntity(x).toJson())),
      'currentWeekCountRetourClientLivrée': currentWeekCountRetourClientLivree,
      'lastWeekCountRetourClientLivrée': lastWeekCountRetourClientLivree,
      'dailyCountRetourClient_LivréeForCurrentWeek': List<dynamic>.from(
          dailyCountRetourClientLivreeForCurrentWeek
              .map((x) => DailyOrderCountModel.fromEntity(x).toJson())),
      'currentMonthCount': currentMonthCount,
      'lastMonthCount': lastMonthCount,
      'weeklyCountForCurrentMonth': List<dynamic>.from(
          weeklyCountForCurrentMonth
              .map((x) => WeeklyOrderCountModel.fromEntity(x).toJson())),
      'currentYearCount': currentYearCount,
      'lastYearCount': lastYearCount,
      'monthlyCountForCurrentYear': List<dynamic>.from(
          monthlyCountForCurrentYear
              .map((x) => MonthlyOrderCountModel.fromEntity(x).toJson())),
    };
  }
}
