import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pos_flutter/core/config/dio_config.dart';
import 'package:pos_flutter/core/config/environment_config.dart';
import 'package:pos_flutter/core/services/api/caisse_api_client.dart';
import 'package:pos_flutter/core/services/api/order_api_client.dart';
import 'package:pos_flutter/core/services/api/payment_api_client.dart';
import 'package:pos_flutter/core/services/api/product_api_client.dart';
import 'package:pos_flutter/core/services/api/statistique_order_api_client.dart';
import 'package:pos_flutter/core/services/api/user_api_client.dart';
import 'package:pos_flutter/core/services/data_sources/local/user_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

@module
abstract class RegisterModule {
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  Dio dio(
      UserLocalDataSource userLocalDataSource, EnvironmentConfig envConfig) {
    return DioConfig(userLocalDataSource, envConfig).createDio();
  }

  @lazySingleton
  UserApiClient userApiClient(Dio dio) => UserApiClient(dio);

  @lazySingleton
  ProductApiClient productApiClient(Dio dio) => ProductApiClient(dio);

  @lazySingleton
  OrderApiClient orderApiClient(Dio dio) => OrderApiClient(dio);

  @lazySingleton
  CaisseApiClient caisseApiClient(Dio dio) => CaisseApiClient(dio);

  @lazySingleton
  PaymentApiClient paymentApiClient(Dio dio) => PaymentApiClient(dio);

  @lazySingleton
  StatistiqueOrderApiClient statistiqueOrderApiClient(Dio dio) =>
      StatistiqueOrderApiClient(dio);
}
