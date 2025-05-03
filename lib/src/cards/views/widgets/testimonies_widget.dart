import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/utils/assets.dart';

// will rework on this when testimonies endpoint is ready
class MyTestimonies {
  final String jobTitle;
  final String userName;
  final String testimonies;

  MyTestimonies({
    required this.jobTitle,
    required this.userName,
    required this.testimonies,
  });
}

final List<MyTestimonies> dumMyTestimonies = [
  MyTestimonies(
    jobTitle: 'CEO, Learnoch',
    userName: 'Muhammad Ali 1',
    testimonies:
        'I needed a unique design for my business website and found Learnoch The team was professional, creative, and delivered a stunning, user-friendly site that perfectly captured my brand. ',
  ),
  MyTestimonies(
    jobTitle: 'CEO, Learnoch',
    userName: 'Muhammad Ali 1',
    testimonies:
        'I needed a unique design for my business website and found Learnoch The team was professional, creative, and delivered a stunning, user-friendly site that perfectly captured my brand. ',
  ),
  MyTestimonies(
    jobTitle: 'CEO, Learnoch',
    userName: 'Muhammad Ali 1',
    testimonies:
        'I needed a unique design for my business website and found Learnoch The team was professional, creative, and delivered a stunning, user-friendly site that perfectly captured my brand.',
  ),
];

class TestimoniesWidget extends HookConsumerWidget {
  const TestimoniesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(12),
      width: 392,
      height: 440,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SmartWrap(
        type: WrapType.column,
        spacing: 10,
        runSpacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Testimonies',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: dumMyTestimonies.map((catalog) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 284,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(ImageAssets.bgBlur),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          catalog.testimonies,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          catalog.userName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          catalog.jobTitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
