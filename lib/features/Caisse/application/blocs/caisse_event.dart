part of 'caisse_bloc.dart';

abstract class CaisseEvent extends Equatable {
  const CaisseEvent();
}

class GetCaisse extends CaisseEvent {
  final int days;
  const GetCaisse({required this.days});

  @override
  List<Object> get props => [days];
}

class ClearLocalCaisse extends CaisseEvent {
  const ClearLocalCaisse();

  @override
  List<Object> get props => [];
}

class CloseCaisse extends CaisseEvent {
  const CloseCaisse();

  @override
  List<Object> get props => [];
}

class OpenCaisse extends CaisseEvent {
  const OpenCaisse();

  @override
  List<Object> get props => [];
}

class WithDrawCaisse extends CaisseEvent {
  final TransactionCaisseResponseModel transactionCaisseResponse;
  const WithDrawCaisse(this.transactionCaisseResponse);

  @override
  List<Object> get props => [transactionCaisseResponse];
}

class DepositCaisse extends CaisseEvent {
  final TransactionCaisseResponseModel transactionCaisseResponse;
  const DepositCaisse(this.transactionCaisseResponse);

  @override
  List<Object> get props => [transactionCaisseResponse];
}

class CashFundDepositCaisse extends CaisseEvent {
  final TransactionCaisseResponseModel transactionCaisseResponse;
  const CashFundDepositCaisse(this.transactionCaisseResponse);

  @override
  List<Object> get props => [transactionCaisseResponse];
}

class CashFundWithdrawCaisse extends CaisseEvent {
  final TransactionCaisseResponseModel transactionCaisseResponse;
  const CashFundWithdrawCaisse(this.transactionCaisseResponse);

  @override
  List<Object> get props => [transactionCaisseResponse];
}
