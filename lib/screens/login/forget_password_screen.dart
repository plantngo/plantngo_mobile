import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/forget';

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var _email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Form(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                setState(() {
                  _email = value;
                });
              },
            ),
            
          ],
        ),
      )),
    );
  }
}
