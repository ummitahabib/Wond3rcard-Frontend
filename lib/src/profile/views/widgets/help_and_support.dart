import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});
  static const routeName = RouteString.helpAndSupport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                          : context.go(RouteString.mainDashboard);
                    }),
              ),
              SizedBox(width: 40),
              Text(
                'Contact Support',
                style: WonderCardTypography.boldTextH5(
                    color: Colors.black, fontSize: 23),
              ),
              Spacer(),
              SizedBox(width: 41),
            ],
          ),
        ),
        SizedBox(
          width: 327,
          height: 50,
          child: Text(
              'Need more information or inquiry contact us with the details below',
              style: TextStyle(
                color: AppColors.grayScale700,
                fontFamily: 'Barlow',
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              )),
        ),
        SizedBox(
          height: 50,
        ),
        reusableWidget(),
        SizedBox(
          height: 20,
        ),
        reusableWidget(
          text1: 'Phone',
          text2: '+234 123 456 7890',
          icon: HeroIcons.phone,
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Our social media accounts',
          style: WonderCardTypography.boldTextTitleBold(),
        ),
        SocialMediaGrid(),
        SizedBox(
          height: 40,
        ),
        SizedBox(
          width: 327,
          height: 50,
          child: Text(
            textAlign: TextAlign.center,
            'Have more questions? wond3rcard.com, We aim to respond promptly',
            style: TextStyle(
              color: AppColors.grayScale700,
              fontFamily: 'Barlow',
              fontSize: 18,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    ));
  }

  Container reusableWidget({
    String? text1,
    String? text2,
    HeroIcons? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      width: 361,
      height: 93,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grayScale300,
          width: 1,
        ),
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1 ?? 'Email',
                style: WonderCardTypography.regularTextTitle2(
                  color: AppColors.grayScale300,
                  fontSize: 18,
                ),
              ),
              Text(
                text2 ?? 'support@wond3rcard.com ',
                style: WonderCardTypography.regularTextTitle2(
                  color: AppColors.grayScale600,
                  fontSize: 19,
                ),
              ),
            ],
          ),
          HeroIcon(
            icon ?? HeroIcons.envelope,
            size: 45,
            color: AppColors.primaryShade,
          ),
        ],
      ),
    );
  }
}

class SocialMediaModel {
  final String name;
  final String asset;
  final String route;

  SocialMediaModel(
      {required this.name, required this.asset, required this.route});
}

class SocialMediaGrid extends StatelessWidget {
  final List<SocialMediaModel> socialMediaItems = [
    SocialMediaModel(
        name: 'LinkedIn', asset: ImageAssets.checkEmail, route: '/linkedin'),
    SocialMediaModel(
        name: 'Instagram', asset: ImageAssets.cardBanner, route: '/instagram'),
    SocialMediaModel(
        name: 'Telegram', asset: ImageAssets.checkEmail, route: '/telegram'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 100.595,
      height: 130,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: socialMediaItems.length,
        itemBuilder: (context, index) {
          final item = socialMediaItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, item.route);
            },
            child: SizedBox(
              width: 100,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        item.asset,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.name,
                      style: WonderCardTypography.regularTextTitle2(
                          fontSize: 16, color: AppColors.grayScale),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
