import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/admin_analytics.dart';
import 'package:wond3rcard/src/admin/admin_cards/views/card_table.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/admin_dashboard.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/desktop/admin_dashboard_desktop_view.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/admin_subscription.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/pages/manage_user_subscription.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/pages/subscription_settings.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/widgets/create_new_subscription_plan.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/widgets/review_confirmation_review.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/widgets/set_plan_limits_feature.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/pages/admin_user_management.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/pages/desktop/admin_create_new_user.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/pages/desktop/admin_edit_user.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/account_settings_widget.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/add_user_widget.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/additional_information_widget.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/review_widget.dart';
import 'package:wond3rcard/src/analytics/views/pages/analytics_main_page.dart';
import 'package:wond3rcard/src/analytics/views/widgets/select_card_analytics.dart';
import 'package:wond3rcard/src/analytics/views/widgets/selected_card_analytics.dart';
import 'package:wond3rcard/src/authentication/views/authentication/change_password/views/reset_password_main.dart';
import 'package:wond3rcard/src/authentication/views/authentication/forgot_password_otp_verification/views/pages/forgot_password_otp_verification_main.dart';
import 'package:wond3rcard/src/authentication/views/authentication/login/views/pages/login_main.dart';
import 'package:wond3rcard/src/authentication/views/authentication/otp_verification/views/pages/otp_verification_main.dart';
import 'package:wond3rcard/src/authentication/views/authentication/reset_password/views/reset_password_main.dart';
import 'package:wond3rcard/src/authentication/views/authentication/signup/views/signup_main.dart';
import 'package:wond3rcard/src/base_dashboard/views/base_dashboard.dart';
import 'package:wond3rcard/src/cards/views/pages/cards_main.dart';
import 'package:wond3rcard/src/cards/views/pages/mobile/order_physical_card.dart';
import 'package:wond3rcard/src/cards/views/pages/mobile/view_physical_card_screen.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_details.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_1.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_2.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_3.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_new_card.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_new_card_step_five.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_new_card_step_four.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_new_card_step_three.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_new_card_step_two.dart';
import 'package:wond3rcard/src/cards/views/widgets/font_widget.dart';
import 'package:wond3rcard/src/cards/views/widgets/main_card_widget.dart';
import 'package:wond3rcard/src/contact/views/pages/add_contact_page.dart';
import 'package:wond3rcard/src/contact/views/pages/connection_screen.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/connection_suggestion_screen.dart';
import 'package:wond3rcard/src/home/views/home_main.dart';
import 'package:wond3rcard/src/main_dashboard/views/main_dashboard.dart';
import 'package:wond3rcard/src/onboarding/views/get_started_main.dart';
import 'package:wond3rcard/src/onboarding/views/onboarding_fifth_screen_main.dart';
import 'package:wond3rcard/src/onboarding/views/onboarding_fourth_screen.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/get_started_onbordind_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/onboarding_first_screen_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/onboarding_fourth_screen_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/onboarding_second_screen_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/onboarding_third_screen_desktop.dart';
import 'package:wond3rcard/src/organization/views/pages/get_user_organization.dart';
import 'package:wond3rcard/src/physical_card/views/screens/order_physical_card_screen.dart';
import 'package:wond3rcard/src/physical_card/views/screens/payment_success_page.dart';
import 'package:wond3rcard/src/preview_card/views/preview_main.dart';
import 'package:wond3rcard/src/privacy_security/views/privacy_security.dart';
import 'package:wond3rcard/src/profile/views/edit_profile.dart';
import 'package:wond3rcard/src/profile/views/manage_subscription.dart';
import 'package:wond3rcard/src/profile/views/profile.dart';
import 'package:wond3rcard/src/profile/views/widgets/help_and_support.dart';
import 'package:wond3rcard/src/profile/views/widgets/q_and_a.dart';
import 'package:wond3rcard/src/profile/views/widgets/terms_and_condition.dart';
import 'package:wond3rcard/src/qr_code/views/widgets/share_card_list.dart';
import 'package:wond3rcard/src/qr_code/views/widgets/share_card_widget.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter routerDesktop = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: RouteString.getStarted,
            builder: (BuildContext context, GoRouterState state) {
              return GetStartedOnboardingScreenDesktop();
            },
          ),
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return MainDashboard(child: child);
            },
            routes: <RouteBase>[
              GoRoute(
                path: RouteString.baseDashboard,
                builder: (BuildContext context, GoRouterState state) {
                  return HomeMain();
                },
              ),
              GoRoute(
                path: RouteString.home,
                builder: (BuildContext context, GoRouterState state) {
                  return HomeMain();
                },
              ),
              GoRoute(
                path: RouteString.cardMain,
                builder: (BuildContext context, GoRouterState state) {
                  return CardsMain();
                },
              ),
              GoRoute(
                path: RouteString.shareCardLink,
                builder: (BuildContext context, GoRouterState state) {
                  return ShareCardList();
                },
              ),
              GoRoute(
                path: RouteString.connections,
                builder: (BuildContext context, GoRouterState state) {
                  return ConnectionMain();
                },
              ),
              GoRoute(
                path: RouteString.analytics,
                builder: (BuildContext context, GoRouterState state) {
                  return AnalyticsMainPage();
                },
              ),
              GoRoute(
                path: RouteString.profile,
                builder: (BuildContext context, GoRouterState state) {
                  return ProfileMainScreen();
                },
              ),
              GoRoute(
                path: RouteString.qAndA,
                builder: (BuildContext context, GoRouterState state) {
                  return const QAndA();
                },
              ),
              GoRoute(
                path: RouteString.termsAndCondition,
                builder: (BuildContext context, GoRouterState state) {
                  return const TermsAndCondition();
                },
              ),
              GoRoute(
                path: RouteString.helpAndSupport,
                builder: (BuildContext context, GoRouterState state) {
                  return const HelpAndSupport();
                },
              ),
              GoRoute(
                path: RouteString.privacySecurity,
                builder: (BuildContext context, GoRouterState state) {
                  return const PrivacySecurityMainScreen();
                },
              ),
              GoRoute(
                path: RouteString.viewPhysicalCard,
                builder: (BuildContext context, GoRouterState state) {
                  return const ViewPhysicalCardScreen();
                },
              ),
              GoRoute(
                path: RouteString.editProfile,
                builder: (BuildContext context, GoRouterState state) {
                  return const EditProfileMainScreen();
                },
              ),
              GoRoute(
                path: RouteString.memebershipSubscription,
                builder: (BuildContext context, GoRouterState state) {
                  return ManageSubscriptionMainScreen();
                },
              ),
              GoRoute(
                path: RouteString.suggestion,
                builder: (BuildContext context, GoRouterState state) {
                  return const ConnectionSuggestionScreen();
                },
              ),
              GoRoute(
                path: RouteString.addContact,
                builder: (BuildContext context, GoRouterState state) {
                  return AddContactPage();
                },
              ),
              GoRoute(
                path: '${RouteString.shareCardLink}/:index',
                builder: (BuildContext context, GoRouterState state) {
                  final index =
                      int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
                  return ShareQrWidget(index: index);
                },
              ),
              GoRoute(
                path: '/card-management',
                builder: (BuildContext context, GoRouterState state) {
                  return CardManagementAdmin();
                },
              ),
              GoRoute(
                path: '/analytics',
                builder: (BuildContext context, GoRouterState state) {
                  return AdminAnalytics();
                },
              ),
              GoRoute(
                path: '/admin-subscription',
                builder: (BuildContext context, GoRouterState state) {
                  return AdminSubscription();
                },
              ),
              GoRoute(
                path: '/security',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                },
              ),

                              GoRoute(
            path: '${RouteString.selectedCardAnalyticsUser}/:index',
            builder: (BuildContext context, GoRouterState state) {
              final index =
                  int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
              return SelectCardAnalytics(index: index);
            },
          ),
              GoRoute(
                path: RouteString.orderPhysicalCard,
                builder: (BuildContext context, GoRouterState state) {
                  return OrderPhysicalCard();
                },
              ),
              GoRoute(
                path: '${RouteString.cardDetails}/:index',
                builder: (BuildContext context, GoRouterState state) {
                  final index =
                      int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
                  return CardDetails(index: index);
                },
              ),
              GoRoute(
                path: '/payment-success',
                builder: (context, state) {
                  final trxRef = state.uri.queryParameters['trxref'];
                  final reference = state.uri.queryParameters['reference'];

                  return PaymentSuccessPage(
                    trxRef: trxRef,
                    reference: reference,
                  );
                },
              ),
              GoRoute(
                path: '/admin-manage-flag',
                builder: (BuildContext context, GoRouterState state) {
                  return OrderPhysicalCardPage();
                },
              ),
              GoRoute(
                path: '/admin-settings',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                },
              ),
              GoRoute(
                path: '/add-user',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                },
              ),
              GoRoute(
                path: RouteString.subscriptionReview,
                builder: (BuildContext context, GoRouterState state) {
                  return SubscriptionReviewAndConfirmation();
                },
              ),
              GoRoute(
                path: RouteString.suscriptionSettings,
                builder: (BuildContext context, GoRouterState state) {
                  return SubscriptionSettings();
                },
              ),
              GoRoute(
                path: RouteString.manageUserSubscription,
                builder: (BuildContext context, GoRouterState state) {
                  return ManageUserSubscription();
                },
              ),
              GoRoute(
                path: RouteString.createSubscription,
                builder: (BuildContext context, GoRouterState state) {
                  return CreateNewSubscriptionPlan();
                },
              ),
              GoRoute(
                path: RouteString.planLimitFeatures,
                builder: (BuildContext context, GoRouterState state) {
                  return SetPlanLimitsFeature();
                },
              ),
              GoRoute(
                path: RouteString.adminCreateNewUser,
                builder: (BuildContext context, GoRouterState state) {
                  return AdminCreateNewUser();
                },
              ),
              GoRoute(
                path: RouteString.adminEditUser,
                builder: (BuildContext context, GoRouterState state) {
                  return AdminEditUser();
                },
              ),
              GoRoute(
                path: RouteString.createOrganization,
                builder: (BuildContext context, GoRouterState state) {
                  return UserOrganizationsScreen();
                },
              ),
              GoRoute(
                path: RouteString.addUserAccount,
                builder: (BuildContext context, GoRouterState state) {
                  return AddUserAccount();
                },
              ),
              GoRoute(
                path: RouteString.additionalInformation,
                builder: (BuildContext context, GoRouterState state) {
                  return AdditionalInformationWidget();
                },
              ),
              GoRoute(
                path: RouteString.accountSettings,
                builder: (BuildContext context, GoRouterState state) {
                  return AccountSettings();
                },
              ),
              GoRoute(
                path: RouteString.accountReview,
                builder: (BuildContext context, GoRouterState state) {
                  return ReviewAccount();
                },
              ),
              GoRoute(
                path: RouteString.createNewCard,
                builder: (BuildContext context, GoRouterState state) {
                  return const CreateNewCard();
                },
              ),
              GoRoute(
                path: RouteString.createNewCardTwo,
                builder: (BuildContext context, GoRouterState state) {
                  return const CreateNewCardStepTwo();
                },
              ),
              GoRoute(
                path: RouteString.createNewCardThree,
                builder: (BuildContext context, GoRouterState state) {
                  return const CreateNewCardStepThree();
                },
              ),
              GoRoute(
                path: RouteString.createNewCardFour,
                builder: (BuildContext context, GoRouterState state) {
                  return const CreateNewCardStepFour();
                },
              ),
              GoRoute(
                path: RouteString.createNewCardStepFive,
                builder: (BuildContext context, GoRouterState state) {
                  return const CreateNewCardStepFive();
                },
              ),
            ],
          ),
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return AdminDashBoardScreen(child: child);
            },
            routes: <RouteBase>[
              GoRoute(
                path: RouteString.baseDashboard,
                builder: (BuildContext context, GoRouterState state) {
                  return BaseDashBoard();
                },
              ),
              GoRoute(
                path: '/admin-dashboard-desktop-view',
                builder: (BuildContext context, GoRouterState state) {
                  return AdminDashboardDesktopView();
                },
              ),
              GoRoute(
                path: '/user-management',
                builder: (BuildContext context, GoRouterState state) {
                  return AdminUserManagement();
                },
              ),
              GoRoute(
                path: '/card-management',
                builder: (BuildContext context, GoRouterState state) {
                  return CardManagementAdmin();
                },
              ),
              GoRoute(
                path: '/analytics',
                builder: (BuildContext context, GoRouterState state) {
                  return AdminAnalytics();
                },
              ),
              GoRoute(
                path: '/admin-subscription',
                builder: (BuildContext context, GoRouterState state) {
                  return AdminSubscription();
                },
              ),
              GoRoute(
                path: '/security',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                },
              ),
              GoRoute(
                path: '/payment-success',
                builder: (context, state) {
                  final trxRef = state.uri.queryParameters['trxref'];
                  final reference = state.uri.queryParameters['reference'];

                  return PaymentSuccessPage(
                    trxRef: trxRef,
                    reference: reference,
                  );
                },
              ),
              GoRoute(
                path: '/admin-manage-flag',
                builder: (BuildContext context, GoRouterState state) {
                  return OrderPhysicalCardPage();
                },
              ),
              GoRoute(
                path: '/admin-settings',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                },
              ),
              GoRoute(
                path: '/add-user',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                },
              ),
              GoRoute(
                path: RouteString.subscriptionReview,
                builder: (BuildContext context, GoRouterState state) {
                  return SubscriptionReviewAndConfirmation();
                },
              ),
              GoRoute(
                path: RouteString.suscriptionSettings,
                builder: (BuildContext context, GoRouterState state) {
                  return SubscriptionSettings();
                },
              ),
              GoRoute(
                path: RouteString.manageUserSubscription,
                builder: (BuildContext context, GoRouterState state) {
                  return ManageUserSubscription();
                },
              ),
              GoRoute(
                path: RouteString.createSubscription,
                builder: (BuildContext context, GoRouterState state) {
                  return CreateNewSubscriptionPlan();
                },
              ),
              GoRoute(
                path: RouteString.planLimitFeatures,
                builder: (BuildContext context, GoRouterState state) {
                  return SetPlanLimitsFeature();
                },
              ),
              GoRoute(
                path: RouteString.adminCreateNewUser,
                builder: (BuildContext context, GoRouterState state) {
                  return AdminCreateNewUser();
                },
              ),
              GoRoute(
                path: RouteString.adminEditUser,
                builder: (BuildContext context, GoRouterState state) {
                  return AdminEditUser();
                },
              ),
              GoRoute(
                path: RouteString.createOrganization,
                builder: (BuildContext context, GoRouterState state) {
                  return UserOrganizationsScreen();
                },
              ),
              GoRoute(
                path: RouteString.addUserAccount,
                builder: (BuildContext context, GoRouterState state) {
                  return AddUserAccount();
                },
              ),
              GoRoute(
                path: RouteString.additionalInformation,
                builder: (BuildContext context, GoRouterState state) {
                  return AdditionalInformationWidget();
                },
              ),
              GoRoute(
                path: RouteString.accountSettings,
                builder: (BuildContext context, GoRouterState state) {
                  return AccountSettings();
                },
              ),
              GoRoute(
                path: RouteString.accountReview,
                builder: (BuildContext context, GoRouterState state) {
                  return ReviewAccount();
                },
              ),
            ],
          ),
          GoRoute(
            path: RouteString.baseDashboard,
            builder: (BuildContext context, GoRouterState state) {
              return BaseDashBoard();
            },
          ),
          GoRoute(
            path: '/admin-dashboard-desktop-view',
            builder: (BuildContext context, GoRouterState state) {
              return AdminDashboardDesktopView();
            },
          ),
          GoRoute(
            path: '/user-management',
            builder: (BuildContext context, GoRouterState state) {
              return AdminUserManagement();
            },
          ),
          GoRoute(
            path: '/analytics',
            builder: (BuildContext context, GoRouterState state) {
              return Container();
            },
          ),
          GoRoute(
            path: '/security',
            builder: (BuildContext context, GoRouterState state) {
              return Container();
            },
          ),
          GoRoute(
            path: '/admin-manage-flag',
            builder: (BuildContext context, GoRouterState state) {
              return OrderPhysicalCardPage();
              // Container();
            },
          ),
          GoRoute(
            path: '/admin-settings',
            builder: (BuildContext context, GoRouterState state) {
              return Container();
            },
          ),
          GoRoute(
            path: '/add-user',
            builder: (BuildContext context, GoRouterState state) {
              return Container();
            },
          ),
          GoRoute(
            path: RouteString.firstScreenDesktop,
            builder: (BuildContext context, GoRouterState state) {
              return const OnboardingFirstScreenDesktop();
            },
          ),
          GoRoute(
            path: RouteString.secondScreenDesktop,
            builder: (BuildContext context, GoRouterState state) {
              return const OnboardingSecondScreenDesktop();
            },
          ),
          GoRoute(
            path: RouteString.thirdScreenDesktop,
            builder: (BuildContext context, GoRouterState state) {
              return const OnboardingThirdScreenDesktop();
            },
          ),
          GoRoute(
            path: RouteString.fourthScreenDesktop,
            builder: (BuildContext context, GoRouterState state) {
              return const OnboardingFourthScreenDesktop();
            },
          ),
          GoRoute(
            path: RouteString.fourthScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const OnboardingFourthScreenMain();
            },
          ),
          GoRoute(
            path: RouteString.fifthScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const OnboardingFifthScreenMain();
            },
          ),
          GoRoute(
            path: RouteString.previewCard,
            builder: (BuildContext context, GoRouterState state) {
              return const PreviewCardMainScreen();
            },
          ),
          GoRoute(
            path: RouteString.logIn,
            builder: (BuildContext context, GoRouterState state) {
              return const LogInMain();
            },
          ),
          GoRoute(
            path: RouteString.signup,
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpMain();
            },
          ),
          GoRoute(
            path: RouteString.otpVerification,
            builder: (BuildContext context, GoRouterState state) {
              return const OtpVerification();
            },
          ),
          GoRoute(
            path: RouteString.resetPassword,
            builder: (BuildContext context, GoRouterState state) {
              return const ResetPasswordMain();
            },
          ),
          GoRoute(
            path: RouteString.changePassword,
            builder: (BuildContext context, GoRouterState state) {
              return const ChangePasswordMain();
            },
          ),
          GoRoute(
            path: RouteString.forgetPasswordOtpVerification,
            builder: (BuildContext context, GoRouterState state) {
              return const ForgotPasswordOtpVerification();
            },
          ),
          GoRoute(
            path: RouteString.verifyPasswordOtp,
            builder: (BuildContext context, GoRouterState state) {
              return const ResetPasswordMain();
            },
          ),
          GoRoute(
            path: RouteString.home,
            builder: (BuildContext context, GoRouterState state) {
              return const HomeMain();
            },
          ),
          GoRoute(
            path: RouteString.mainDashboard,
            builder: (BuildContext context, GoRouterState state) {
              return const MainDashboard();
            },
          ),
          GoRoute(
            path: RouteString.font,
            builder: (BuildContext context, GoRouterState state) {
              return const FontCustomizationCard();
            },
          ),
          GoRoute(
            path: RouteString.cardLayout,
            builder: (BuildContext context, GoRouterState state) {
              return const CardLayoutSelector();
            },
          ),
          GoRoute(
            path: RouteString.cardLayout1,
            builder: (BuildContext context, GoRouterState state) {
              return CardLayout1(
                onLayoutSelected: (String newLayout) {
                  GoRouter.of(context)
                      .go(RouteString.cardLayout1, extra: newLayout);
                },
              );
            },
          ),
          GoRoute(
            path: RouteString.cardLayout2,
            builder: (BuildContext context, GoRouterState state) {
              return CardLayout2(
                onLayoutSelected: (String newLayout) {
                  GoRouter.of(context)
                      .go(RouteString.cardLayout2, extra: newLayout);
                },
              );
            },
          ),
          GoRoute(
            path: RouteString.cardLayout3,
            builder: (BuildContext context, GoRouterState state) {
              return CardLayout3(
                onLayoutSelected: (String newLayout) {
                  GoRouter.of(context)
                      .go(RouteString.cardLayout3, extra: newLayout);
                },
              );
            },
          ),
          GoRoute(
            path: RouteString.createNewCard,
            builder: (BuildContext context, GoRouterState state) {
              return const CreateNewCard();
            },
          ),
          GoRoute(
            path: RouteString.createNewCardTwo,
            builder: (BuildContext context, GoRouterState state) {
              return const CreateNewCardStepTwo();
            },
          ),
          GoRoute(
            path: RouteString.createNewCardThree,
            builder: (BuildContext context, GoRouterState state) {
              return const CreateNewCardStepThree();
            },
          ),
          GoRoute(
            path: RouteString.createNewCardFour,
            builder: (BuildContext context, GoRouterState state) {
              return const CreateNewCardStepFour();
            },
          ),
          GoRoute(
            path: RouteString.createNewCardStepFive,
            builder: (BuildContext context, GoRouterState state) {
              return const CreateNewCardStepFive();
            },
          ),
          GoRoute(
            path: RouteString.cardMain,
            builder: (BuildContext context, GoRouterState state) {
              return const CardsMain();
            },
          ),
          GoRoute(
            path: '${RouteString.shareCardLink}/:index',
            builder: (BuildContext context, GoRouterState state) {
              final index =
                  int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
              return ShareQrWidget(index: index);
            },
          ),
          GoRoute(
            path: '${RouteString.selectedCardAnalytics}/:index',
            builder: (BuildContext context, GoRouterState state) {
              final index =
                  int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
              return SelectedCardAnalytics(index: index);
            },
          ),
          GoRoute(
            path: RouteString.mainCard,
            builder: (BuildContext context, GoRouterState state) {
              return const MainCardWidget();
            },
          ),
          GoRoute(
            path: '${RouteString.cardDetails}/:index',
            builder: (BuildContext context, GoRouterState state) {
              final index =
                  int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
              return CardDetails(index: index);
            },
          ),
          GoRoute(
            path: RouteString.profile,
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileMainScreen();
            },
          ),
        ]),
  ],
);
