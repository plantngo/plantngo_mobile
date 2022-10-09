import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class CreateVoucherScreen extends StatefulWidget {
  const CreateVoucherScreen({Key? key}) : super(key: key);
  static const routeName = "/createvoucher";

  @override
  _CreateVoucherScreenState createState() => _CreateVoucherScreenState();
}

class _CreateVoucherScreenState extends State<CreateVoucherScreen> {
  bool _isFlatDiscount = true;
  final TextEditingController _voucherTypeController =
      TextEditingController(text: "F");
  final TextEditingController _voucherValueController = TextEditingController();
  final TextEditingController _voucherDiscountController =
      TextEditingController();
  final TextEditingController _voucherDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double dropdownValue = 0.05;
  List<double> discountValues = [
    0.05,
    0.1,
    0.15,
    0.20,
    0.25,
    0.30,
    0.35,
    0.40,
    0.45,
    0.5
  ];

  @override
  void dispose() {
    super.dispose();
    _voucherDescriptionController.dispose();
    _voucherDiscountController.dispose();
    _voucherTypeController.dispose();
    _voucherValueController.dispose();
  }

  Future createVoucher() async {
    await MerchantService.createVoucher(
        context: context,
        value: double.parse(_voucherValueController.text),
        discount: _isFlatDiscount
            ? double.parse(_voucherDiscountController.text)
            : dropdownValue,
        description: _voucherDescriptionController.text,
        type: _voucherTypeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Voucher"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text("Choose type",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                foregroundColor: _isFlatDiscount
                                    ? Colors.white
                                    : Colors.grey[400],
                                backgroundColor: _isFlatDiscount
                                    ? Colors.green
                                    : Colors.grey[200])
                            .copyWith(
                          elevation: ButtonStyleButton.allOrNull(0.0),
                        ),
                        child: const Text('Flat Discount'),
                        onPressed: () {
                          _voucherTypeController.text = "F";
                          setState(() {
                            _isFlatDiscount = true;
                          });
                        }),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 0,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                foregroundColor: !_isFlatDiscount
                                    ? Colors.white
                                    : Colors.grey[400],
                                backgroundColor: !_isFlatDiscount
                                    ? Colors.green
                                    : Colors.grey[200])
                            .copyWith(
                          elevation: ButtonStyleButton.allOrNull(0.0),
                        ),
                        child: const Text('% Discount'),
                        onPressed: () {
                          setState(() {
                            _voucherTypeController.text = "P";
                            _isFlatDiscount = false;
                          });
                        }),
                  ),
                ]),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 100,
                  child: TextFormField(
                    controller: _voucherValueController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        filled: true,
                        labelText: "Voucher Value in Green Points"),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a voucher value';
                      }
                      return null;
                    }),
                  ),
                ),
                _isFlatDiscount
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 100,
                        child: TextFormField(
                          controller: _voucherDiscountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'))
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                              filled: true, labelText: "Voucher Discount \$"),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a voucher discount value';
                            }
                            return null;
                          }),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 100,
                        child: Column(
                          children: [
                            const Text("Select Discount %"),
                            DropdownButton<double>(
                              value: dropdownValue,
                              items: discountValues
                                  .map<DropdownMenuItem<double>>(
                                      (double value) {
                                return DropdownMenuItem<double>(
                                  value: value,
                                  child: Text('${(value * 100).toInt()}%'),
                                );
                              }).toList(),
                              onChanged: ((double? value) => setState(() {
                                    dropdownValue = value!;
                                  })),
                              isExpanded: true,
                            ),
                          ],
                        ),
                      ),
                TextFormField(
                  controller: _voucherDescriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      filled: true,
                      labelText: "Voucher Discription",
                      hintText: "Enter a description"),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  }),
                ),
              ],
            )),
      ),
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
              child: const Text('Create Voucher'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await createVoucher();
                  AuthService.getUserData(context);
                  Navigator.pop(context);
                }
              }),
        ),
      ),
    );
  }
}
