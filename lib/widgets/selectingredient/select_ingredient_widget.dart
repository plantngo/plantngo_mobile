import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              hint: "Select one",
              searchHint: "Select one",
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
                decoration: const InputDecoration(
                  filled: true,
                  labelText: "Weight(g)",
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
                icon: const Icon(Icons.delete))),
      ],
    );
  }
}
