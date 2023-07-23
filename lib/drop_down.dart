// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'card_list.dart';
import 'add_expenses.dart';


class DropDown extends StatefulWidget {
  const DropDown({
    required this.data,
    required this.hint,
    required this.textEditingController,
    Key? key,
  }) : super(key: key);
  final List<String> data;
  final String hint;
  final TextEditingController textEditingController;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? _chosenValue1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(0.0),
        child: DropdownButton<String>(
          iconSize: 30,
          isExpanded: true,
          value: _chosenValue1,

          //elevation: 5,
          items: widget.data.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                  value,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Color.fromRGBO(5, 185, 245,1)
                ),
              ),
            );
          }).toList(),
          hint: Text(
            widget.hint,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: 'Ubuntu',
              letterSpacing: 1,
            ),
          ),
          onChanged: (String? value) {
            setState(() {
              _chosenValue1 = value;
              widget.textEditingController.text = value ?? '';
            });
          },
        ),
      ),
    );
  }
}
