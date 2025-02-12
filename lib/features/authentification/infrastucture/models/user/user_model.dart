import 'package:json_annotation/json_annotation.dart';
import 'package:pos_flutter/features/authentification/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    super.image,
    super.roles, // Ajout du champ roles
  });

  // Méthode générée automatiquement pour créer un UserModel à partir du JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Méthode générée automatiquement pour convertir un UserModel en JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
