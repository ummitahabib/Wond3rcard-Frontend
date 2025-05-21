import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class QAndA extends StatelessWidget {
  const QAndA({super.key});
  static const routeName = RouteString.qAndA;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhite,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.defaultWhite,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          isDesktop(context)
                              ? context.go(RouteString.profile)
                              : Navigator.of(context).pop();
                        }),
                  ),
                  SizedBox(width: 40),
                  Text(
                    'Q & A',
                    style: WonderCardTypography.boldTextH5(
                        color: Colors.black, fontSize: 23),
                  ),
                  Spacer(),
                  SizedBox(width: 41),
                ],
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              'Find quick answers to frequently asked questions',
              style: TextStyle(
                  color: AppColors.grayScale700,
                  fontFamily: 'Barlow',
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            QuestionAnswerSection(),
          ],
        ),
      ),
    );
  }
}

class QuestionAnswerModel {
  final String question;
  final String answer;
  bool isExpanded;

  QuestionAnswerModel(
      {required this.question, required this.answer, this.isExpanded = false});
}

class QuestionAnswerSection extends StatefulWidget {
  @override
  _QuestionAnswerSectionState createState() => _QuestionAnswerSectionState();
}

class _QuestionAnswerSectionState extends State<QuestionAnswerSection> {
  final List<QuestionAnswerModel> qaList = [
    QuestionAnswerModel(
      question: 'Intellectual Property?',
      answer:
          'These Terms and Conditions outline the rules and regulations for using our website and services.',
    ),
    QuestionAnswerModel(
      question: 'Privacy Policy?',
      answer:
          'Our privacy policy explains how we handle your data securely and responsibly.',
    ),
    QuestionAnswerModel(
      question: 'Refund Policy?',
      answer: 'We offer a 30-day money-back guarantee on all purchases.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: qaList.length,
          itemBuilder: (context, index) {
            final item = qaList[index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      item.isExpanded = !item.isExpanded;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(item.question,
                                  style: TextStyle(
                                    color: AppColors.grayScale700,
                                    fontFamily: 'Barlow',
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            HeroIcon(
                              item.isExpanded
                                  ? HeroIcons.chevronDown
                                  : HeroIcons.chevronUp,
                              color: item.isExpanded
                                  ? AppColors.primaryShade
                                  : AppColors.grayScale600,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                if (item.isExpanded)
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(item.answer,
                        style: TextStyle(
                          color: AppColors.grayScale500,
                          fontFamily: 'Barlow',
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
