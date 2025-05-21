import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/home/views/widgets/name_and_job.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';
class HomeMobile extends HookConsumerWidget {
  const HomeMobile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: HomeBody(),
    );
  }
}

class HomeBody extends HookConsumerWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final profileController = ref.watch(profileProvider);
          if (profileController.profileData == null) {
            Future.delayed(Duration.zero, () async {
              await profileController.getProfile(context);
            });
          }
        });
        return null;
      },
      [],
    );
    final profileController = ref.watch(profileProvider);
    final profile = profileController.profileData?.payload.profile;

    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: Stack(
        children: [
          Image.asset(
            ImageAssets.bgBlur,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      width: 357,
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primaryShade,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  userProfileImage(height: 65, width: 65),
                                  connectText(
                                      text: profile?.connections.length
                                              .toString() ??
                                          0.toString()),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.defaultWhite,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Spacer(),
                                      NameAndJob(),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    personalProfileTag(),
                                    qrCodeContainer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        addCardMainRowWidget(context),
                        Container(
                          margin: const EdgeInsets.all(14),
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: ConnectionsMedia()),
                              const SizedBox(width: 10),
                              Expanded(child: RecentConnectionWidget()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
