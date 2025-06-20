import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/admin_dashboard.dart';
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
      UserType.admin.getValue(): MainDashboard(),
      //AdminDashBoardScreen(),
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














//updated 


// class BaseDashBoard extends StatefulHookConsumerWidget {
//   const BaseDashBoard({super.key});
//   static const String routeName = RouteString.baseDashboard;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _BaseDashBoardState();
// }

// class _BaseDashBoardState extends ConsumerState<BaseDashBoard> {
//   StreamSubscription? _sub;
//   final profileData = ValueNotifier<UserProfileResponse?>(null);

//   @override
//   void initState() {
//     super.initState();
//     _listenToDeepLinks();
//     _loadProfile();
//   }

//   void _listenToDeepLinks() {
//     _sub = uriLinkStream.listen((Uri? uri) async {
//       if (uri != null && uri.host == 'payment-success') {
//         final refId = uri.queryParameters['reference'];
//         final verified = await ref.read(paymentControllerProvider.notifier).verify(refId ?? '');

//         if (verified) {
//           // Refresh user info after verification
//           final updatedUser = await ref.read(authProvider.notifier).refreshUser(context);
//           profileData.value = updatedUser;
//         }
//       }
//     });
//   }

//   Future<void> _loadProfile() async {
//     final auth = ref.read(profileProvider);
//     final profile = await auth.getProfile(context);
//     profileData.value = profile;
//   }

//   @override
//   void dispose() {
//     _sub?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProfile = profileData.value;

//     if (userProfile == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     final role = getUserRoleFromString(
//       userProfile.payload.user.userRole ?? emptyString,
//     );

//     final Map<int, Widget> widgetMap = {
//       UserType.normal.getValue(): NormalDashboard(),
//       UserType.premium.getValue(): PremiumDashboard(),
//       UserType.team.getValue(): TeamDashboard(),
//       UserType.business.getValue(): BusinessDashboard(),
//       UserType.admin.getValue(): AdminDashboardDesktopView(),
//       UserType.unknown.getValue(): MainDashboard(),
//     };

//     return RoleBasedAccessWidget(
//       userRole: role,
//       widgetMap: widgetMap,
//     );
//   }
// }
