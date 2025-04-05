import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
   CustomDropdown({super.key, required this.selectedValue, required this.options,});

    String selectedValue;
    List<String> options;

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
        color: const Color(0xFFEFEFEF), // Background color
        borderRadius: BorderRadius.circular(8), // Border radius
        border: Border.all(
          color: const Color(0xFFDBDCDE), // Border color
          width: 1, // Border width
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedValue,
          onChanged: (newValue) {
            setState(() {
              widget.selectedValue = newValue!;
            });
          },
          items: widget.options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
          style: const TextStyle(color: Colors.black), // Text color
        ),
      ),
    );
  }
}
