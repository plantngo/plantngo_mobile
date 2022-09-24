import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

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
                  validator: ((value) {
                    if (value == null ||
                        value.isEmpty ||
                        !EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                  }),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Your email address',
                    labelText: 'Email',
                  ),
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
                        signInUser();
                      }
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/forgetpassword");
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
}
