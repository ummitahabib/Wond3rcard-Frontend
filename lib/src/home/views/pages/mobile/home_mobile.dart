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
    SizeConfig.init(context);
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
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          ImageAssets.frameCard,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50,),
                              child: Row(
                                children: [
                                  Container(
                                    width: SizeConfig.w(65) +
                                        (4.62 * 2), 
                                    height: SizeConfig.h(65) + (4.62 * 2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors
                                            .white, 
                                        width: 4.62,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 65 / 2,
                                      backgroundImage: NetworkImage(
                                        profile?.profileUrl ??
                                            defaultProfileImage,
                                      ), 
                                      backgroundColor:
                                          Colors.grey, 
                                    ),
                                  ),
                                  Spacer(),
                                  connectText(
                                      text: profile?.connections.length
                                              .toString() ??
                                          0.toString()),
                                ],
                              ),
                            ),
                          
                          SizedBox(height: SizeConfig.h(16)),
                            
                           Padding(
                              padding: EdgeInsets.only(left: SizeConfig.h(112)),
                              child: NameAndJob(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
