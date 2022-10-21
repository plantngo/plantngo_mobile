//todo add image service
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:plantngo_frontend/services/promotion_service.dart';

class CreatePromotionScreen extends StatefulWidget {
  const CreatePromotionScreen({Key? key}) : super(key: key);
  static const routeName = "/createpromotion";

  @override
  _CreatePromotionScreenState createState() => _CreatePromotionScreenState();
}

class _CreatePromotionScreenState extends State<CreatePromotionScreen> {
  final TextEditingController _dateController = TextEditingController();
  DateTimeRange? _promotionalPeriod = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 5)));
  final TextEditingController _promotionDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var image = null;
  void selectImage() async {
    var res = await MerchantService.pickImage();
    setState(() {
      image = res;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateController.dispose();
  }

  Future createPromotion() async {
    await PromotionService.createPromotion(
        context: context,
        bannerUrl:
            "http://sg.syioknya.com/custom/picture/2585/syioknya1_60e41d6928724.jpg",
        description: _promotionDescriptionController.text,
        startDate:
            '${_promotionalPeriod!.start.year}-${_promotionalPeriod!.start.month < 10 ? '0${_promotionalPeriod!.start.month}' : _promotionalPeriod!.start.month}-${_promotionalPeriod!.start.day < 10 ? '0${_promotionalPeriod!.start.day}' : _promotionalPeriod!.start.day}',
        endDate:
            '${_promotionalPeriod!.end.year}-${_promotionalPeriod!.end.month < 10 ? '0${_promotionalPeriod!.end.month}' : _promotionalPeriod!.end.month}-${_promotionalPeriod!.end.day < 10 ? '0${_promotionalPeriod!.end.day}' : _promotionalPeriod!.end.day}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Promotion"),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                image != null
                    ? GestureDetector(
                        onTap: selectImage,
                        child: Builder(
                            builder: (BuildContext context) => Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                  height: 200,
                                )))
                    : GestureDetector(
                        onTap: selectImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  children: [
                                    Text(
                                      'Select Promotional Banner Image',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    Text(
                                      'Maximum 2MB. Accepted file types: PNG, JPG',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _promotionDescriptionController,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      filled: true,
                      labelText: "Promotion Description",
                      hintText: "Enter a description"),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Promotional Period"),
                  readOnly: true,
                  onTap: () async {
                    DateTimeRange? pickedDate = await showDateRangePicker(
                      context: context,
                      initialDateRange: _promotionalPeriod,
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 36500)),
                      lastDate: DateTime.now().add(const Duration(days: 36500)),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Colors.green,
                              onPrimary: Colors.black,
                              onSurface: Colors.green,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          '${pickedDate.start.year}-${pickedDate.start.month}-${pickedDate.start.day} - ${pickedDate.end.year}-${pickedDate.end.month}-${pickedDate.end.day}';

                      setState(() {
                        _dateController.text = formattedDate.toString();
                        _promotionalPeriod = pickedDate;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Please create a category for promotional items in menu first before putting up a promotion!",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: SizedBox(
        height: 115,
        child: Container(
          padding: const EdgeInsets.all(35),
          color: const Color.fromARGB(33, 158, 158, 158),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ).copyWith(
                elevation: ButtonStyleButton.allOrNull(0.0),
              ),
              child: const Text('Create Promotion'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await createPromotion();
                  AuthService.getUserData(context);
                  Navigator.pop(context);
                }
              }),
        ),
      ),
    );
  }
}
