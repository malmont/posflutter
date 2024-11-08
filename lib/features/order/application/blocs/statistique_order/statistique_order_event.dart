part of 'statistique_order_bloc.dart';

abstract class StatistiqueOrderEvent extends Equatable {
  const StatistiqueOrderEvent();
}

class GetStatistiqueOrder extends StatistiqueOrderEvent {
  const GetStatistiqueOrder();

  @override
  List<Object?> get props => [];
}

class ClearLocalStatistiqueOrder extends StatistiqueOrderEvent {
  const ClearLocalStatistiqueOrder();

  @override
  List<Object?> get props => [];
}
