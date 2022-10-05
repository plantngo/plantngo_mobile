import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);
  static const routeName = "/additem";

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemEmissionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> categories = [];
  var image = null;

  String dropdownValue = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MerchantProvider>(context, listen: false)
        .merchant
        .categories
        .map((e) => categories.add(e.name))
        .toList();
    dropdownValue = categories.first;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _itemDescriptionController.dispose();
    _itemEmissionController.dispose();
    _itemNameController.dispose();
    _itemPriceController.dispose();
  }

  Future addItem() async {
    await MerchantService.addProduct(
        context: context,
        name: _itemNameController.text,
        description: _itemDescriptionController.text,
        price: double.parse(_itemPriceController.text),
        emission: double.parse(_itemEmissionController.text),
        category: dropdownValue);
  }

  void selectImage() async {
    var res = await MerchantService.pickImage();
    setState(() {
      image = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Item"),
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
                                        'Select Product Image',
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
                    controller: _itemNameController,
                    decoration: const InputDecoration(
                        filled: true,
                        labelText: "Item Name",
                        hintText: "Enter a item name"),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a item name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _itemDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        filled: true,
                        labelText: "Item Description",
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
                  TextFormField(
                    controller: _itemPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        filled: true,
                        labelText: "Price",
                        hintText: "Enter a price"),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    }),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _itemEmissionController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        filled: true,
                        labelText: "Carbon Emission Score",
                        hintText: "Enter a score"),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a score';
                      }
                      return null;
                    }),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Select Category",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 60,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      items: categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: ((String? value) => setState(() {
                            dropdownValue = value!;
                          })),
                      isExpanded: true,
                    ),
                  )
                ],
              ))),
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
              child: const Text('Add Item'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await addItem();
                  AuthService.getUserData(context);
                  Navigator.pop(context);
                }
              }),
        ),
      ),
    );
  }
}