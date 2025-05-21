import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/home/data/controller/home_controller.dart';
import 'package:wond3rcard/src/utils/decoration_box.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

Container bottomNav(BuildContext context, HomeNotifier homeController) {
  return Container(
    decoration: DecorationBox.bottomNavBoxDecoration(),
    child: SmartWrap(
      type: WrapType.row,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: navItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
    
        return GestureDetector(
          onTap: () {
            homeController.setActiveIndex(index);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(
              vertical: SpacingConstants.size8,
              horizontal: SpacingConstants.size13,
            ),
            height: SpacingConstants.size44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SpacingConstants.size44),
              border: Border.all(
                color: homeController.activeIndex == index
                    ? item.activeColor
                    : AppColors.transparent,
                width: size1point8,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                HeroIcon(
                  item.icon,
                  color: homeController.activeIndex == index
                      ? item.activeColor
                      : item.inactiveColor,
                  size: 35,
                ),
                homeController.activeIndex == index
                    ? Text(
                      item.label,
                      overflow: TextOverflow.ellipsis,
                      style: WonderCardTypography.boldTextBody(
                        fontSize: SpacingConstants.size13,
                        color: homeController.activeIndex == index
                            ? item.activeColor
                            : item.inactiveColor,
                      ),
                    )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );
}
