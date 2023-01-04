import 'package:flutter/material.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);
  static const routeName = "/addcategory";

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();

  Future addCategory(String category) async {
    await MerchantService.addCategory(context: context, category: category);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Category",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: _categoryNameController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            filled: true,
            labelText: 'Category Name',
          ),
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
              child: const Text('Add Category'),
              onPressed: () async {
                try {
                  await addCategory(_categoryNameController.text);
                  AuthService.getUserData(context);
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              }),
        ),
      ),
    );
  }
}
