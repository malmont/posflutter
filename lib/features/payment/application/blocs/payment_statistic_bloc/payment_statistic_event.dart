part of 'payment_statistic_bloc.dart';

abstract class PaymentStatisticEvent extends Equatable {
  const PaymentStatisticEvent();
}

class GetPaymentStatistic extends PaymentStatisticEvent {
  const GetPaymentStatistic();

  @override
  List<Object> get props => [];
}

class ClearPaymentStatistic extends PaymentStatisticEvent {
  const ClearPaymentStatistic();

  @override
  List<Object> get props => [];
}
