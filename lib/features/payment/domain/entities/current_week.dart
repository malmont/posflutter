import 'payment_statistics.dart';

class CurrentWeek {
  final PaymentStatistics paymentClient;
  final PaymentStatistics remboursementClient;

  CurrentWeek({
    required this.paymentClient,
    required this.remboursementClient,
  });
}
