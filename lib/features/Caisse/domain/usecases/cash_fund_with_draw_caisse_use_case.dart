import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/Caisse/domain/repositories/caisse_repository.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/transaction_caisse_response_model.dart';

@lazySingleton
class CashFundWithDrawCaisseUseCase
    implements UseCase<bool, TransactionCaisseResponseModel> {
  final CaisseRepository repository;
  CashFundWithDrawCaisseUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(
      TransactionCaisseResponseModel transactionCaisseResponse) async {
    return await repository.cashFundWithdrawCaisse(transactionCaisseResponse);
  }
}
