import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/models/ingredient.dart';
import 'package:plantngo_frontend/providers/merchant_ingredients_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:plantngo_frontend/widgets/selectingredient/select_ingredient_widget.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  EditItemScreen(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.carbonEmission,
      required this.category});

  String name;
  String description;
  double price;
  double carbonEmission;
  String category;

  static const routeName = "/edititem";

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemEmissionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> categories = [];
  List<DropdownMenuItem> ingredients = [];
  List<SelectIngredientWidget> listSelectIngredientWidgets = [];
  //todo
  var image = null;

  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
    _itemNameController.text = widget.name;
    _itemDescriptionController.text = widget.description;
    _itemPriceController.text = widget.price.toString();
    _itemEmissionController.text = widget.carbonEmission.toString();
    dropdownValue = widget.category;
    //todo:need to change this to item clicked
    listSelectIngredientWidgets = [
      SelectIngredientWidget(
        ingredients: ingredients,
        selectedValueSingleDialog: 'beef',
        weight: 30,
      ),
    ];
    fetchAllIngredients();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MerchantProvider>(context, listen: false)
        .merchant
        .categories!
        .map((e) => categories.add(e.name))
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
    _itemDescriptionController.dispose();
    _itemEmissionController.dispose();
    _itemNameController.dispose();
    _itemPriceController.dispose();
  }

  Future saveChanges() async {
    await MerchantService.editProduct(
        context: context,
        newName: _itemNameController.text,
        oldName: widget.name,
        description: _itemDescriptionController.text,
        price: double.parse(_itemPriceController.text),
        emission: double.parse(_itemEmissionController.text),
        category: dropdownValue);
  }

  Future deleteItem() async {
    await MerchantService.deleteProduct(
        context: context, name: widget.name, category: widget.category);
  }

  void selectImage() async {
    var res = await MerchantService.pickImage();
    setState(() {
      image = res;
    });
  }

  fetchAllIngredients() {
    List<Ingredient> ingredients =
        Provider.of<MerchantIngredientsProvider>(context, listen: false)
            .ingredient;
    for (var item in ingredients) {
      this.ingredients.add(DropdownMenuItem(
          value: item.name, child: Text(item.name.toString())));
    }
  }

  void addSelectIngredientWidget() {
    listSelectIngredientWidgets.add(SelectIngredientWidget(
      ingredients: ingredients,
      selectedValueSingleDialog: null,
      weight: null,
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Item"),
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
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _itemEmissionController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Select Ingredients",
                    style: TextStyle(fontSize: 18),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listSelectIngredientWidgets.length,
                      itemBuilder: (_, index) =>
                          listSelectIngredientWidgets[index]),
                  ElevatedButton(
                      onPressed: () => {addSelectIngredientWidget()},
                      child: const Text("+ Add Ingredient")),
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
                      'Delete Item',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await deleteItem();
                        AuthService.getUserData(context);
                        Navigator.pop(context);
                      }
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
                        await saveChanges();
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
