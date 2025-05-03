import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/desktop/admin_dashboard_desktop.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:go_router/go_router.dart';

class PhysicalCardWidget extends ConsumerWidget {
   PhysicalCardWidget({super.key});

  final String routeName = RouteString.physicalCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'My orders',
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
                      text: 'View Cards',
                      onPressed: () {
                      context.go(RouteString.viewPhysicalCard);
                      }))
            ],
          ),
        ),
        
        GestureDetector(
          onTap: (){
            context.go(RouteString.viewPhysicalCard);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.defaultWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primaryShade,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned.fill(
                      child: ClipOval(
                        child: Image.network(
                          ImageAssets.bgBlur,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Card name',
                          style: WonderCardTypography.boldTextH5(
                            fontSize: 23,
                            color: AppColors.grayScale700,
                          )),
                      Text('Designation',
                          style: WonderCardTypography.regularTextTitle2(
                              fontSize: 16, color: AppColors.grayScale600)),
                      Row(
                        children: [
                          Text(
                            'Active',
                            style: WonderCardTypography.boldTextTitle2(
                                fontSize: size16, color: AppColors.success),
                          ),
                          Switch.adaptive(value: true, onChanged: (bool) {})
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.grayScale600,
                )
              ],
            ),
          ),
        ),
     
     
      ],
    );
  }
}
