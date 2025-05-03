import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/data/controller/admin_dashboard_provider.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/admin_dashboard_page_header.dart';
import 'package:wond3rcard/src/main_dashboard/data/model/user_nav_item_model.dart';
import 'package:wond3rcard/src/main_dashboard/views/widgets/user_desktop_sidenav.dart';
import 'package:wond3rcard/src/main_dashboard/views/widgets/user_route_menu.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

class MainDashboardDesktop extends StatefulHookConsumerWidget {
  const MainDashboardDesktop({super.key, this.isTabView = false, this.child});
  final bool isTabView;
  final Widget? child;

  @override
  _MainDashboardDesktopState createState() => _MainDashboardDesktopState();
}

class _MainDashboardDesktopState extends ConsumerState<MainDashboardDesktop> {
  String? selectedSubItemTitle;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    final dashBoardController = ref.watch(adminDashBoardProvider);
    final userData = ref.watch(profileProvider).profileData?.payload.user;
    final navItems = userNavItems(context);

    void updateSubItem(UserNavItem mainItem, UserNavItem subItem) {
      setState(() {
        selectedSubItemTitle = subItem.title;
        dashBoardController.selectedDashBoardItemIndex = subItem.route.index;
      });

      context.go(subItem.route.path);
    }

    void onNavItemTap(int index) {
      final item = navItems[index];
      selectedIndex.value = index;

      if (item.subItems == null) {
        setState(() {
          selectedSubItemTitle = null;
          dashBoardController.selectedDashBoardItemIndex = index;
        });

        context.go(item.route.path);
      } else {
        updateSubItem(item, item.subItems!.first);
      }
    }

    void onSubItemTap(UserRouteMenu subItem) {
      final currentItem = navItems[selectedIndex.value];
      final selectedSubItem =
          currentItem.subItems!.firstWhere((item) => item.route == subItem);

      updateSubItem(currentItem, selectedSubItem);
    }

    String getTitle() {
      final currentItem = navItems[selectedIndex.value];
      if (currentItem.subItems != null && selectedSubItemTitle != null) {
        return '${currentItem.title} / $selectedSubItemTitle';
      }
      return currentItem.title;
    }

    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.defaultWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              UserDesktopSidenav(
                shouldPop: true,
                navItems: navItems,
                onNavItemTap: onNavItemTap,
                onSubItemTap: onSubItemTap,
                selectedIndex: selectedIndex.value,
              ),
              const VerticalDivider(color: AppColors.grayScale50),
              Expanded(
                child: Column(
                  children: [
                    PageHeader(
                      title: getTitle(),
                      userData: userData,
                      isTabView: widget.isTabView,
                    ),
                    Expanded(
                      child: widget.child ?? SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






















