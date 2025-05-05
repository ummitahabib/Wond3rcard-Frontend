import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/reusbale_header_widget.dart';
import 'package:wond3rcard/src/privacy_security/views/pages/mobile/privacy_security_mobile.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';

class SetPlanLimitsFeature extends ConsumerStatefulWidget {
  const SetPlanLimitsFeature({super.key});

  @override
  _SetPlanLimitsFeatureState createState() => _SetPlanLimitsFeatureState();
}

class _SetPlanLimitsFeatureState extends ConsumerState<SetPlanLimitsFeature> {
  final String routeName = RouteString.planLimitFeatures;

  final Map<String, bool> features = {
    'Analytics': false,
    'Multiple Card Creation': false,
    'Custom Branding': false,
    'Project Planning': false,
  };

  void _toggleFeature(String feature, bool? isSelected) {
    setState(() {
      features[feature] = isSelected ?? false;
      _updateFeaturesController();
    });
  }

  void _updateFeaturesController() {
    final notifier = ref.read(createSubscriptionProvider.notifier);
    final selected = features.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    notifier.featuresController.text = selected.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 28),
              Text(
                'Monitor and manage all Subscription in the system',
                style: WonderCardTypography.boldTextTitleBold(
                    fontSize: 18, color: const Color(0xff3A3541)),
              ),
              const SizedBox(height: 30),
              _buildStepsHeader(),
              const SizedBox(height: 20),
              _buildFeatureCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(onTap: () {}, child: reusableBackIcon()),
        const SizedBox(width: 20),
        Text(
          'Create New Subscription plan',
          style: WonderCardTypography.headlineH2(
              fontSize: 25, color: AppColors.primaryShade),
        ),
      ],
    );
  }

  Widget _buildStepsHeader() {
    return Container(
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          reuseableHeaderWidget(
            number: '1',
            text: 'Basic Plan Information',
            activeColor: AppColors.primaryShade,
          ),
          reuseableHeaderWidget(
            number: '2',
            text: 'Set Plan Limits & Features',
            activeColor: AppColors.primaryShade,
          ),
          reuseableHeaderWidget(
            number: '3',
            text: 'Review & Confirm',
            activeColor: AppColors.primaryShade200,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Plan Limits & Features',
              style: TextStyle(
                color: const Color(0xff3A3541),
                fontFamily: 'Barlow',
                fontSize: 22.78,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Mandatory information',
              style: TextStyle(
                color: const Color(0xff89868D),
                fontFamily: 'Barlow',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            _buildFeatureCheckboxes(),
            const SizedBox(height: 30),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCheckboxes() {
    return Column(
      children: features.entries.map((entry) {
        return Column(
          children: [
            _featureRow(entry.key, entry.value),
            const Divider(),
          ],
        );
      }).toList(),
    );
  }

  Widget _featureRow(String title, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title, style: _featureStyle())),
        Checkbox.adaptive(
          value: value,
          onChanged: (val) => _toggleFeature(title, val),
        ),
      ],
    );
  }

  TextStyle _featureStyle() {
    return WonderCardTypography.boldTextTitle2(
      color: const Color(0xff18181B),
      fontSize: 16,
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 166,
          height: 50,
          child: WonderCardButton(
            backgroundColor: AppColors.grayScale50,
            textColor: AppColors.primaryShade,
            onPressed: () {
              context.go(RouteString.createNewSubscription);
            },
            text: 'Back',
            trailingIcon:
                Icon(Icons.arrow_back_ios, color: AppColors.primaryShade),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 166,
          height: 50,
          child: WonderCardButton(
            textColor: Colors.white,
            onPressed: () {
              context.go(RouteString.subscriptionReview);
            },
            text: 'Next',
            trailingIcon:
                Icon(Icons.arrow_forward_ios, color: AppColors.defaultWhite),
          ),
        ),
      ],
    );
  }
}
