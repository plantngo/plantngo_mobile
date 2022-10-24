import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  int symbolCount;

  PriceTag({Key? key, required this.symbolCount}) : super(key: key);

  Widget buildSymbol(context) {
    String symbol1 = "";
    for (int i = 0; i < symbolCount; i++) {
      symbol1 += "\$";
    }
    String symbol2 = "";
    for (int i = symbolCount; i < 5; i++) {
      symbol2 += "\$";
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          symbol1,
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.grey.shade800,
              ),
        ),
        Text(
          symbol2,
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.grey.shade300,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: buildSymbol(context),
        ),
      ),
    );
  }
}
