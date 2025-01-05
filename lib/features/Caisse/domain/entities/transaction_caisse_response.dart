import 'package:pos_flutter/features/Caisse/domain/entities/cash_details_response.dart';

class TransactionCaisseResponse {
  final double amount;
  final List<CashDetailResponse> cashDetails;

  const TransactionCaisseResponse({
    required this.amount,
    required this.cashDetails,
  });

  TransactionCaisseResponse copyWith({
    double? amount,
    List<CashDetailResponse>? cashDetails,
  }) {
    return TransactionCaisseResponse(
      amount: amount ?? this.amount,
      cashDetails: cashDetails ?? this.cashDetails,
    );
  }

  @override
  String toString() {
    return 'TransactionCaisseResponse(amount: $amount, cashDetails: $cashDetails)';
  }
}
