import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';

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
      body: Center(
        heightFactor: 2,
        child: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100]),
                  child: TextFormField(
                      decoration:
                          InputDecoration(filled: true, labelText: "Name")),
                  width: 350,
                  height: 70,
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100]),
                  width: 350,
                  height: 70,
                  child: TextFormField(
                      decoration:
                          InputDecoration(filled: true, labelText: "Email")),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100]),
                  child: TextFormField(
                      decoration:
                          InputDecoration(filled: true, labelText: "Password")),
                  width: 350,
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
