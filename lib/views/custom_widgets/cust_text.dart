import 'dart:math';

import 'package:flutter/material.dart';

import '../../ihelper/local_vars.dart';

class CustText extends StatelessWidget {
  const CustText({super.key, required this.txtController, required this.txtHint, this.maxLine = 1});

  final TextEditingController txtController;
  final String txtHint;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: txtController,
        maxLines: maxLine,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (inputVal){
          if (inputVal?.isEmpty ?? true) {
            return 'Please enter some text';
          }
          print(inputVal.toString());
          return null;
        },

        // → Input border decoration
        decoration: InputDecoration(
          hintText: txtHint,
          //errorText: 'Please insert value',
          border: _borderStates(Colors.white),
          focusedBorder: _borderStates(Colors.greenAccent),
          errorBorder: _borderStates(Colors.redAccent),
        ),
      ),
    );
  }

  OutlineInputBorder _borderStates(Color borderColor){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
