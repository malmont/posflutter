import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/exeptions.dart';
import 'package:pos_flutter/core/services/api/caisse_api_client.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/caisse_model.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/transaction_caisse_response_model.dart';
import 'package:retrofit/dio.dart';

abstract class CaisseRemoteDataSource {
  Future<bool> openCaise(noParams);
  Future<List<CaisseModel>> getCaisse(int days);
  Future<bool> closeCaise(noParams);
  Future<bool> depositCaisse(
      TransactionCaisseResponseModel transactionCaisseResponse);
  Future<bool> withdrawCaisse(
      TransactionCaisseResponseModel transactionCaisseResponse);

  Future<bool> cashFundDeposit(
      TransactionCaisseResponseModel transactionCaisseResponse);
  Future<bool> cashFundWithdraw(
      TransactionCaisseResponseModel transactionCaisseResponse);
}

@LazySingleton(as: CaisseRemoteDataSource)
class CaisseRemoteDataSourceImpl implements CaisseRemoteDataSource {
  final CaisseApiClient apiClient;

  CaisseRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<bool> openCaise(noParams) async {
    try {
      final HttpResponse response = await apiClient.openCaisse();
      if (response.response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CaisseModel>> getCaisse(int days) async {
    try {
      final response = await apiClient.getCaisse(days);
      return response;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> closeCaise(noParams) async {
    try {
      final HttpResponse response = await apiClient.closeCaisse();
      if (response.response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> depositCaisse(
      TransactionCaisseResponseModel transactionCaisseResponse) async {
    try {
      final HttpResponse response =
          await apiClient.depositCaisse(transactionCaisseResponse);
      if (response.response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> withdrawCaisse(
      TransactionCaisseResponseModel transactionCaisseResponse) async {
    try {
      final HttpResponse response =
          await apiClient.withdrawCaisse(transactionCaisseResponse);
      if (response.response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> cashFundDeposit(
      TransactionCaisseResponseModel transactionCaisseResponse) async {
    try {
      final HttpResponse response =
          await apiClient.cashFundDeposit(transactionCaisseResponse);
      if (response.response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> cashFundWithdraw(
      TransactionCaisseResponseModel transactionCaisseResponse) async {
    try {
      final HttpResponse response =
          await apiClient.cashFundWithdraw(transactionCaisseResponse);
      if (response.response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException();
    }
  }
}
