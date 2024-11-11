part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class GetPayments extends PaymentEvent {
  final FilterOrderParams params;
  const GetPayments(this.params);

  @override
  List<Object> get props => [params];
}
