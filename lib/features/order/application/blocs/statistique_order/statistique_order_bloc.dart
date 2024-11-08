import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/order/domain/usecases/clear_local_statistique_order_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_cached_statistique_order_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_remote_statistique_order_UseCase.dart';
import 'package:pos_flutter/features/order/infrastucture/models/statistique_order_model.dart';

part 'statistique_order_event.dart';
part 'statistique_order_state.dart';

@injectable
class StatistiqueOrderBloc
    extends Bloc<StatistiqueOrderEvent, StatistiqueOrderState> {
  final GetRemoteStatistiqueOrderUseCase _getRemoteStatistiqueOrderUseCase;
  final GetCachedStatisticsOrderUseCase _getCachedStatisticsOrderUseCase;
  final ClearLocalStatisticsOrderUseCase _clearLocalStatisticsOrderUseCase;

  StatistiqueOrderBloc(
      this._getRemoteStatistiqueOrderUseCase,
      this._getCachedStatisticsOrderUseCase,
      this._clearLocalStatisticsOrderUseCase)
      : super(StatistiqueOrderInitial()) {
    on<GetStatistiqueOrder>(_onGetStatistiqueOrder);
    on<ClearLocalStatistiqueOrder>(_onClearLocalStatistiqueOrder);
  }

  Future<void> _onGetStatistiqueOrder(
      GetStatistiqueOrder event, Emitter<StatistiqueOrderState> emit) async {
    emit(StatistiqueOrderLoadInProgress());
    final cachedResult = await _getCachedStatisticsOrderUseCase(NoParams());
    cachedResult.fold(
      (failure) => emit(StatistiqueOrderLoadFailure(failure)),
      (statistiqueOrder) => emit(StatistiqueOrderLoadSuccess(statistiqueOrder)),
    );
    final remoteResult = await _getRemoteStatistiqueOrderUseCase(NoParams());
    remoteResult.fold(
      (failure) => emit(StatistiqueOrderLoadFailure(failure)),
      (statistiqueOrder) => emit(StatistiqueOrderLoadSuccess(statistiqueOrder)),
    );
  }

  Future<void> _onClearLocalStatistiqueOrder(ClearLocalStatistiqueOrder event,
      Emitter<StatistiqueOrderState> emit) async {
    final result = await _clearLocalStatisticsOrderUseCase(NoParams());
    result.fold(
      (failure) => emit(StatistiqueOrderLoadFailure(failure)),
      (_) => emit(StatistiqueOrderInitial()),
    );
  }
}
