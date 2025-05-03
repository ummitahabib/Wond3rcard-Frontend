import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  CustomDropdown(
      {super.key,
      required this.selectedValue,
      required this.options,
      this.onChanged});

  String selectedValue;
  List<String> options;
  Function(String?)? onChanged;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 46,
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFDBDCDE),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedValue,
          onChanged: widget.onChanged ??
              (newValue) {
                setState(() {
                  widget.selectedValue = newValue!;
                });
              },
          items: widget.options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
