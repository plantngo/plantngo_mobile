import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/screens/merchant/menu/placeholder_item.dart';
import 'package:search_choices/search_choices.dart';

class SelectIngredientWidget extends StatefulWidget {
  SelectIngredientWidget(
      {Key? key,
      required this.ingredients,
      required this.weight,
      required this.selectedValueSingleDialog,
      required this.deleteIngredient})
      : super(key: key);

  final List<DropdownMenuItem> ingredients;
  String? selectedValueSingleDialog;
  double? weight;
  final Function(SelectIngredientWidget) deleteIngredient;
  TextEditingController ingredientWeightController = TextEditingController();

  @override
  State<SelectIngredientWidget> createState() => _SelectIngredientWidgetState();
}

class _SelectIngredientWidgetState extends State<SelectIngredientWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.ingredientWeightController.text =
        widget.weight != null ? widget.weight.toString() : '';
  }

  @override
  Widget build(BuildContext context) {
    int number = 0;
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            child: SearchChoices.single(
              items: widget.ingredients,
              value: widget.selectedValueSingleDialog,
              hint: "Select an Ingredient",
              style: Theme.of(context).textTheme.bodyMedium,
              fieldDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey.shade500,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              searchInputDecoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                labelText: "Ingredient Name",
              ),
              onChanged: (value) {
                setState(() {
                  widget.selectedValueSingleDialog = value;
                });
              },
              isExpanded: true,
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: SizedBox(
              height: 50,
              child: TextFormField(
                controller: widget.ingredientWeightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                  labelText: "Weight (g)",
                ),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a weight';
                  }
                  return null;
                }),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            )),
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {
              widget.deleteIngredient(widget);
            },
            icon: Icon(
              Icons.delete,
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
