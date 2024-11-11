part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  final List<PaymentDetails> payments;
  final FilterOrderParams params;
  const PaymentState({
    required this.payments,
    required this.params,
  });
  @override
  List<Object> get props => [payments, params];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial({
    required super.payments,
    required super.params,
  });
}

class PaymentFetchLoading extends PaymentState {
  const PaymentFetchLoading({
    required super.payments,
    required super.params,
  });
}

class PaymentFetchSuccess extends PaymentState {
  const PaymentFetchSuccess({
    required super.payments,
    required super.params,
  });
  @override
  List<Object> get props => [payments, params];
}

class PaymentFecthFail extends PaymentState {
  final Failure failure;
  const PaymentFecthFail({
    required super.payments,
    required super.params,
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}
