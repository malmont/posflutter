import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? image;
  final String email;
  final List<String> roles; // Ajout du champ roles

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.image,
    this.roles = const [], // Valeur par défaut
  });

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
        roles,
      ];
}
