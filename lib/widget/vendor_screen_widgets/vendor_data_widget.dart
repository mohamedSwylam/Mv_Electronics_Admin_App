import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VendorDataWidget extends StatelessWidget {
  final int? flex;
  final String? text ;
  final Widget? widget;
   VendorDataWidget({required this.flex,this.text,this.widget});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex!,
        child: Container(
          height: 66,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget ?? Text(text!),
          ),
        ),
    );
  }
}
