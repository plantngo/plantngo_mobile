import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantngo_frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../models/login_form.dart';
import '../../validators/email_validator.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  final http.Client? httpClient;

  const LoginScreen({
    this.httpClient,
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // LoginForm loginForm = LoginForm();
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  // LogInService logInService = LogInService();

  final _formKey = GlobalKey<FormState>();

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Log In",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...[
                const SizedBox(
                  height: 150,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: ((value) => validateEmail(value)),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Your email address',
                    labelText: 'Email',
                  ),
                  // onChanged: (value) {
                  //   loginForm.email = value;
                  // },
                ),
                TextFormField(
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
                      )),
                  obscureText: _isObscure,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  }),
                  // onChanged: (value) {
                  //   loginForm.password = value;
                  // },
                ),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    child: const Text('Log In'),
                    onPressed: () {
                      // change the login to true
                      if (_formKey.currentState!.validate()) {
                        // await context.read<AuthProvider>().login(loginForm);
                        signInUser();
                      }

                      // if (context.read<AuthProvider>().isLoggedIn) {
                      //   Navigator.of(context).pop();
                      // } else {
                      //   print("wrong credentials");
                      // }

                      // pop the current screen off
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/forget");
                    },
                    child: const Text("Forget Password?"))
              ].expand(
                (widget) => [
                  widget,
                  const SizedBox(
                    height: 24,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(String message) {
    // print(context.owner);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
