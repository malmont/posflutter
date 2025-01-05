import 'package:dio/dio.dart';
import 'package:pos_flutter/core/config/environment_config.dart';
import 'package:pos_flutter/core/services/data_sources/local/user_local_data_source.dart';
import 'bearer_token_interceptor.dart';

class DioConfig {
  final UserLocalDataSource userLocalDataSource;
  final EnvironmentConfig envConfig;
  DioConfig(this.userLocalDataSource, this.envConfig);

  Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: envConfig.backendRestUri,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
        extra: {
          'withCredentials': true,
        },
      ),
    );

    dio.interceptors.add(BearerTokenInterceptor(userLocalDataSource));

    dio.interceptors.add(LogInterceptor(
        // requestBody: true,
        // responseBody: true,
        // requestHeader: true,
        // responseHeader: true,
        ));

    return dio;
  }
}
