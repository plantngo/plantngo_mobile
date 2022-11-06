import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:plantngo_frontend/services/user_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);
  static const routeName = '/resetpassword';

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isValidPassword = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              TextFormField(
                controller: _tokenController,
                keyboardType: TextInputType.text,
                autofocus: true,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid token';
                  }
                }),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Token',
                  labelText: 'Reset Token',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: (() {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
                  ),
                ),
                validator: (value) {
                  if (!_isValidPassword) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
                obscureText: _isObscure,
              ),
              const SizedBox(height: 10),
              FlutterPwValidator(
                controller: _newPasswordController,
                minLength: 8,
                uppercaseCharCount: 1,
                numericCharCount: 1,
                specialCharCount: 1,
                width: 350,
                height: 150,
                onSuccess: () {
                  setState(() {
                    _isValidPassword = true;
                  });
                },
                onFail: () {
                  setState(() {
                    _isValidPassword = false;
                  });
                },
              ),
              const SizedBox(
                height: 20,
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
                  child: const Text('Reset Password'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserService.resetPasswordWithToken(context, widget.email,
                          _tokenController.text, _newPasswordController.text);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
