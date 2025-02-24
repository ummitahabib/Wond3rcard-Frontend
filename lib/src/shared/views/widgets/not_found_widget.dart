import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/util.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          notFoundText,
          style: TextStyle(fontSize: SpacingConstants.size28),
        ),
      ),
    );
  }
}
