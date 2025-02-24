import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class FontCustomizationCard extends StatefulWidget {
  const FontCustomizationCard({super.key});

  static const routeName = RouteString.font;

  @override
  _FontCustomizationCardState createState() => _FontCustomizationCardState();
}

class _FontCustomizationCardState extends State<FontCustomizationCard> {
  // List of available fonts
  final List<String> availableFonts = [
    'Roboto',
    'Lato',
    'Poppins',
    'Montserrat',
    'Oswald',
    'Raleway',
    'Pacifico',
    'Bebas Neue',
    'Playfair Display',
  ];

  // State variables
  String selectedFont = 'Roboto'; // Default font
  double fontSize = 24.0; // Default font size

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load preferences on app start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Font Customization Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Card Preview
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Your Card",
                style: GoogleFonts.getFont(
                  selectedFont,
                  textStyle: TextStyle(fontSize: fontSize, color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Font Selection Title
          const Text(
            "Select a Font:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Font Selection List
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableFonts.length,
              itemBuilder: (context, index) {
                final fontName = availableFonts[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFont = fontName; // Update selected font
                      _savePreferences(); // Save preference
                    });
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selectedFont == fontName
                          ? Colors.blue.shade200
                          : Colors.white,
                      border: Border.all(
                        color: selectedFont == fontName
                            ? Colors.blue
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      fontName,
                      style: GoogleFonts.getFont(
                        fontName,
                        textStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          // Font Size Slider Title
          const Text(
            "Adjust Font Size:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Font Size Slider
          Slider(
            value: fontSize,
            min: 12,
            max: 36,
            divisions: 24,
            label: fontSize.round().toString(),
            onChanged: (value) {
              setState(() {
                fontSize = value; // Update font size
                _savePreferences(); // Save preference
              });
            },
          ),
        ],
      ),
    );
  }

  // Load preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedFont = prefs.getString('selectedFont') ?? 'Roboto';
      fontSize = prefs.getDouble('fontSize') ?? 24.0;
    });
  }

  // Save preferences to SharedPreferences
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedFont', selectedFont);
    prefs.setDouble('fontSize', fontSize);
  }

  ElevatedButton resetButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFont = 'Roboto';
          fontSize = 24.0;
          _savePreferences();
        });
      },
      child: const Text("Reset to Default"),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: FontCustomizationCard(),
  ));
}
