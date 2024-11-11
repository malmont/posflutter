import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/payment/domain/entities/payment_details.dart';
import 'package:pos_flutter/features/payment/domain/usecases/get_cached_payment_usecase.dart';
import 'package:pos_flutter/features/payment/domain/usecases/get_remote_payment_usecase.dart';

part 'payment_state.dart';
part 'payment_event.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetRemotePaymentUsecase _getPaymentsUseCase;
  final GetCachedPaymentUsecase _getCachedPaymentsUseCase;
  PaymentBloc(this._getPaymentsUseCase, this._getCachedPaymentsUseCase)
      : super(const PaymentInitial(payments: [], params: FilterOrderParams())) {
    on<GetPayments>(_onGetPayments);
  }

  void _onGetPayments(GetPayments event, Emitter<PaymentState> emit) async {
    try {
      emit(PaymentFetchLoading(payments: state.payments, params: event.params));
      final cachedResult = await _getCachedPaymentsUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (payments) => emit(const PaymentFetchSuccess(
            payments: [], params: FilterOrderParams())),
      );
      final remoteResult = await _getPaymentsUseCase(event.params);
      remoteResult.fold(
        (failure) => emit(PaymentFecthFail(
            payments: state.payments, params: event.params, failure: failure)),
        (payments) =>
            emit(PaymentFetchSuccess(payments: payments, params: event.params)),
      );
    } catch (e, stackTrace) {
      print('Erreur: $e, stack: $stackTrace');
      emit(PaymentFecthFail(
          payments: state.payments,
          params: state.params,
          failure: ServerFailure()));
    }
  }
}
