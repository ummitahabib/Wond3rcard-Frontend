import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/utils/util.dart';

class NoContactsScreen extends StatelessWidget {
  const NoContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 20),
              Text(
                "No Contacts Yet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 22 : 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Click the button below to find and add your first contact.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 14 : 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  context.go(RouteString.addContact);
                },
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text(
                  "Find People to Add to your Contact",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.deepPurple,
                  textStyle: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
