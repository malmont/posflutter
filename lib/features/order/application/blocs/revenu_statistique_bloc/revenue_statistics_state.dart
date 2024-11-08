part of 'revenue_statistics_bloc.dart';

abstract class RevenueStatisticsState extends Equatable {
  const RevenueStatisticsState();

  @override
  List<Object?> get props => [];
}

class RevenueStatisticsInitial extends RevenueStatisticsState {}

class RevenueStatisticsLoadInProgress extends RevenueStatisticsState {}

class RevenueStatisticsLoadSuccess extends RevenueStatisticsState {
  final RevenueStatisticsModel revenueStatisticsModel;
  const RevenueStatisticsLoadSuccess(this.revenueStatisticsModel);

  @override
  List<Object?> get props => [revenueStatisticsModel];
}

class RevenueStatisticsLoadFailure extends RevenueStatisticsState {
  final Failure failure;
  const RevenueStatisticsLoadFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
