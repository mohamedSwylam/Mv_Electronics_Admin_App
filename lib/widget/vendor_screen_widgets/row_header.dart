import 'package:flutter/material.dart';

Widget rowHeader({int? flex, String? text}) {
  return Expanded(
      flex: flex!,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            color: Colors.grey.shade500),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text!,style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ));
} // Container, Expanded
