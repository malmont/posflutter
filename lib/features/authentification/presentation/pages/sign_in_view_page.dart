import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/authentification/application/blocs/auth_bloc.dart';
import 'package:pos_flutter/features/authentification/application/viewmodels/signin_viewmodel.dart';
import 'package:pos_flutter/features/authentification/infrastucture/models/user/sign_in_params.dart';
import 'package:pos_flutter/features/home/presentation/pages/MainViewPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInViewPage extends StatefulWidget {
  const SignInViewPage({super.key});

  @override
  State<SignInViewPage> createState() => _SignInViewPageState();
}

class _SignInViewPageState extends State<SignInViewPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.read<SignInViewModel>(); // Utilisation du ViewModel

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        EasyLoading.dismiss();

        if (state is AuthLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is Authenticated) {
          context.read<SignInViewModel>().resetFields();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainViewPage(),
            ),
          );
        } else if (state is AuthFailure) {
          EasyLoading.showError("Authentication failed. Please try again.");
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF393C49),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              // Ajout du ScrollView
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png', // Votre logo
                              width: 320,
                              height: 280,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Nom de l\'entreprise',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Champ email
                      TextFormField(
                        initialValue: viewModel
                            .email, // Utilisation du ViewModel pour gérer les champs
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEA7C69)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged:
                            viewModel.setEmail, // Mise à jour du ViewModel
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      // Champ mot de passe
                      TextFormField(
                        initialValue:
                            viewModel.password, // Utilisation du ViewModel
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEA7C69)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        obscureText: true,
                        onChanged:
                            viewModel.setPassword, // Mise à jour du ViewModel
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(SignInEvent(
                                SignInParams(
                                    username: viewModel.email,
                                    password: viewModel.password)));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEA7C69),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      if (viewModel.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            viewModel.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
