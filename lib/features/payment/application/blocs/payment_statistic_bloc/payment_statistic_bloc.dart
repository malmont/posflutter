import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/payment/domain/usecases/clear_cached_payment_statistic_useCase.dart';
import 'package:pos_flutter/features/payment/domain/usecases/get_cached_payment_statistic_useCase.dart';
import 'package:pos_flutter/features/payment/domain/usecases/get_remote_payment_statistic_useCase.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/current_month_model.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/current_week_model.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/current_year_model.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payment_statistics_model.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payments_statistics_model.dart';

part 'payment_statistic_event.dart';
part 'payment_statistic_state.dart';

@injectable
class PaymentStatisticBlocBloc
    extends Bloc<PaymentStatisticEvent, PaymentStatisticBlocState> {
  final GetRemotePaymentStatisticUsecase _getRemotePaymentStatisticUsecase;
  final GetCachedPaymentStatisticUsecase _getCachedPaymentStatisticUsecase;
  final ClearCachedPaymentStatisticUseCase _clearCachedPaymentStatisticUseCase;
  PaymentStatisticBlocBloc(
      this._getRemotePaymentStatisticUsecase,
      this._getCachedPaymentStatisticUsecase,
      this._clearCachedPaymentStatisticUseCase)
      : super(PaymentStatisticBlocInitial(
            paymentsStatisticsModel: PaymentsStatisticsModel(
                currentMonth: CurrentMonthModel(
                    paiementClient: 0, remboursementClient: 0),
                currentWeek: CurrentWeekModel(
                    paymentClient: PaymentStatisticsModel(total: 0, daily: []),
                    remboursementClient:
                        PaymentStatisticsModel(total: 0, daily: [])),
                currentYear: CurrentYearModel(
                    paiementClient: 0, remboursementClient: 0)))) {
    on<GetPaymentStatistic>(_onGetPaymentStatistic);
    on<ClearPaymentStatistic>(_onClearCachedPaymentStatistic);
  }

  void _onGetPaymentStatistic(GetPaymentStatistic event,
      Emitter<PaymentStatisticBlocState> emit) async {
    try {
      emit(PaymentStatisticLoading(
          paymentsStatisticsModel: state.paymentsStatisticsModel));
      final cachedResult = await _getCachedPaymentStatisticUsecase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (paymentsStatisticsModel) => emit(PaymentStatisticSuccess(
            paymentsStatisticsModel: paymentsStatisticsModel)),
      );
      final remoteResult = await _getRemotePaymentStatisticUsecase(NoParams());
      remoteResult.fold(
        (failure) => emit(PaymentStatisticFail(
            paymentsStatisticsModel: state.paymentsStatisticsModel,
            failure: failure)),
        (paymentsStatisticsModel) => emit(PaymentStatisticSuccess(
            paymentsStatisticsModel: paymentsStatisticsModel)),
      );
    } catch (e, stackTrace) {
      print('Erreur: $e, stack: $stackTrace');
      emit(PaymentStatisticFail(
          paymentsStatisticsModel: state.paymentsStatisticsModel,
          failure: ServerFailure()));
    }
  }

  void _onClearCachedPaymentStatistic(
      ClearPaymentStatistic event, Emitter<PaymentStatisticBlocState> emit) {
    _clearCachedPaymentStatisticUseCase(NoParams());
    emit(PaymentStatisticBlocInitial(
        paymentsStatisticsModel: PaymentsStatisticsModel(
            currentMonth:
                CurrentMonthModel(paiementClient: 0, remboursementClient: 0),
            currentWeek: CurrentWeekModel(
                paymentClient: PaymentStatisticsModel(total: 0, daily: []),
                remboursementClient:
                    PaymentStatisticsModel(total: 0, daily: [])),
            currentYear:
                CurrentYearModel(paiementClient: 0, remboursementClient: 0))));
  }
}
