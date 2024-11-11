import 'package:pos_flutter/features/payment/domain/entities/current_week.dart';

import 'payment_statistics_model.dart';

class CurrentWeekModel extends CurrentWeek {
  CurrentWeekModel({
    required PaymentStatisticsModel paymentClient,
    required PaymentStatisticsModel remboursementClient,
  }) : super(
          paymentClient: paymentClient,
          remboursementClient: remboursementClient,
        );

  factory CurrentWeekModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeekModel(
      paymentClient: PaymentStatisticsModel.fromJson(json['PaiementClient']),
      remboursementClient:
          PaymentStatisticsModel.fromJson(json['RemboursementClient']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PaiementClient': (paymentClient as PaymentStatisticsModel).toJson(),
      'RemboursementClient':
          (remboursementClient as PaymentStatisticsModel).toJson(),
    };
  }

  factory CurrentWeekModel.fromEntity(CurrentWeek entity) {
    return CurrentWeekModel(
      paymentClient: PaymentStatisticsModel.fromEntity(entity.paymentClient),
      remboursementClient:
          PaymentStatisticsModel.fromEntity(entity.remboursementClient),
    );
  }
}
