import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';

class AdminEditUser extends ConsumerWidget {
  AdminEditUser({super.key});

  final String routeName = RouteString.adminEditUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                HeroIcon(
                  HeroIcons.backspace,
                  color: AppColors.primaryShade,
                ),
                SizedBox(
                  width: 27,
                ),
                Text('User Profile',
                    style: WonderCardTypography.headlineH2(
                        fontSize: 25, color: AppColors.primaryShade)),
                Spacer(),
                SizedBox(),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 19),
              decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 44,
                      child: WonderCardButton(
                          borderColor: AppColors.grayScale700,
                          leadingIcon: HeroIcon(
                            HeroIcons.magnifyingGlassCircle,
                            color: AppColors.grayScale700,
                            size: 24,
                          ),
                          backgroundColor: AppColors.grayScale50,
                          text: 'Suspend',
                          onPressed: () {})),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      height: 44,
                      child: WonderCardButton(
                          borderColor: AppColors.grayScale700,
                          leadingIcon: HeroIcon(
                            HeroIcons.devicePhoneMobile,
                            color: AppColors.grayScale700,
                            size: 24,
                          ),
                          backgroundColor: AppColors.grayScale50,
                          text: 'Disable Selected',
                          onPressed: () {})),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      height: 44,
                      child: WonderCardButton(
                          leadingIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HeroIcon(
                              HeroIcons.devicePhoneMobile,
                              color: AppColors.grayScale700,
                              size: 24,
                            ),
                          ),
                          borderColor: AppColors.grayScale700,
                          backgroundColor: AppColors.grayScale50,
                          text: 'Edit Payment Method',
                          onPressed: () {})),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      height: 44,
                      child: WonderCardButton(
                          borderColor: AppColors.grayScale700,
                          leadingIcon: HeroIcon(
                            HeroIcons.trash,
                            color: AppColors.grayScale700,
                            size: 24,
                          ),
                          backgroundColor: AppColors.grayScale50,
                          text: 'Delete  Selected',
                          onPressed: () {})),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userDetailsWidget(),
                Container(
                  width: 836,
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 19),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text('User information',
                              style: WonderCardTypography.boldTextH5(
                                fontSize: 23,
                                color: Color(0xff3A3541),
                              )),
                          Spacer(),
                          SizedBox(
                            height: 40,
                            child: WonderCardButton(
                                leadingIcon: HeroIcon(
                                  HeroIcons.pencil,
                                  color: AppColors.defaultWhite,
                                  size: 24,
                                ),
                                text: 'Edit Profile',
                                onPressed: () {}),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Color(0xFFBDBDBD), width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                headerAndTilteText(
                                    title: 'First Name', subTitle: 'Ummeeta'),
                                Spacer(),
                                headerAndTilteText(
                                    title: 'Surname', subTitle: 'Habib')
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                headerAndTilteText(
                                    title: 'Personal Email',
                                    subTitle: 'Example@gmail.com'),
                                Spacer(),
                                headerAndTilteText(
                                    title: 'Mobile', subTitle: '08123456789')
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container userDetailsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundColor: AppColors.primaryShade,
              ),
            ),
            Text(
              'user name',
              style: TextStyle(
                fontFamily: 'Barlow',
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              'user@gmail.com',
              style: TextStyle(
                fontFamily: 'Barlow',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.grayScale500,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
                height: 26,
                child: WonderCardButton(
                    backgroundColor: AppColors.warning,
                    textColor: AppColors.grayScale800,
                    leadingIcon: Icon(Icons.workspace_premium,
                        color: AppColors.grayScale800),
                    text: 'Premium',
                    onPressed: () {})),
            Divider(
              thickness: 1,
              color: Color(0xffDDDDDD),
            ),
            SizedBox(
              height: 15,
            ),
            reusableEditUserText(),
            Divider(
              thickness: 1,
              color: Color(0xffDDDDDD),
            ),
            SizedBox(
              height: 15,
            ),
            reusableEditUserText(title: 'Last Login', subTitle: '24- Oct-2024'),
            SizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Status',
                  style: TextStyle(
                    color: Color(0xff5B5B5B),
                    fontFamily: 'Barlow',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                    height: 24,
                    child: WonderCardButton(
                        backgroundColor: AppColors.success,
                        text: 'Active',
                        onPressed: () {}))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column reusableEditUserText({String? title, String? subTitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          textAlign: TextAlign.center,
          title ?? 'Date of creation',
          style: TextStyle(
            color: Color(0xff5B5B5B),
            fontFamily: 'Barlow',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          textAlign: TextAlign.center,
          subTitle ?? '24- Oct-2024',
          style: TextStyle(
            color: Color(0xff5B5B5B),
            fontFamily: 'Barlow',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Column headerAndTilteText({String? title, String? subTitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title ?? '',
            style: WonderCardTypography.regularTextTitle2(
              fontSize: 16,
              color: Color(0xff3A3541),
            )),
        SizedBox(
          height: 13,
        ),
        Text(subTitle ?? '',
            style: WonderCardTypography.boldTextTitleBold(
              fontSize: 18,
              color: Color(0xff3A3541),
            )),
      ],
    );
  }
}
