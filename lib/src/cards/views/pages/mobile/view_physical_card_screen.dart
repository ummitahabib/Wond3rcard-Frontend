import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewPhysicalCardScreen extends ConsumerWidget {
  const ViewPhysicalCardScreen({super.key});
  final String routeName = RouteString.viewPhysicalCard;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Physical Card',
          style: WonderCardTypography.boldTextH5(
            fontSize: 23,
            color: AppColors.grayScale,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              isDesktop(context)
                  ? context.go(RouteString.cardMain)
                  : context.go(RouteString.mainDashboard);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.grayScale,
            )),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Card Name',
                  style: TextStyle(
                    fontFamily: 'Barlow',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                SizedBox(
                    width: 141,
                    height: 40,
                    child: WonderCardButton(
                        leadingIcon: HeroIcon(
                          HeroIcons.shoppingBag,
                          color: AppColors.defaultWhite,
                        ),
                        backgroundColor: AppColors.primaryShade,
                        textColor: AppColors.defaultWhite,
                        text: 'Order Card',
                        onPressed: () {
                          context.go(RouteString.orderPhysicalCard);
                        }))
              ],
            ),
          ),
          BusinessCardWidget(),
        ],
      ),
    );
  }
}

class BusinessCardWidget extends HookConsumerWidget {
  const BusinessCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          final profileController = ref.watch(profileProvider);
          if (cardController.cardModel == null) {
            Future.delayed(Duration.zero, () async {
              await cardController.getAUsersCard(context, '');
              await profileController.getProfile(context);
            });
          }
        });
        return null;
      },
      [],
    );

    return Center(
      child: Container(
        width: 352,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Stack(
          children: [
            // Background SVG card template
            SvgPicture.asset(
              'images/card_template_1.svg',
              width: 350,
              height: 200,
              fit: BoxFit.cover,
            ),

            // Content Overlay
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Company Info (Left Side)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          ImageAssets.profile,
                          width: 24,
                          height: 24,
                        ),
                        Text(
                          profileController
                                  .profileData?.payload.profile.companyName ??
                              emptyString,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Personalized Learning AI',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff3B82F6),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 17),
                        HeroIcon(
                          HeroIcons.qrCode,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Card Holder Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff3B82F6),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Designation',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 69,
                          height: 3,
                          color: Color(0xff3B82F6),
                        ),
                        SizedBox(height: 5),
                        viewPhysicalCardChildren(
                            icon: HeroIcons.phone, text: '000-123-456-7890'),
                        viewPhysicalCardChildren(
                            icon: HeroIcons.envelope, text: 'user@gmail.com'),
                        viewPhysicalCardChildren(
                            icon: HeroIcons.mapPin, text: '125 Street, USA'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  
  
  }

  Row viewPhysicalCardChildren({
    required String text,
    required HeroIcons icon,
  }) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xff3B82F6),
          ),
          child: HeroIcon(
            icon,
            color: AppColors.defaultWhite,
            size: 5,
          ),
        ),
        Text(text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontSize: 8,
            )),
      ],
    );
  }
}
