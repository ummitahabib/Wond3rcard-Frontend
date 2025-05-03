import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'dart:ui';

import 'package:wond3rcard/src/wonder_card_website/views/widget/section_widget.dart';

final themeNotifier = ValueNotifier(ThemeMode.light);

class IntrocductionSection extends StatelessWidget {
  const IntrocductionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      title: '',
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.purple[50], borderRadius: BorderRadius.circular(8)),
        height: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      softWrap: true,
                      'Digital',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ).animate(delay: (100).ms).fadeIn(duration: 600.ms),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      softWrap: true,
                      'Business Card',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ).animate(delay: (100).ms).fadeIn(duration: 600.ms),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      softWrap: true,
                      'With Wond3rCard',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ).animate(delay: (100).ms).fadeIn(duration: 600.ms),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      softWrap: true,
                      'Create and share your digital business card with ease Say goodbye to outdated business cards and hello to interactive and dynamic digital networking!,',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ).animate(delay: (200).ms).fadeIn(duration: 600.ms),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.primaryShade,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Our Demo',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.defaultWhite,
                              border: Border.all(
                                color: AppColors.primaryShade,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Our Demo',
                            style: TextStyle(
                                color: AppColors.primaryShade, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Image.asset('images/phone-hand-mockup.png'),
            ),
          ],
        ),
      ),
      color: Colors.transparent,
    );
  }
}
