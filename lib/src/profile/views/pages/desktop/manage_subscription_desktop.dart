import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ManageSubscriptionDesktop extends HookConsumerWidget {
  const ManageSubscriptionDesktop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.read(profileProvider);
    final authController = ref.read(authProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final userProfile = ref.read(profileProvider);

          Future.delayed(Duration.zero, () async {
            await userProfile.getProfile(context);
          });
        });
        return null;
      },
      [],
    );

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              context.go(RouteString.profile);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.grayScale,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Manage Subscription',
                style: WonderCardTypography.boldTextH5(
                  fontSize: 23,
                  color: AppColors.grayScale,
                ),
              ),
            )
          ],
        ),
        backgroundColor: AppColors.grayScale50,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                'Subscription Plan',
                style: TextStyle(
                  color: AppColors.primaryShade,
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 10),
              Text(
                softWrap: true,
                'Unlock all the power of this mobile tool and enjoy digital experience like never before!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grayScale800,
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 35),
              AnimatedBusinessOverlay(
                color: AppColors.primaryShade,
                icon: Icons.person,
                onTap: () {},
                planText: 'Basic Plan',
                iconColor: AppColors.defaultWhite,
                textColor: AppColors.defaultWhite,
              ),
              SizedBox(height: 10),
              AnimatedBusinessOverlay(
                color: AppColors.primaryShade100,
                icon: Icons.workspace_premium,
                onTap: () {},
                planText: 'Upgrade to Premium',
                iconColor: AppColors.primaryShade,
                textColor: AppColors.primaryShade,
              ),
              SizedBox(height: 10),
              AnimatedBusinessOverlay(
                color: AppColors.primaryShade100,
                icon: Icons.people,
                onTap: () {},
                planText: 'Upgrade to Business',
                iconColor: AppColors.primaryShade,
                textColor: AppColors.primaryShade,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Member Since ${DateFormat('MMMM d, y').format(DateTime.parse(userProfile.profileData?.payload.user.createdAt?.toString() ?? DateTime.now().toString()))}',
                  style: WonderCardTypography.regularTextTitle2(
                    color: AppColors.grayScale800,
                    fontSize: 16,
                  ),
                ),
              ),
            ]));
  }
}

class AnimatedBusinessOverlay extends StatefulWidget {
  AnimatedBusinessOverlay(
      {super.key,
      required this.color,
      required this.icon,
      required this.onTap,
      required this.planText,
      required this.iconColor,
      required this.textColor});
  final String planText;
  final IconData icon;
  final Color color;
  Function()? onTap;
  final Color iconColor;
  final Color textColor;

  @override
  State<AnimatedBusinessOverlay> createState() =>
      _AnimatedBusinessOverlayState();
}

class _AnimatedBusinessOverlayState extends State<AnimatedBusinessOverlay>
    with SingleTickerProviderStateMixin {
  bool _showOverlay = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Starts below
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  void _toggleOverlay() {
    setState(() {
      _showOverlay = true;
    });
    _controller.forward();
  }

  void _closeOverlay() {
    _controller.reverse().then((_) {
      setState(() {
        _showOverlay = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleOverlay,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.color ?? const Color(0xFFF9F0FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF402577), width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    textAlign: TextAlign.center,
                    widget.planText,
                    style: TextStyle(
                      color: widget.textColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Barlow',
                      fontSize: 23,
                    )),
                SizedBox(width: 10),
                Icon(
                  widget.icon,
                  color: widget.iconColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
