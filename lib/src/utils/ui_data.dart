import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_sub_model.dart';
import 'package:wond3rcard/src/admin/common/data/model/admin_nav_item.dart';
import 'package:wond3rcard/src/admin/common/widgets/admin_route_menu_item.dart';
import 'package:wond3rcard/src/analytics/data/model/analytics_card_data_model.dart';
import 'package:wond3rcard/src/home/data/model/nav_item_model.dart';
import 'package:wond3rcard/src/main_dashboard/data/model/user_nav_item_model.dart';
import 'package:wond3rcard/src/main_dashboard/views/widgets/user_route_menu.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

const activeColor = AppColors.primaryShade;
const inActiveColor = AppColors.grayScale500;
final List<NavItemModel> navItems = [
  NavItemModel(
    icon: HeroIcons.home,
    label: emptyString,
    //home,
    activeColor: activeColor,
    inactiveColor: inActiveColor,
  ),
  NavItemModel(
    icon: HeroIcons.creditCard,
    label: emptyString,
    //card,
    activeColor: activeColor,
    inactiveColor: inActiveColor,
  ),
  NavItemModel(
    icon: HeroIcons.qrCode,
    label: emptyString,
    activeColor: activeColor,
    inactiveColor: inActiveColor,
  ),

    NavItemModel(
    icon: HeroIcons.link,
    label: emptyString,
    activeColor: activeColor,
    inactiveColor: inActiveColor,
  ),
  NavItemModel(
    icon: HeroIcons.chartBar,
    label: emptyString,
    // analytics,
    activeColor: activeColor,
    inactiveColor: inActiveColor,
  ),
  NavItemModel(
    icon: HeroIcons.userGroup,
    label: emptyString,
    // profile,
    activeColor: activeColor,
    inactiveColor: inActiveColor,
  ),
];

final List<Color> predefinedColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.amber,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
];

final List<CardDataModel> cardDataList = [
  CardDataModel(
    title: 'Total views',
    icon: HeroIcons.eye,
    iconColor: AppColors.grayScale600,
  ),
  CardDataModel(
    title: 'Total shares',
    icon: HeroIcons.share,
    iconColor: AppColors.grayScale600,
  ),
  CardDataModel(
    title: 'New Contacts',
    icon: HeroIcons.user,
    iconColor: AppColors.grayScale600,
  ),
  CardDataModel(
    title: 'Link taps',
    icon: HeroIcons.link,
    iconColor: AppColors.grayScale600,
  ),
];

final List<FilterOption> filterOptions = [
  FilterOption(label: 'Today', onTap: () => print('Today selected')),
  FilterOption(label: 'This Week', onTap: () => print('This Week selected')),
  FilterOption(label: 'Last Month', onTap: () => print('Last Month selected')),
  FilterOption(label: 'Last Year', onTap: () => print('Last Year selected')),
  FilterOption(label: 'All', onTap: () => print('All selected')),
];

class FilterOption {
  final String label;
  final void Function() onTap;

  FilterOption({required this.label, required this.onTap});
}

final List<FilterOption> cardsfilterOptions = [
  FilterOption(label: 'latest', onTap: () => print('Latest selected')),
  FilterOption(label: 'popular', onTap: () => print('Popular selected')),
  FilterOption(label: 'oldest', onTap: () => print('Oldest selected')),
];

List<AdminNavItem> adminNavItems(BuildContext context) {
  return [
    AdminNavItem(
      title: 'Dashboard',
      icon: SvgAssets.userDasboard,
      route: AdminRouteMenuItem.adminDashBoardDesktopView,
    ),
    AdminNavItem(
      title: 'User Management',
      icon: SvgAssets.userManagement,
      route: AdminRouteMenuItem.userManagement,
    ),
    AdminNavItem(
      title: 'Card Management',
      icon: SvgAssets.userCardManagement,
      route: AdminRouteMenuItem.cardManagement,
    ),
    AdminNavItem(
      title: 'Analytics',
      icon: SvgAssets.analytics,
      route: AdminRouteMenuItem.analytics,
    ),
    AdminNavItem(
      title: 'Security',
      icon: SvgAssets.security,
      route: AdminRouteMenuItem.security,
    ),
    AdminNavItem(
      title: 'Subscription',
      icon: SvgAssets.subscription,
      route: AdminRouteMenuItem.subscription,
    ),
    AdminNavItem(
      title: 'Feature Flag',
      icon: SvgAssets.flag,
      route: AdminRouteMenuItem.flags,
    ),
    AdminNavItem(
      title: 'Settings',
      icon: SvgAssets.settings,
      route: AdminRouteMenuItem.settings,
    ),
  ];
}



List<AdminSubscriptionModel> adminSubscriptions = [
  AdminSubscriptionModel(title: 'Total Users', value: '302'),
  AdminSubscriptionModel(title: 'Premium Users', value: '59'),
  AdminSubscriptionModel(title: 'Business Users', value: '99'),
  AdminSubscriptionModel(title: 'Active Plans', value: '003'),
  AdminSubscriptionModel(title: 'Monthly Revenue', value: '882'),
];


List<AdminSubscriptionModel> billingAndPayment = [
  AdminSubscriptionModel(title: 'Total Revenue', value: '210.2k'),
  AdminSubscriptionModel(title: 'Pending Payment', value: '50.2k'),
  AdminSubscriptionModel(title: 'Failed Payment', value: '12.2k'),
  AdminSubscriptionModel(title: 'Cancel Payment', value: '5.2k'),
];



List<AdminSubscriptionModel> analyticsData = [
  AdminSubscriptionModel(title: 'Total Revenue', value: '210.2k'),
  AdminSubscriptionModel(title: 'Total Users', value: '50.2k'),
  AdminSubscriptionModel(title: 'Total Cards', value: '12.2k'),
];


List<AdminSubscriptionModel> revenueAnalyticsData = [
  AdminSubscriptionModel(title: 'Total Revenue', value: '210.2k'),
  AdminSubscriptionModel(title: 'New Revenue', value: '50.2k'),
  AdminSubscriptionModel(title: 'Active Paid', value: '12.2k'),
    AdminSubscriptionModel(title: 'Failed  Payment rate', value: '12.2k'),
];

List<AdminSubscriptionModel> subscriptionAnalyticsData = [
  AdminSubscriptionModel(title: 'Active Subscription', value: '210.2k'),
  AdminSubscriptionModel(title: 'Trial Conversion rate', value: '50.2k'),
  AdminSubscriptionModel(title: 'Most Active Plan', value: '12.2k'),
    AdminSubscriptionModel(title: 'Plan Canceling rate', value: '12.2k'),
];





List<UserNavItem> userNavItems(BuildContext context) {
  return [
    UserNavItem(
      title: 'Dashboard',
      icon: SvgAssets.userDasboard,
      route: UserRouteMenu.home,
    ),
    UserNavItem(
      title: 'Card',
      icon: SvgAssets.userManagement,
      route: UserRouteMenu.card,
    ),
    UserNavItem(
      title: 'Share',
      icon: SvgAssets.userCardManagement,
      route: UserRouteMenu.share,
    ),
    UserNavItem(
      title: 'Contact',
      icon: SvgAssets.analytics,
      route: UserRouteMenu.connections,
    ),
    UserNavItem(
      title: 'Analytics',
      icon: SvgAssets.security,
      route: UserRouteMenu.analytics,
    ),
    UserNavItem(
      title: 'Profile',
      icon: SvgAssets.flag,
      route: UserRouteMenu.profile,
    ),
  
  ];
}

