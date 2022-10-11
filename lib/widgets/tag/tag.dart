import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  String text;

  Tag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Text(
            text,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.grey.shade800,
                ),
          ),
        ),
      ),
    );
  }
}
