import 'package:pos_flutter/features/payment/domain/entities/current_year.dart';

class CurrentYearModel extends CurrentYear {
  CurrentYearModel({
    required double paiementClient,
    required double remboursementClient,
  }) : super(
          paiementClient: paiementClient,
          remboursementClient: remboursementClient,
        );

  factory CurrentYearModel.fromJson(Map<String, dynamic> json) {
    return CurrentYearModel(
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

  factory CurrentYearModel.fromEntity(CurrentYear entity) {
    return CurrentYearModel(
      paiementClient: entity.paiementClient,
      remboursementClient: entity.remboursementClient,
    );
  }
}
