import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({
    super.key, required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16,top: 16,right: 16,bottom: 4),
            child:  Text(text,style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),));
  }
}

