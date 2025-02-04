// On va lier les fichiers event et state au bloc via "part".
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/features/products/domain/entities/product/filter_product_params.dart';
import 'package:pos_flutter/features/products/domain/entities/product/product.dart';
import 'package:pos_flutter/features/products/domain/usecases/get_product_usecase.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

@injectable
class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final GetProductUseCase _getProductUseCase;

  ScannerBloc(this._getProductUseCase) : super(ScannerInitial()) {
    on<ScanProductEvent>(_onScanProductEvent);
  }

  Future<void> _onScanProductEvent(
    ScanProductEvent event,
    Emitter<ScannerState> emit,
  ) async {
    emit(ScannerLoading());

    // Appel du usecase pour récupérer le produit scanné
    final result = await _getProductUseCase(
      FilterProductParams(
        barcode: event.barcode,
        limit: 1,
        pageSize: 1,
      ),
    );

    result.fold(
      (failure) {
        // État d'erreur si le backend renvoie un échec ou autre
        emit(ScannerError(failure));
      },
      (productResponse) {
        // Si pas de produit
        if (productResponse.products.isEmpty) {
          emit(ScannerError(ExceptionFailure()));
        } else {
          // On prend le 1er produit renvoyé
          final productScanned = productResponse.products.first;
          emit(ScannerLoaded(productScanned));
        }
      },
    );
  }
}
