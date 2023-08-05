import 'package:expense_tracker/widgets/text_field.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final List<String> data;
  final String hint;
  final TextEditingController textEditingController;

  const DropDown({
    required this.data,
    required this.hint,
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *0.8,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(21),
        border: const Border(
          top: BorderSide(color: Colors.black38),
          bottom: BorderSide(color: Colors.black38),
          left: BorderSide(color: Colors.black38),
          right: BorderSide(color: Colors.black38),
        )
      ),
      child: DropdownButton<String>(
        padding: const EdgeInsets.fromLTRB(10, 0,10, 0),
        value: selectedValue,
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue!;
            widget.textEditingController.text =
                newValue; // Set the selected value to the text field
          });
        },
        items: widget.data.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Color.fromRGBO(47, 37, 245, 1)
              ),),
          );
        }).toList(),
        hint: Text(
          widget.hint,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            fontFamily: 'Ubuntu',
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
