import 'daily_amount.dart';

class PaymentStatistics {
  final double total;
  final List<DailyAmount> daily;

  PaymentStatistics({
    required this.total,
    required this.daily,
  });
}
