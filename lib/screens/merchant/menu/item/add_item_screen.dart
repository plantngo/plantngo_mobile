//todo add image service
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/models/ingredient.dart';
import 'package:plantngo_frontend/providers/merchant_ingredients_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/screens/merchant/menu/placeholder_item.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:plantngo_frontend/services/product_service.dart';
import 'package:plantngo_frontend/widgets/selectingredient/select_ingredient_widget.dart';
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
  final _formKey = GlobalKey<FormState>();
  List<String> categories = [];
  List<DropdownMenuItem> ingredients = [];
  List<SelectIngredientWidget> listSelectIngredientWidgets = [];
  var image = null;

  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
    listSelectIngredientWidgets = [
      SelectIngredientWidget(
          ingredients: ingredients,
          selectedValueSingleDialog: null,
          weight: null,
          deleteIngredient: deleteIngredient)
    ];
    fetchAllIngredients();
    fetchAllCategories();
    dropdownValue = categories.first;
  }

  @override
  void dispose() {
    super.dispose();
    _itemDescriptionController.dispose();
    _itemNameController.dispose();
    _itemPriceController.dispose();
  }

  void deleteIngredient(SelectIngredientWidget ingredient) {
    listSelectIngredientWidgets.remove(ingredient);
    setState(() {});
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

  fetchAllCategories() {
    Provider.of<MerchantProvider>(context, listen: false)
        .merchant
        .categories!
        .map((e) => categories.add(e.name))
        .toList();
  }

  List<Ingredient> selectedListOfIngredients() {
    List<Ingredient> ingredients = [];
    for (var item in listSelectIngredientWidgets) {
      ingredients.add(Ingredient(
          id: null,
          name: item.selectedValueSingleDialog,
          servingQty: item.weight));
    }
    return ingredients;
  }

  Future addItem() async {
    await MerchantService.addProduct(
        context: context,
        name: _itemNameController.text,
        description: _itemDescriptionController.text,
        price: double.parse(_itemPriceController.text),
        category: dropdownValue,
        image: image);
    for (var item in listSelectIngredientWidgets) {
      await ProductService.addIngredient(
          productName: _itemNameController.text,
          ingredientName: item.selectedValueSingleDialog!,
          servingWeight: double.parse(item.ingredientWeightController.text),
          context: context);
    }
  }

  void selectImage() async {
    var res = await MerchantService.pickImage();
    setState(() {
      image = res;
    });
  }

  void addSelectIngredientWidget() {
    listSelectIngredientWidgets.add(SelectIngredientWidget(
      ingredients: ingredients,
      selectedValueSingleDialog: null,
      weight: null,
      deleteIngredient: deleteIngredient,
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Item",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // enter ingredient details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Details",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: Builder(
                              builder: (BuildContext context) => Image.file(
                                image,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: selectImage,
                            child: DottedBorder(
                              color: Colors.grey.shade400,
                              borderType: BorderType.RRect,
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
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                      color: Colors.grey.shade500,
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      children: [
                                        Text(
                                          'Select Product Image',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        Text(
                                          'Maximum 2MB. Accepted file types: PNG, JPG',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade500,
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
                      height: 10,
                    ),
                    TextFormField(
                      controller: _itemNameController,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.all(Radius.zero),
                        ),
                        labelText: "Item Name",
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        hintText: "e.g Vegetarian Pizza",
                      ),
                      textAlignVertical: TextAlignVertical.top,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an Item Name';
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _itemDescriptionController,
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                        ),
                        labelText: "Item Description",
                        hintText:
                            "e.g Vegetarian Pizza made of freshly made dough that ...",
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _itemPriceController,
                      textAlignVertical: TextAlignVertical.top,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                        ),
                        labelText: "Item Price (\$SGD)",
                        hintText: "e.g 10.30",
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        return null;
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.shade200,
                thickness: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Ingredient(s)",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listSelectIngredientWidgets.length,
                      itemBuilder: (_, index) =>
                          listSelectIngredientWidgets[index],
                    ),
                    PlaceholderItem(
                        text: "Add more Ingredients",
                        height: 50,
                        widthPercent: 1,
                        onTap: addSelectIngredientWidget),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.shade200,
                thickness: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Category",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
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
                        onChanged: ((String? value) => setState(
                              () {
                                dropdownValue = value!;
                              },
                            )),
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 10,
          ),
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
