import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wond3rcard/src/utils/util.dart';

class PricingPlansSection extends StatefulWidget {
  const PricingPlansSection({super.key});

  @override
  State<PricingPlansSection> createState() => _PricingPlansSectionState();
}

class _PricingPlansSectionState extends State<PricingPlansSection> {
  bool isYearly = false;

  @override
  Widget build(BuildContext context) {
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
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: pricingPlans.length,
            itemBuilder: (context, index) {
              final plan = pricingPlans[index];
              return PricingPlanCard(plan: plan, isYearly: isYearly);
            },
          ),
        ),
      ],
    );
  }
}

class PricingPlanCard extends StatelessWidget {
  final PricingPlan plan;
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
            plan.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: plan.isPopular ? Colors.white : Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isYearly ? plan.yearlyPrice : plan.monthlyPrice,
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
                'Choose Plan',
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

class PricingPlan {
  final String title;
  final String monthlyPrice;
  final String yearlyPrice;
  final List<String> features;
  final bool isPopular;

  PricingPlan({
    required this.title,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.features,
    this.isPopular = false,
  });
}

final List<PricingPlan> pricingPlans = [
  PricingPlan(
    title: 'Basic',
    monthlyPrice: '\$0/mo',
    yearlyPrice: '\$0/yr',
    features: ['1 User', 'Basic Support', 'Limited Features'],
  ),
  PricingPlan(
    title: 'Pro',
    monthlyPrice: '\$7.5/mo',
    yearlyPrice: '\$91/yr',
    features: ['5 Users', 'Priority Support', 'All Features Included'],
    isPopular: true,
  ),
  PricingPlan(
    title: 'Enterprise',
    monthlyPrice: '\$55.25/mo',
    yearlyPrice: '\$663/yr',
    features: [
      'Unlimited Users',
      'Dedicated Support',
      'Custom Solutions',
      'Role-based access',
      'Advanced Analytics',
      'Enterprise support',
    ],
  ),
];
