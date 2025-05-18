import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/utils/util.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});
  static const routeName = RouteString.termsAndCondition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              isDesktop(context)
                  ? context.go(RouteString.profile)
                  : context.go(RouteString.profile);
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
            centerTitle: true,
            title: Text('Terms and Condition'),
      ),
      backgroundColor: AppColors.defaultWhite,
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.justify,
                      'Last updated: February 03, 2024',
                      style: TextStyle(
                        color: AppColors.grayScale700,
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Welcome to Wond3rcard!',
                      style: TextStyle(
                        color: AppColors.grayScale700,
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'These Terms and Conditions outline the rules and regulations for using our website and services. By accessing this website and using our services, you accept these terms and conditions. If you disagree with any part of these terms, please do not use our website or services.',
                      style: TextStyle(
                        color: AppColors.grayScale700,
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      'Interpretation and Definitions',
                      style: TextStyle(
                        color: AppColors.grayScale700,
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                      style: TextStyle(
                        color: AppColors.grayScale700,
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      'Intellectual Property',
                      style: TextStyle(
                        color: AppColors.grayScale700,
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Unless otherwise stated, A&A Surf Networks LTD. and/or its licensors own the intellectual property rights for all material on Wond3rcard. All intellectual property rights are reserved. You may view and/or print pages from https://wond3rcard.com/ for your personal use, subject to restrictions set in these terms and conditions.',
                      style: TextStyle(
                        color: AppColors.grayScale700,
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      'Restrictions',
                      style: TextStyle(
                        color: AppColors.grayScale700,
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
