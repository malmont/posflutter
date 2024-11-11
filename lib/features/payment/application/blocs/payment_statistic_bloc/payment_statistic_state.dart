part of 'payment_statistic_bloc.dart';

abstract class PaymentStatisticBlocState extends Equatable {
  final PaymentsStatisticsModel paymentsStatisticsModel;
  const PaymentStatisticBlocState({required this.paymentsStatisticsModel});

  @override
  List<Object> get props => [paymentsStatisticsModel];
}

final class PaymentStatisticBlocInitial extends PaymentStatisticBlocState {
  const PaymentStatisticBlocInitial({required super.paymentsStatisticsModel});
}

final class PaymentStatisticLoading extends PaymentStatisticBlocState {
  const PaymentStatisticLoading({required super.paymentsStatisticsModel});
}

final class PaymentStatisticSuccess extends PaymentStatisticBlocState {
  const PaymentStatisticSuccess({required super.paymentsStatisticsModel});
}

final class PaymentStatisticFail extends PaymentStatisticBlocState {
  final Failure failure;
  const PaymentStatisticFail(
      {required super.paymentsStatisticsModel, required this.failure});

  @override
  List<Object> get props => [failure];
}
