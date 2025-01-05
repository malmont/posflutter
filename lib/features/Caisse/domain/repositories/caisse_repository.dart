import 'package:dartz/dartz.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/transaction_caisse_response_model.dart';

abstract class CaisseRepository {
  Future<Either<Failure, bool>> openCaisse(noParams);
  Future<Either<Failure, List<Caisse>>> getRemoteCaisse(int days);
  Future<Either<Failure, bool>> closeCaisse(noParams);
  Future<Either<Failure, bool>> depositCaisse(
      TransactionCaisseResponseModel transactionCaisseResponse);
  Future<Either<Failure, bool>> withdrawCaisse(
      TransactionCaisseResponseModel transactionCaisseResponse);
  Future<Either<Failure, bool>> cashFundDepositCaisse(
      TransactionCaisseResponseModel transactionCaisseResponse);
  Future<Either<Failure, bool>> cashFundWithdrawCaisse(
      TransactionCaisseResponseModel transactionCaisseResponse);
  Future<Either<Failure, List<Caisse>>> getCachedCaisse(noParams);
  Future<Either<Failure, NoParams>> clearLocalCaisse(noParams);
}
