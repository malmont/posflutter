import 'package:pos_flutter/features/Caisse/domain/entities/cash_detail.dart';

class TransactionCaisse {
  final int id;
  final String transactionDate;
  final double amount;
  final String transactionType;
  final List<CashDetail> cashDetails;

  TransactionCaisse({
    required this.id,
    required this.transactionDate,
    required this.amount,
    required this.transactionType,
    required this.cashDetails,
  });
}
