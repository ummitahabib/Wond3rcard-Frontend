import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_subscription_model.dart';
import 'package:wond3rcard/src/utils/util.dart';

class PricingPlansSection extends StatefulHookConsumerWidget {
  const PricingPlansSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PricingPlansSectionState();
}

class _PricingPlansSectionState extends ConsumerState<PricingPlansSection> {
  bool isYearly = false;

  @override
  Widget build(BuildContext context) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Monthly',
              style: TextStyle(
                color: !isYearly ? Colors.deepPurple : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              autofocus: true,
              value: isYearly,
              activeColor: Colors.deepPurple,
              onChanged: (value) {
                setState(() {
                  isYearly = value;
                });
              },
            ),
            Text(
              'Yearly',
              style: TextStyle(
                color: isYearly ? Colors.deepPurple : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          child: subscriptionState.selectedSubscription != null
              ? PricingPlanCard(
                  plan: subscriptionState.selectedSubscription!,
                  isYearly: isYearly)
              : const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}

class PricingPlanCard extends StatelessWidget {
  final Subscription plan;
  final bool isYearly;

  const PricingPlanCard({
    super.key,
    required this.plan,
    required this.isYearly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: plan.isPopular ? Colors.deepPurple : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurpleAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurpleAccent.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (plan.isPopular)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryShade,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Text(
            plan.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: plan.isPopular ? Colors.white : Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${isYearly ? plan.billingCycle.yearly.price : plan.billingCycle.monthly.price}',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: plan.isPopular ? Colors.white : Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          ...plan.features.map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color:
                        plan.isPopular ? Colors.white : Colors.deepPurpleAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        color:
                            plan.isPopular ? Colors.white : Color(0xff191A15),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: plan.isPopular
                    ? AppColors.primaryShade500
                    : Colors.deepPurple,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                textAlign: TextAlign.center,
                'Make Payment',
                style: GoogleFonts.barlow(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
