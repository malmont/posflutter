import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payment_details_model.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payments_statistics_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PaymentLocalDataSource {
  Future<void> savePayment(List<PaymentDetailsModel> params);
  Future<void> clearPayment();
  Future<List<PaymentDetailsModel>> getPayments();
  Future<PaymentsStatisticsModel> getPaymentStatistique();
  Future<void> savePaymentStatistique(PaymentsStatisticsModel params);
  Future<void> clearPaymentStatistique();
}

const cachedPayments = 'CACHED_PAYMENTS';
const cachedPaymentStatistique = 'CACHED_PAYMENT_STATISTIQUE';

@LazySingleton(as: PaymentLocalDataSource)
class PaymentLocalDataSourceImpl implements PaymentLocalDataSource {
  final SharedPreferences sharedPreferences;
  PaymentLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PaymentDetailsModel>> getPayments() {
    final jsonString = sharedPreferences.getString(cachedPayments);
    if (jsonString != null) {
      return Future.value(paymentDetailsModelListFromLocalJson(jsonString));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> savePayment(List<PaymentDetailsModel> params) {
    return sharedPreferences.setString(
      cachedPayments,
      paymentModelListToJson(params),
    );
  }

  @override
  Future<void> clearPayment() async {
    await sharedPreferences.remove(cachedPayments);
    return;
  }

  @override
  Future<PaymentsStatisticsModel> getPaymentStatistique() {
    final jsonString = sharedPreferences.getString(cachedPaymentStatistique);
    if (jsonString != null) {
      return Future.value(
          PaymentsStatisticsModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> savePaymentStatistique(PaymentsStatisticsModel params) {
    return sharedPreferences.setString(
      cachedPaymentStatistique,
      json.encode(params.toJson()),
    );
  }

  @override
  Future<void> clearPaymentStatistique() async {
    await sharedPreferences.remove(cachedPaymentStatistique);
    return;
  }
}
