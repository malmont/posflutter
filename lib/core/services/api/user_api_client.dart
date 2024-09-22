import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:pos_flutter/features/authentification/infrastucture/models/user/sign_in_params.dart';
import 'package:pos_flutter/features/authentification/infrastucture/models/user/authentication_response_model.dart';

part 'user_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String? baseUrl}) = _UserApiClient;

  @POST('/login')
  Future<AuthenticationResponseModel> signIn(@Body() SignInParams params);

  @POST('/login-web')
  Future<AuthenticationResponseModel> signInWeb(@Body() SignInParams params);

  @POST('/token/refresh')
  Future<HttpResponse> refreshToken();

  @GET('/validate-token')
  Future<HttpResponse> validateToken();

  @POST('/logout')
  Future<HttpResponse> signOut();
}
