import 'package:flutter/material.dart';

class CarbonTag extends StatelessWidget {
  String text;

  CarbonTag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Text(
            text,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
