import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  final http.Client? httpClient;
  const SignUpScreen({this.httpClient, super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

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
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Form(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100]),
                      width: 350,
                      height: 70,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            filled: true, labelText: "Name"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100]),
                      width: 350,
                      height: 70,
                      child: TextFormField(
                          decoration: const InputDecoration(
                              filled: true, labelText: "Email")),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100]),
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
                      ),
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
