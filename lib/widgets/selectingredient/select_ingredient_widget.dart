import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_choices/search_choices.dart';

class SelectIngredientWidget extends StatefulWidget {
  SelectIngredientWidget({Key? key, required this.ingredients})
      : super(key: key);

  final List<DropdownMenuItem> ingredients;
  String? selectedValueSingleDialog = '';
  TextEditingController ingredientWeightController = TextEditingController();

  @override
  State<SelectIngredientWidget> createState() => _SelectIngredientWidgetState();
}

class _SelectIngredientWidgetState extends State<SelectIngredientWidget> {
  @override
  void dispose() {
    super.dispose();
    widget.ingredientWeightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int number = 0;
    return Row(
      children: [
        SizedBox(
          width: 250,
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
        const Spacer(),
        SizedBox(
          width: 110,
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
        )
      ],
    );
  }
}
