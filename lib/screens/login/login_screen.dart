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
  bool _isUser = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usertypeController =
      TextEditingController(text: "C");

  @override
  dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void signInUser() {
    AuthService.signInUser(
        context: context,
        username: _usernameController.text,
        password: _passwordController.text,
        userType: _usertypeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Log In",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...[
                SizedBox(height: 30),
                const Text("I am a...",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    _isUser ? Colors.white : Colors.grey[400],
                                backgroundColor:
                                    _isUser ? Colors.green : Colors.grey[200])
                            .copyWith(
                          elevation: ButtonStyleButton.allOrNull(0.0),
                        ),
                        child: const Text('Customer'),
                        onPressed: () {
                          _usertypeController.text = "C";
                          setState(() {
                            _isUser = true;
                          });
                        }),
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    !_isUser ? Colors.white : Colors.grey[400],
                                backgroundColor:
                                    !_isUser ? Colors.green : Colors.grey[200])
                            .copyWith(
                          elevation: ButtonStyleButton.allOrNull(0.0),
                        ),
                        child: const Text('Merchant'),
                        onPressed: () {
                          setState(() {
                            _usertypeController.text = "M";
                            _isUser = false;
                          });
                        }),
                  ),
                  const Spacer(flex: 1),
                ]),
                TextFormField(
                  controller: _usernameController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Your username',
                    labelText: 'Username',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
