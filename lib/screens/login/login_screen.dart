import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantngo_frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../models/form_data.dart';

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
  FormData formData = FormData();
  bool _isObscure = true;

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...[
                const SizedBox(
                  height: 150,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Your email address',
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    formData.email = value;
                  },
                ),
                TextFormField(
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
                  onChanged: (value) {
                    formData.password = value;
                  },
                ),
                SizedBox(
                  width: 300,
                  height: 60,
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
                    onPressed: () async {
                      // change the login to true
                      context.read<AuthProvider>().fakeLogin();
                      // pop the current screen off
                      Navigator.of(context).pop();

                      // Use a JSON encoded string to send
                      var result = await widget.httpClient!.post(
                          Uri.parse('https://example.com/signin'),
                          body: json.encode(formData.toJson()),
                          headers: {'content-type': 'application/json'});
                      if (result.statusCode == 200) {
                        _showDialog('Successfully signed in.');
                      } else if (result.statusCode == 401) {
                        _showDialog('Unable to sign in.');
                      } else {
                        _showDialog('Something went wrong. Please try again.');
                      }
                    },
                  ),
                ),
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
