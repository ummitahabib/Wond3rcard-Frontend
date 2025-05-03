import 'package:flutter/material.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/admin_analytics.dart';
import 'package:wond3rcard/src/utils/util.dart';

class MostViewCards extends StatefulWidget {
  const MostViewCards({super.key});

  @override
  State<MostViewCards> createState() => _MostViewCardsState();
}

class _MostViewCardsState extends State<MostViewCards> {
  final List<SubscriptionModel> subscriptions = [
    SubscriptionModel(planName: 'Premium', quantity: 300, percentage: 30),
    SubscriptionModel(planName: 'Basic', quantity: 600, percentage: 60),
    SubscriptionModel(planName: 'Business', quantity: 400, percentage: 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: reusableContainerDeco(),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "5 Most Viewed Cards",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 400,
            height: 400,
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];

                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x0F000000),
                            blurRadius: 48,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  subscription.planName,
                                  style: WonderCardTypography.boldTextBody(
                                    color: Color(0xff1E2022),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${subscription.quantity}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff77838F),
                                        )),
                                    Text('%${subscription.percentage}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff6D41CA),
                                        )),
                                  ],
                                )
                              ]),
                          SizedBox(
                            height: 18,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 519.84,
                                height: 8.33,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                child: Container(
                                  width:
                                      519.84 * (subscription.percentage / 100),
                                  height: 8.33,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF402577),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionModel {
  final String planName;
  final int quantity;
  final double percentage;

  SubscriptionModel({
    required this.planName,
    required this.quantity,
    required this.percentage,
  });
}
