import 'package:flutter/material.dart';
import 'package:wond3rcard/src/wonder_card_website/views/glass_card.dart';
import 'package:wond3rcard/src/wonder_card_website/views/widget/section_widget.dart';

class OurServicesSection extends StatelessWidget {
  const OurServicesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Our Services',
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.asset('images/card-bg.png'),
            ),
            Expanded(
              child: GlassCard2(
                title: 'Elevate your cards',
                description:
                    'Gone are the days of exchanging stale business cards that end up forgotten in a drawer. Experience the power of Wond3rCard, the digital solution designed to revolutionize your networking efforts Create and share your digital business card with ease Say goodbye to outdated business cards and hello to interactive and dynamic digital networking!, Create and share your digital business card with ease Say goodbye to outdated business cards and hello to interactive and dynamic digital networking!Create and share your digital business card with ease Say goodbye to outdated',
              ),
            ),
          ],
        ),
      ),
      color: Colors.transparent,
    );
  }
}
