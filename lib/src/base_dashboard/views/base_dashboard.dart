import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/desktop/admin_dashboard_desktop_view.dart';
import 'package:wond3rcard/src/base_dashboard/views/widgets/role_base_access_widget.dart';
import 'package:wond3rcard/src/main_dashboard/views/main_dashboard.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_model/profile.dart';
import 'package:wond3rcard/src/utils/user_role_enum.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class BaseDashBoard extends StatefulHookConsumerWidget {
  const BaseDashBoard({super.key});

  static const String routeName = RouteString.baseDashboard;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseDashBoardState();
}

class _BaseDashBoardState extends ConsumerState<BaseDashBoard> {
  @override
  Widget build(BuildContext context) {
    final authProvide = ref.read(profileProvider);
    final profileData = useState<UserProfileResponse?>(null);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          if (authProvide.profileData == null) {
            Future.delayed(Duration.zero, () async {
              final profile = await authProvide.getProfile();
              setState(() {
                profileData.value = profile;
              });
            });
          }
        });
        return null;
      },
      [],
    );

    final Map<int, Widget> widgetMap = {
      UserRole.unknown.getValue(): MainDashboard(),
      UserRole.customer.getValue(): MainDashboard(),
      UserRole.admin.getValue(): AdminDashboardDesktopView(),
      UserRole.moderator.getValue(): MainDashboard(),
    };
    return RoleBasedAccessWidget(
      userRole: getUserRoleFromString(
        authProvide.profileData!.payload.user.userType,
      ),
      widgetMap: widgetMap,
    );
  }
}
