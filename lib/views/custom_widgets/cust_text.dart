import 'package:flutter/material.dart';

import '../../ihelper/local_vars.dart';

class CustText extends StatefulWidget {
  const CustText({super.key, required this.txtController, required this.txtHint, this.maxLine = 1});

  final TextEditingController txtController;
  final String txtHint;
  final int maxLine;

  @override
  State<CustText> createState() => _CustTextState();
}

class _CustTextState extends State<CustText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: widget.txtController,

        maxLines: widget.maxLine,
        decoration: InputDecoration(
          hintText: widget.txtHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: lVarMainColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }
}
