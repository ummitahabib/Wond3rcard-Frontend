import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';
import 'package:wond3rcard/src/payment/data/controller/payment_controller.dart';
import 'package:wond3rcard/src/payment/data/model/payment_model.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/subscription/views/widgets/price_plan_section.dart';
import 'package:wond3rcard/src/utils/util.dart';

class PaymentMethodDialog extends HookConsumerWidget {
  final PricingPlan plan;

  const PaymentMethodDialog({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isYearly = false;

    final profileController = ref.read(profileProvider);
    final userData = profileController.profileData!.payload.profile;
    final controller = ref.read(subscriptionControllerProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final controller = ref.read(subscriptionControllerProvider);
          if (profileController.profileData == null) {
            Future.delayed(Duration.zero, () async {
              await profileController.getProfile(context);
              await controller
                  .fetchSubscriptionById(controller.subscriptionTier?.id ?? '');
            });
          }
        });
        return null;
      },
      [],
    );
    final userId = userData.uid;
    final billingCycle =
        controller.selectedSubscription?.billingCycle == 'yearly'
            ? 'yearly'
            : 'monthly';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              textAlign: TextAlign.center,
              'Select Payment Method',
              style: GoogleFonts.poppins(
                color: AppColors.grayScale,
                fontSize: 23,
              )),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () async {
              final result = await _pay(
                context,
                ref,
                userId,
                plan,
                billingCycle,
                'paystack',
              );
              if (result != null && result.checkoutUrl != null) {
                await launchCheckoutUrl(result.checkoutUrl!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to initiate payment')),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Image.asset(
                    'images/paystack.png',
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    'Pay with Paystack',
                    style: GoogleFonts.poppins(
                        color: AppColors.darkDisable, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 13),
          GestureDetector(
            onTap: () async {
              final result = await _pay(
                context,
                ref,
                userId,
                plan,
                billingCycle,
                'stripe',
              );
              if (result != null && result.checkoutUrl != null) {
                await launchCheckoutUrl(result.checkoutUrl!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to initiate payment')),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Image.asset(
                    'images/stripe.png',
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    'Pay with Stripe',
                    style: GoogleFonts.poppins(
                        color: AppColors.darkDisable, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<PaymentResponseModel?> _pay(
      BuildContext context,
      WidgetRef ref,
      String userId,
      PricingPlan plan,
      String billingCycle,
      String method) async {
    final model = PaymentRequestModel(
      userId: userId,
      plan: plan.title.toLowerCase(),
      billingCycle: billingCycle,
    );

    await ref
        .read(paymentControllerProvider.notifier)
        .makePayment(model: model, method: method);

    final state = ref.read(paymentControllerProvider);

    PaymentResponseModel? result;

    state.whenOrNull(
      data: (response) {
        result = response;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Payment initialized: ${response?.reference}')),
        );
        // You could now verify or redirect depending on your flow
      },
      error: (err, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $err')),
        );
      },
    );

    return result;
  }
}

Future<void> launchCheckoutUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
