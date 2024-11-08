part of 'revenue_statistics_bloc.dart';

abstract class RevenueStatisticsEvent extends Equatable {
  const RevenueStatisticsEvent();
}

class GetRevenueStatistics extends RevenueStatisticsEvent {
  const GetRevenueStatistics();

  @override
  List<Object?> get props => [];
}

class ClearLocalRevenueStatistics extends RevenueStatisticsEvent {
  const ClearLocalRevenueStatistics();

  @override
  List<Object?> get props => [];
}
