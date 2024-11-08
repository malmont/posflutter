part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  @override
  List<Object?> get props => [];
}

// État initial
class OrderInitial extends OrderState {}

// États pour les commandes
class OrderLoadInProgress extends OrderState {}

class OrderLoadSuccess extends OrderState {
  final List<OrderDetails> orders;
  const OrderLoadSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderLoadFailure extends OrderState {
  final Failure failure;
  const OrderLoadFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

// États pour l'ajout de commande
class OrderAddInProgress extends OrderState {}

class OrderAddSuccess extends OrderState {
  final bool isSuccess;
  const OrderAddSuccess(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class OrderAddFailure extends OrderState {
  final Failure failure;
  const OrderAddFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
