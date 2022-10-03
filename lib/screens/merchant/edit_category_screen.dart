import 'package:flutter/material.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen({Key? key, required this.categoryName});

  static const routeName = "/editcategory";
  String categoryName;

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  @override
  void initState() {
    _categoryNameController.text = widget.categoryName;
    super.initState();
  }

  Future saveChanges() async {
    await MerchantService.editCategory(
        oldCategoryName: widget.categoryName,
        newCategoryName: _categoryNameController.text,
        context: context);
  }

  Future deleteCategory() async {
    await MerchantService.deleteCategory(
        context: context, category: widget.categoryName);
  }

  final TextEditingController _categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Category"),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _categoryNameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Category Name',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Colors.red,
                  ).copyWith(
                    elevation: ButtonStyleButton.allOrNull(0.0),
                  ),
                  onPressed: () async {
                    try {
                      await deleteCategory();
                      AuthService.getUserData(context);
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text("Delete Category")),
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
              child: const Text('Save Changes'),
              onPressed: () async {
                await saveChanges();

                AuthService.getUserData(context);
                Navigator.pop(context);
              }),
        ),
      ),
    );
  }
}
