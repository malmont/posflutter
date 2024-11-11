import 'package:pos_flutter/features/payment/domain/entities/current_month.dart';
import 'package:pos_flutter/features/payment/domain/entities/current_week.dart';
import 'package:pos_flutter/features/payment/domain/entities/current_year.dart';

class PaymentsStatistics {
  final CurrentWeek currentWeek;
  final CurrentMonth currentMonth;
  final CurrentYear currentYear;

  PaymentsStatistics({
    required this.currentWeek,
    required this.currentMonth,
    required this.currentYear,
  });
}
