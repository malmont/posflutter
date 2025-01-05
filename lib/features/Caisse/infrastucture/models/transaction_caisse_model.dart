import 'package:pos_flutter/features/Caisse/domain/entities/transaction_caisse.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/cash_detail_model.dart';

class TransactionCaisseModel extends TransactionCaisse {
  TransactionCaisseModel({
    required int id,
    required String transactionDate,
    required double amount,
    required String transactionType,
    required List<CashDetailModel> cashDetails,
  }) : super(
          id: id,
          transactionDate: transactionDate,
          amount: amount,
          transactionType: transactionType,
          cashDetails: cashDetails,
        );

  // Désérialisation manuelle
  factory TransactionCaisseModel.fromJson(Map<String, dynamic> json) {
    return TransactionCaisseModel(
      id: json['id'] as int,
      transactionDate: json['transactionDate'] as String,
      amount: (json['amount'] as num).toDouble(),
      transactionType: json['transactionType'] as String,
      cashDetails: (json['cashDetails'] as List<dynamic>?)
              ?.map((detail) =>
                  CashDetailModel.fromJson(detail as Map<String, dynamic>))
              .toList() ??
          [], // Retourne une liste vide si `cashDetails` est null
    );
  }

  // Sérialisation manuelle
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionDate': transactionDate,
      'amount': amount,
      'transactionType': transactionType,
      'cashDetails': cashDetails
          .map((detail) => (detail as CashDetailModel).toJson())
          .toList(),
    };
  }

  // Conversion depuis une entité
  factory TransactionCaisseModel.fromEntity(TransactionCaisse entity) {
    return TransactionCaisseModel(
      id: entity.id,
      transactionDate: entity.transactionDate,
      amount: entity.amount,
      transactionType: entity.transactionType,
      cashDetails: entity.cashDetails
          .map((detail) => CashDetailModel.fromEntity(detail))
          .toList(),
    );
  }

  // Conversion vers une entité
  TransactionCaisse toEntity() {
    return TransactionCaisse(
      id: id,
      transactionDate: transactionDate,
      amount: amount,
      transactionType: transactionType,
      cashDetails: cashDetails.map((detail) {
        if (detail is CashDetailModel) {
          return detail.toEntity();
        } else {
          return detail;
        }
      }).toList(),
    );
  }
}
