import 'package:pos_flutter/features/payment/domain/entities/current_month.dart';

class CurrentMonthModel extends CurrentMonth {
  CurrentMonthModel({
    required double paiementClient,
    required double remboursementClient,
  }) : super(
          paiementClient: paiementClient,
          remboursementClient: remboursementClient,
        );

  factory CurrentMonthModel.fromJson(Map<String, dynamic> json) {
    return CurrentMonthModel(
      paiementClient: (json['PaiementClient'] as num).toDouble(),
      remboursementClient: (json['RemboursementClient'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PaiementClient': paiementClient,
      'RemboursementClient': remboursementClient,
    };
  }

  factory CurrentMonthModel.fromEntity(CurrentMonth entity) {
    return CurrentMonthModel(
      paiementClient: entity.paiementClient,
      remboursementClient: entity.remboursementClient,
    );
  }
}
