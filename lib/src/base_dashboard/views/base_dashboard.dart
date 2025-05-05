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
    final authProvide = ref.watch(profileProvider);
    final profileData = useState<UserProfileResponse?>(authProvide.profileData);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (profileData.value == null) {
          final profile = await authProvide.getProfile(context);
          profileData.value = profile; 
        }
      });
      return null;
    }, []);
    if (profileData.value == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final Map<int, Widget> widgetMap = {
      UserType.normal.getValue(): MainDashboard(),
      UserType.premium.getValue(): MainDashboard(),
      UserType.team.getValue(): MainDashboard(),
      UserType.business.getValue(): MainDashboard(),
         UserType.admin.getValue(): Container(),
         //AdminDashboardDesktopView(),
      UserType.unknown.getValue(): MainDashboard(),
    };

    return RoleBasedAccessWidget(
      userRole: getUserRoleFromString(
        profileData.value?.payload.user.userRole ?? emptyString,
      ),
      widgetMap: widgetMap,
    );
  }
}
