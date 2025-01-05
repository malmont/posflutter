import 'dart:convert';

import 'package:pos_flutter/features/Caisse/domain/entities/transaction_caisse_response.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/cash_details_response_model.dart';

class TransactionCaisseResponseModel extends TransactionCaisseResponse {
  const TransactionCaisseResponseModel({
    required super.amount,
    required List<CashDetailResponseModel> super.cashDetails,
  });

  factory TransactionCaisseResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionCaisseResponseModel(
      amount: json["amount"],
      cashDetails: List<CashDetailResponseModel>.from(
        json["cashDetails"].map((x) => CashDetailResponseModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "cashDetails": cashDetails
            .map((x) => (x as CashDetailResponseModel).toJson())
            .toList(),
      };

  factory TransactionCaisseResponseModel.fromParent(
      TransactionCaisseResponse transaction) {
    return TransactionCaisseResponseModel(
      amount: transaction.amount,
      cashDetails: transaction.cashDetails
          .map((detail) => CashDetailResponseModel.fromEntity(detail))
          .toList(),
    );
  }
}
