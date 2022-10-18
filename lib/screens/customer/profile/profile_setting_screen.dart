import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/user_secure_storage.dart';

class CustomerSettingScreen extends StatefulWidget {
  const CustomerSettingScreen({super.key});
  static const routeName = '/user/profile/setting';

  @override
  State<CustomerSettingScreen> createState() => _CustomerSettingScreenState();
}

class _CustomerSettingScreenState extends State<CustomerSettingScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usertypeController =
      TextEditingController(text: "C");
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  final _settingsFormKey = GlobalKey<FormState>();

  bool _isObscure = true;
  bool _isValidPassword = true;
  bool _isChangingPassword = false;

  @override
  dispose() {
    super.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _usernameController.dispose();
    _usertypeController.dispose();
    _companyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    var merchantProvider = Provider.of<MerchantProvider>(context, listen: true);
    _emailController.text = customerProvider.customer.email!;
    _usernameController.text = customerProvider.customer.username!;

    if (customerProvider.customer.id == null) {
      _usertypeController.text = "M";
      _usernameController.text = merchantProvider.merchant.username!;
    }
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              Form(
                key: _settingsFormKey,
                child: Column(
                  children: [
                    if (!_isChangingPassword)
                      Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              filled: true,
                              labelText: "Username",
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.greenAccent),
                              ),
                            ),
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            }),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              filled: true,
                              labelText: "Email",
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.greenAccent)),
                            ),
                            validator: ((value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !EmailValidator.validate(value)) {
                                return 'Please enter a valid email';
                              }
                            }),
                          ),
                          const SizedBox(height: 20),
                          if (_companyController.text == "M")
                            TextFormField(
                              controller: _companyController,
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "Comapany",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.greenAccent)),
                              ),
                              validator: ((value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !EmailValidator.validate(value)) {
                                  return 'Please enter a valid email';
                                }
                              }),
                            ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 200,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                  foregroundColor: Colors.grey[900]),
                              onPressed: () {},
                              child: const Text("Save Details"),
                            ),
                          ),
                        ],
                      ),
                    if (_isChangingPassword)
                      Column(
                        children: [
                          TextFormField(
                            controller: _oldPasswordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.greenAccent),
                              ),
                              labelText: 'Enter your Current Password',
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
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _newPasswordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.greenAccent),
                              ),
                              labelText: 'Enter your New Password',
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
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 200,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                  foregroundColor: Colors.black),
                              onPressed: () {
                                customerProvider.changePassword(
                                    context,
                                    _newPasswordController.text,
                                    _oldPasswordController.text,
                                    _usernameController.text,
                                    _usertypeController.text);
                                _newPasswordController.text = "";
                                _oldPasswordController.text = "";
                              },

                              child: const Text("Save Password"),
                            ),
                          ),
                        ],
                      ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.blue[800]),
                      onPressed: () {
                        setState(() {
                          _isChangingPassword = !_isChangingPassword;
                        });
                      },
                      child: _isChangingPassword
                          ? const Text("Change Details")
                          : const Text("Change Password"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
