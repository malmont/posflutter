import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/order/domain/usecases/clear_local_revenue_statistics_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_cached_revenue_statistics_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_remote_revenue_statistics_useCase.dart';
import 'package:pos_flutter/features/order/infrastucture/models/revenue_statistics_model.dart';

part 'revenue_statistics_event.dart';
part 'revenue_statistics_state.dart';

@injectable
class RevenueStatisticsBloc
    extends Bloc<RevenueStatisticsEvent, RevenueStatisticsState> {
  final GetRemoteRevenueStatisticsUseCase _getRemoteRevenueStatisticsUseCase;
  final GetCachedRevenueStatisticsUseCase _getCachedRevenueStatisticsUseCase;
  final ClearLocalRevenueStatisticsUseCase _clearLocalRevenueStatisticsUseCase;

  RevenueStatisticsBloc(
      this._getRemoteRevenueStatisticsUseCase,
      this._getCachedRevenueStatisticsUseCase,
      this._clearLocalRevenueStatisticsUseCase)
      : super(RevenueStatisticsInitial()) {
    on<GetRevenueStatistics>(_onGetRevenueStatistics);
    on<ClearLocalRevenueStatistics>(_onClearLocalRevenueStatistics);
  }

  Future<void> _onGetRevenueStatistics(
      GetRevenueStatistics event, Emitter<RevenueStatisticsState> emit) async {
    emit(RevenueStatisticsLoadInProgress());
    final cachedResult = await _getCachedRevenueStatisticsUseCase(NoParams());
    cachedResult.fold(
      (failure) => emit(RevenueStatisticsLoadFailure(failure)),
      (revenueStatistics) =>
          emit(RevenueStatisticsLoadSuccess(revenueStatistics)),
    );
    final remoteResult = await _getRemoteRevenueStatisticsUseCase(NoParams());
    remoteResult.fold(
      (failure) => emit(RevenueStatisticsLoadFailure(failure)),
      (revenueStatistics) =>
          emit(RevenueStatisticsLoadSuccess(revenueStatistics)),
    );
  }

  Future<void> _onClearLocalRevenueStatistics(ClearLocalRevenueStatistics event,
      Emitter<RevenueStatisticsState> emit) async {
    final result = await _clearLocalRevenueStatisticsUseCase(NoParams());
    result.fold(
      (failure) => emit(RevenueStatisticsLoadFailure(failure)),
      (_) => emit(RevenueStatisticsInitial()),
    );
  }
}
