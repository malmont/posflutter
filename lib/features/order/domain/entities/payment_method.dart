import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final int type;
  final double amount;

  const PaymentMethod({
    required this.type,
    required this.amount,
  });

  @override
  List<Object?> get props => [type, amount];
}
