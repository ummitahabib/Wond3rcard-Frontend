import 'package:flutter/material.dart';

class AdminDashboardReusableCard extends StatelessWidget {
  const AdminDashboardReusableCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth < 600 ? 150 : 171.539;

        return Container(
          width: width,
          padding: const EdgeInsets.all(18.152),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 3.63,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
              const SizedBox(height: 13.614),
            ],
          ),
        );
      },
    );
  }
}
