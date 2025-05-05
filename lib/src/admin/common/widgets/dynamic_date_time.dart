import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DynamicDateText extends StatelessWidget {
  const DynamicDateText({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat("d MMMM, y").format(DateTime.now());

    return Text(
      formattedDate,
      style: const TextStyle(color: Color(0xff707070)),
    );
  }
}
