import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FontCustomizationCard extends StatefulHookConsumerWidget {
  const FontCustomizationCard({super.key});

  static const routeName = RouteString.font;

  @override
  _FontCustomizationCardState createState() => _FontCustomizationCardState();
}

class _FontCustomizationCardState extends ConsumerState<FontCustomizationCard> {
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

  late String selectedFont;
  late double fontSize;

  @override
  void initState() {
    super.initState();
    selectedFont = 'Roboto';
    fontSize = 24.0;
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final selectedFontState = useState(selectedFont);
    final fontSizeState = useState(fontSize);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  selectedFontState.value,
                  textStyle: TextStyle(
                      fontSize: fontSizeState.value, color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Select a Font:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: availableFonts.length,
            itemBuilder: (context, index) {
              final fontName = availableFonts[index];
              return GestureDetector(
                onTap: () {
                  selectedFontState.value = fontName;
                  _savePreferences(
                      selectedFontState.value, fontSizeState.value);
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: selectedFontState.value == fontName
                        ? Colors.blue.shade200
                        : Colors.white,
                    border: Border.all(
                      color: selectedFontState.value == fontName
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
          const SizedBox(height: 10),
          const Text(
            "Adjust Font Size:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Slider(
            value: fontSizeState.value,
            min: 12,
            max: 36,
            divisions: 24,
            label: fontSizeState.value.round().toString(),
            onChanged: (value) {
              fontSizeState.value = value;
              _savePreferences(selectedFontState.value, fontSizeState.value);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedFont = prefs.getString('selectedFont') ?? 'Roboto';
      fontSize = prefs.getDouble('fontSize') ?? 24.0;
    });
  }

  Future<void> _savePreferences(String font, double size) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedFont', font);
    prefs.setDouble('fontSize', size);
  }

  ElevatedButton resetButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFont = 'Roboto';
          fontSize = 24.0;
          _savePreferences(selectedFont, fontSize);
        });
      },
      child: const Text("Reset to Default"),
    );
  }
}
