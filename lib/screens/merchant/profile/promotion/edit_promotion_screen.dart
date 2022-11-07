//todo add image service

import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/models/promotion.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:plantngo_frontend/services/promotion_service.dart';

class EditPromotionScreen extends StatefulWidget {
  const EditPromotionScreen({Key? key, required this.promotion})
      : super(key: key);

  final Promotion promotion;
  static const routeName = "/editpromotion";

  @override
  _EditPromotionScreenState createState() => _EditPromotionScreenState();
}

class _EditPromotionScreenState extends State<EditPromotionScreen> {
  final TextEditingController _dateController = TextEditingController();
  DateTimeRange? _promotionalPeriod;
  final TextEditingController _promotionDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var fileImage = null;
  var image = null;

//for promotion image
  void selectImage() async {
    File? res = await MerchantService.pickImage();
    Image img = await convertFileToImage(res!);
    setState(() {
      image = img;
      fileImage = res;
    });
  }

  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }

  @override
  void initState() {
    super.initState();
    _promotionDescriptionController.text =
        widget.promotion.description.toString();

    _promotionalPeriod = DateTimeRange(
        start: DateTime.parse(widget.promotion.startDate!),
        end: DateTime.parse(widget.promotion.endDate!));
    _dateController.text =
        '${widget.promotion.startDate!} - ${widget.promotion.endDate}';
    if (widget.promotion.bannerUrl != null &&
        widget.promotion.bannerUrl != '') {
      image = Image.network(widget.promotion.bannerUrl!);
    }
  }

  @override
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateController.dispose();
  }

  Future deletePromotion() async {
    await PromotionService.deletePromotion(
        context: context, promotionId: widget.promotion.id!);
  }

  Future editPromotion() async {
    await PromotionService.editPromotion(
        context: context,
        promotionId: widget.promotion.id!,
        image: fileImage,
        description: _promotionDescriptionController.text,
        startDate:
            '${_promotionalPeriod!.start.year}-${_promotionalPeriod!.start.month < 10 ? '0${_promotionalPeriod!.start.month}' : _promotionalPeriod!.start.month}-${_promotionalPeriod!.start.day < 10 ? '0${_promotionalPeriod!.start.day}' : _promotionalPeriod!.start.day}',
        endDate:
            '${_promotionalPeriod!.end.year}-${_promotionalPeriod!.end.month < 10 ? '0${_promotionalPeriod!.end.month}' : _promotionalPeriod!.end.month}-${_promotionalPeriod!.end.day < 10 ? '0${_promotionalPeriod!.end.day}' : _promotionalPeriod!.end.day}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit promotion")),
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
                            builder: (BuildContext context) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: image,
                                  ),
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
              ],
            ),
          )),
      bottomNavigationBar: SizedBox(
        height: 175,
        child: Container(
          padding: const EdgeInsets.all(35),
          color: const Color.fromARGB(33, 158, 158, 158),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Colors.white30,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    child: const Text(
                      'Delete Promotion',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () async {
                      await deletePromotion();
                      AuthService.getUserData(context);
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    child: const Text('Save Changes'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await editPromotion();
                        AuthService.getUserData(context);
                        Navigator.pop(context);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
