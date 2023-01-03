import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:time_range/time_range.dart';

class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({super.key});
  static const routeName = '/user/profile/setting';

  @override
  State<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usertypeController =
      TextEditingController(text: "C");
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cuisineTypeController = TextEditingController();

  final _settingsFormKey = GlobalKey<FormState>();

  bool _isObscure = true;
  bool _isValidPassword = true;
  bool _isChangingPassword = false;
  String username = '';
  final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 8, minute: 00),
    TimeOfDay(hour: 22, minute: 00),
  );
  TimeRangeResult? _timeRange;
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 1;

  @override
  void initState() {
    super.initState();
    var customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    var merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    username = customerProvider.customer.username!;
    _emailController.text = customerProvider.customer.email!;
    _usernameController.text = username;

    if (customerProvider.customer.id == null) {
      username = merchantProvider.merchant.username!;
      _usertypeController.text = "M";
      _usernameController.text = username;
      _emailController.text = merchantProvider.merchant.email!;
      _companyController.text = merchantProvider.merchant.company!;
      _cuisineTypeController.text = merchantProvider.merchant.cuisineType!;
      _descriptionController.text = merchantProvider.merchant.description!;
    }
    _timeRange = _defaultTimeRange;
  }

  @override
  dispose() {
    super.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _usernameController.dispose();
    _usertypeController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    _cuisineTypeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey,
        //         offset: Offset(0, 2.0),
        //         blurRadius: 4.0,
        //       )
        //     ],
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [
        //         Theme.of(context).colorScheme.secondary.shade200,
        //         Theme.of(context).colorScheme.secondary.shade300,
        //         Theme.of(context).colorScheme.secondary,
        //       ],
        //     ),
        //   ),
        // ),
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
                            decoration: InputDecoration(
                              filled: true,
                              labelText: "Username",
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                            decoration: InputDecoration(
                              filled: true,
                              labelText: "Email",
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                            ),
                            validator: ((value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !EmailValidator.validate(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }),
                          ),
                          const SizedBox(height: 20),
                          if (_usertypeController.text == "M") ...[
                            TextFormField(
                              controller: _companyController,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Company",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                              ),
                              validator: ((value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a company name';
                                }
                              }),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _cuisineTypeController,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Cuisine Type",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                              ),
                              validator: ((value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a cuisine type';
                                }
                              }),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _descriptionController,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Description",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                              ),
                              validator: ((value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a description';
                                }
                              }),
                            ),
                            const SizedBox(height: 20),
                            const Text('Operating Hours'),
                            TimeRange(
                              fromTitle: const Text(
                                'FROM',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: dark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              toTitle: const Text(
                                'TO',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: dark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              titlePadding: leftPadding,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: dark,
                              ),
                              activeTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              borderColor: dark,
                              activeBorderColor: dark,
                              backgroundColor: Colors.transparent,
                              activeBackgroundColor: dark,
                              firstTime: const TimeOfDay(hour: 8, minute: 00),
                              lastTime: const TimeOfDay(hour: 22, minute: 00),
                              initialRange: _timeRange,
                              timeStep: 10,
                              timeBlock: 30,
                              onRangeCompleted: (range) =>
                                  setState(() => _timeRange = range),
                            ),
                          ],
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 200,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  foregroundColor: Colors.grey[900]),
                              onPressed: () {
                                if (_usertypeController.text == "C") {
                                  UserService.updateCustomerDetails(
                                    context,
                                    username,
                                    _usernameController.text,
                                    _emailController.text,
                                  );
                                } else if (_usertypeController.text == "M") {
                                  UserService.updateMerchantDetails(
                                      context,
                                      username,
                                      _usernameController.text,
                                      _emailController.text,
                                      _companyController.text,
                                      _cuisineTypeController.text,
                                      _descriptionController.text,
                                      "${_timeRange!.start.hour < 10 ? "0${_timeRange!.start.hour}" : _timeRange!.start.hour}:${_timeRange!.start.minute < 10 ? "0${_timeRange!.start.minute}" : _timeRange!.start.minute} - ${_timeRange!.end.hour < 10 ? "0${_timeRange!.end.hour}" : _timeRange!.end.hour}:${_timeRange!.end.minute < 10 ? "0${_timeRange!.end.minute}" : _timeRange!.end.minute}");
                                }
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Save Details",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
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
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  foregroundColor: Colors.black),
                              onPressed: () {
                                UserService.changePassword(
                                    context,
                                    _newPasswordController.text,
                                    _oldPasswordController.text,
                                    _usernameController.text,
                                    _usertypeController.text);
                                _newPasswordController.text = "";
                                _oldPasswordController.text = "";
                              },
                              child: const Text(
                                "Save Password",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary),
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
