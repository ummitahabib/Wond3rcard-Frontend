import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';
import 'package:wond3rcard/src/subscription/views/widgets/price_plan_section.dart';
import 'package:wond3rcard/src/utils/util.dart';

class PlanSection extends HookConsumerWidget {
  const PlanSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionState = ref.watch(subscriptionControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final controller = ref.read(subscriptionControllerProvider);
        if (subscriptionState.subscriptionTiers == null) {
          await controller.fetchSubscriptionTiers();
          await controller
              .fetchSubscriptionById(controller.subscriptionTier?.id ?? '');
        }
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Subscription Plans',
          style: GoogleFonts.barlow(
            fontWeight: FontWeight.w700,
            fontSize: isDesktop(context) ? 24 : 20,
            color: Color(0xff191A15),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff191A15)),
          onPressed: () {
            context.go(RouteString.memebershipSubscription);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: isMobile(context)
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: _columnMethod(context),
              )
            : _columnMethod(context),
      ),
    );
  }

  Column _columnMethod(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          textAlign: TextAlign.center,
          'Choose Plan',
          style: GoogleFonts.barlow(
            fontWeight: FontWeight.w700,
            fontSize: isDesktop(context) ? 60 : 30,
            color: Color(0xff191A15),
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          'That’s Right For You',
          style: GoogleFonts.barlow(
            fontWeight: FontWeight.w700,
            fontSize: isDesktop(context) ? 60 : 30,
            color: Color(0xff191A15),
          ),
        ),
        isDesktop(context)
            ? SizedBox(
                width: 1006,
                height: 72,
                child: Text(
                  softWrap: true,
                  'Wond3rcard offers flexible pricing tailored to individuals, professionals, and enterprises. Choose between affordable monthly plans or save with yearly subscriptions.',
                  style: GoogleFonts.barlow(
                    fontWeight: FontWeight.w500,
                    fontSize: isDesktop(context) ? 21.6 : 14,
                    color: AppColors.grayScale500,
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(5),
                child: Text(
                  textAlign: TextAlign.center,
                  softWrap: true,
                  'Wond3rcard offers flexible pricing tailored to individuals, professionals, and enterprises. Choose between affordable monthly plans or save with yearly subscriptions.',
                  style: GoogleFonts.barlow(
                    fontWeight: FontWeight.w500,
                    fontSize: isDesktop(context) ? 21.6 : 14,
                    color: AppColors.grayScale500,
                  ),
                ),
              ),
        PricingPlansSection(),
        Text(
          softWrap: true,
          textAlign: TextAlign.center,
          'Physical NFC cards are sold separately and require an active subscription.',
          style: GoogleFonts.barlow(
            fontWeight: FontWeight.w500,
            fontSize: isDesktop(context) ? 27.33 : 15,
            color: Color(0xffFF0A1D),
          ),
        ),
      ],
    );
  }
}
