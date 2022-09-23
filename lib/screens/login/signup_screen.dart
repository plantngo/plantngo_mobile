import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  final http.Client? httpClient;
  const SignUpScreen({this.httpClient, super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService authService = AuthService();
  final _signUpFormKey = GlobalKey<FormState>();

  bool _isObscure = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        name: _nameController.text,
        username: _emailController.text,
        password: _passwordController.text,
        accType: "USER");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 150),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Form(
              key: _signUpFormKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 350,
                      height: 100,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            filled: true, labelText: "Name"),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                        }),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 350,
                      height: 100,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            filled: true, labelText: "Email"),
                        validator: ((value) {
                          if (value == null ||
                              value.isEmpty ||
                              !EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                        }),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 350,
                      height: 70,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: (() {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                          ),
                        ),
                        obscureText: _isObscure,
                        // validator: ((value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter a valid password';
                        //   } else if (value.length < 8) {
                        //     return 'The password must have a minimum of 8 characters';
                        //   }
                        // }),
                      ),
                    ),
                    FlutterPwValidator(
                        controller: _passwordController,
                        minLength: 8,
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        specialCharCount: 1,
                        width: 350,
                        height: 150,
                        onSuccess: () {}),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ).copyWith(
                            elevation: ButtonStyleButton.allOrNull(0.0),
                          ),
                          child: const Text('Sign Up'),
                          onPressed: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
