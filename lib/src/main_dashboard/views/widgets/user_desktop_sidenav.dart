import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wond3rcard/src/admin/common/widgets/reuseable_black_logo.dart';
import 'package:wond3rcard/src/main_dashboard/data/model/user_nav_item_model.dart';
import 'package:wond3rcard/src/main_dashboard/views/widgets/user_route_menu.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class UserDesktopSidenav extends StatelessWidget {
  final bool shouldPop;
  final List<UserNavItem> navItems;
  final Function(int) onNavItemTap;
  final Function(UserRouteMenu) onSubItemTap;
  final int selectedIndex;
  final int? selectedSubIndex;

  const UserDesktopSidenav({
    Key? key,
    required this.shouldPop,
    required this.navItems,
    required this.onNavItemTap,
    required this.onSubItemTap,
    required this.selectedIndex,
    this.selectedSubIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        color: AppColors.defaultWhite,
        margin: EdgeInsets.all(10),
        padding:
            const EdgeInsets.symmetric(horizontal: size10, vertical: size30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 31,
              width: 208,
              child: ReusableWonderCardLogo(),
            ),
            SizedBox(height: 40,),
            Container(
              color: AppColors.defaultWhite,
              width: size200,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(navItems.length, (index) {
                    final item = navItems[index];
                    final isSelected = selectedIndex == index;
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => onNavItemTap(index),
                          child: Container(
                            width: 358,
                            height: 51,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryShade
                                  : AppColors.defaultWhite,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    item.icon,
                                    colorFilter: isSelected
                                        ? const ColorFilter.mode(
                                            AppColors.defaultWhite,
                                            BlendMode.srcIn)
                                        : const ColorFilter.mode(
                                            AppColors.grayScale800,
                                            BlendMode.srcIn),
                                  ),
                                ),
                                const SizedBox(width: size22),
                                Flexible(
                                  child: Text(
                                    item.title,
                                    style: WonderCardTypography
                                        .adminSideNavTextStyle(
                                      color: isSelected
                                          ? AppColors.defaultWhite
                                          : AppColors.grayScale800,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isSelected && item.subItems != null)
                          Column(
                            children: item.subItems!.map((subItem) {
                              final subItemIndex =
                                  item.subItems!.indexOf(subItem);
                              final isSubItemSelected =
                                  selectedSubIndex != null &&
                                      selectedSubIndex == subItemIndex;
                              return ListTile(
                                title: Text(
                                  subItem.title,
                                  style: WonderCardTypography
                                      .adminSideNavTextStyle(
                                    fontSize: size12,
                                    color: isSubItemSelected
                                        ? AppColors.defaultWhite
                                        : AppColors.grayScale800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                selected: isSubItemSelected,
                                onTap: () => onSubItemTap(subItem.route),
                              );
                            }).toList(),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
