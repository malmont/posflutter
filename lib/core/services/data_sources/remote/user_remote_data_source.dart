import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/exeptions.dart';
import 'package:pos_flutter/core/services/data_sources/local/user_local_data_source.dart';
import 'package:pos_flutter/features/authentification/infrastucture/models/user/authentication_response_model.dart';
import 'package:pos_flutter/features/authentification/infrastucture/models/user/sign_in_params.dart';
import 'package:retrofit/dio.dart';
import '../../api/user_api_client.dart';

abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  Future<bool> isTokenValid();
  Future<bool> refreshToken();
  Future<bool> signOut();
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final UserApiClient apiClient;
  final UserLocalDataSource userLocalDataSource;

  UserRemoteDataSourceImpl(
      {required this.apiClient, required this.userLocalDataSource});

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    try {
      if (kIsWeb) {
        params = params.copyWith(platform: 'web');
      } else {
        params = params.copyWith(platform: 'pos');
      }
      final response = await apiClient.signIn(params);
      return response;
    } catch (e) {
      if (e is DioException) {
        print('Erreur lors de l\'authentification: ${e.response?.statusCode}');
      }
      throw ServerException();
    }
  }

  @override
  Future<bool> isTokenValid() async {
    try {
      final HttpResponse response = await apiClient.validateToken();
      if (response.response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erreur lors de la vérification du token: $e');
      throw ServerException();
    }
  }

  @override
  Future<bool> refreshToken() async {
    try {
      final HttpResponse response = await apiClient.refreshToken();
      if (response.response.statusCode == 200) {
        return true;
      } else {
        print(
            'Erreur: Code de statut non 200 - ${response.response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors du rafraîchissement du token: $e');
      throw ServerException();
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final HttpResponse response = await apiClient.signOut();
      if (response.response.statusCode == 200) {
        return true;
      } else {
        print(
            'Erreur: Code de statut non 200 - ${response.response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors du rafraîchissement du token: $e');
      throw ServerException();
    }
  }
}
