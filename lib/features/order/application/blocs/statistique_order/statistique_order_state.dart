part of 'statistique_order_bloc.dart';

abstract class StatistiqueOrderState extends Equatable {
  const StatistiqueOrderState();

  @override
  List<Object?> get props => [];
}

class StatistiqueOrderInitial extends StatistiqueOrderState {}

class StatistiqueOrderLoadInProgress extends StatistiqueOrderState {}

class StatistiqueOrderLoadSuccess extends StatistiqueOrderState {
  final StatistiqueOrderModel statistiqueOrderModel;
  const StatistiqueOrderLoadSuccess(this.statistiqueOrderModel);

  @override
  List<Object?> get props => [statistiqueOrderModel];
}

class StatistiqueOrderLoadFailure extends StatistiqueOrderState {
  final Failure failure;
  const StatistiqueOrderLoadFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
