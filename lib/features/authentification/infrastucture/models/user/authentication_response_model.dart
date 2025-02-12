import 'dart:convert';
import 'user_model.dart';

AuthenticationResponseModel authenticationResponseModelFromJson(String str) =>
    AuthenticationResponseModel.fromJson(json.decode(str));

String authenticationResponseModelToJson(AuthenticationResponseModel data) =>
    json.encode(data.toJson());

class AuthenticationResponseModel {
  final String token;
  final UserModel user;

  const AuthenticationResponseModel({
    required this.token,
    required this.user,
  });

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponseModel(
        token: json["token"],
        user: _decodeUserFromToken(json["token"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };

  static UserModel _decodeUserFromToken(String token) {
    final decodedPayload = _parseJwt(token);

    final firstName = decodedPayload['firstName'] as String? ?? '';
    final lastName = decodedPayload['lastName'] as String? ?? '';
    final email = decodedPayload['email'] as String? ?? '';
    final id = decodedPayload['id']?.toString() ?? '';

    // Récupérer le tableau des rôles depuis le payload
    final rolesList = (decodedPayload['roles'] as List<dynamic>?)
            ?.map((role) => role.toString())
            .toList() ??
        [];

    return UserModel.fromJson({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "id": id,
      "roles": rolesList, // Ajout des rôles dans le JSON
    });
  }

  static Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
