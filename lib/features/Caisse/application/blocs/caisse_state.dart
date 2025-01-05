part of 'caisse_bloc.dart';

abstract class CaisseState extends Equatable {
  final List<Caisse> caisses;
  final int days;
  final TransactionCaisseResponseModel transactionCaisseResponse;
  const CaisseState({
    required this.caisses,
    required this.days,
    required this.transactionCaisseResponse,
  });
  @override
  List<Object> get props => [caisses, days, transactionCaisseResponse];
}

class CaisseInitial extends CaisseState {
  const CaisseInitial({
    required super.caisses,
    required super.days,
    required super.transactionCaisseResponse,
  });
}

class CaisseLoading extends CaisseState {
  const CaisseLoading({
    required super.caisses,
    required super.days,
    required super.transactionCaisseResponse,
  });
}

class CaisseMouvement extends CaisseState {
  final bool isSucces;
  const CaisseMouvement({
    required super.caisses,
    required super.days,
    required super.transactionCaisseResponse,
    required this.isSucces,
  });
}

class CaisseSuccess extends CaisseState {
  const CaisseSuccess({
    required super.caisses,
    required super.days,
    required super.transactionCaisseResponse,
  });
}

class CaisseFail extends CaisseState {
  final Failure failure;
  const CaisseFail({
    required super.caisses,
    required super.days,
    required super.transactionCaisseResponse,
    required this.failure,
  });
}
