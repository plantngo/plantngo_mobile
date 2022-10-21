import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class EditVoucherScreen extends StatefulWidget {
  const EditVoucherScreen({Key? key, required this.voucher}) : super(key: key);

  final Voucher voucher;
  static const routeName = "/editvoucher";

  @override
  _EditVoucherScreenState createState() => _EditVoucherScreenState();
}

class _EditVoucherScreenState extends State<EditVoucherScreen> {
  final TextEditingController _voucherTypeController = TextEditingController();
  final TextEditingController _voucherValueController = TextEditingController();
  final TextEditingController _voucherDiscountController =
      TextEditingController();
  final TextEditingController _voucherDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFlatDiscount = true;

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
  void initState() {
    super.initState();
    _isFlatDiscount = widget.voucher.type == 'F';
    _voucherDescriptionController.text = widget.voucher.description.toString();
    _voucherValueController.text = widget.voucher.value.toString();
    if (_isFlatDiscount) {
      _voucherDiscountController.text = widget.voucher.discount.toString();
    } else {
      dropdownValue = widget.voucher.discount!.toDouble();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _voucherDescriptionController.dispose();
    _voucherDiscountController.dispose();
    _voucherTypeController.dispose();
    _voucherValueController.dispose();
  }

  Future editVoucher() async {
    await MerchantService.editVoucher(
        context: context,
        id: widget.voucher.id!,
        value: double.parse(_voucherValueController.text),
        discount: _isFlatDiscount
            ? double.parse(_voucherDiscountController.text)
            : dropdownValue,
        description: _voucherDescriptionController.text,
        type: widget.voucher.type!);
  }

  Future deleteVoucher() async {
    await MerchantService.deleteVoucher(
        context: context, id: widget.voucher.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit voucher")),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                          decoration: const InputDecoration(
                              filled: true, labelText: "Voucher Discount \$"),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a voucher discount value';
                            }
                            return null;
                          }),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'))
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
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
                  keyboardType: TextInputType.text,
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
                      'Remove Voucher',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () async {
                      await deleteVoucher();
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
                        await editVoucher();
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
