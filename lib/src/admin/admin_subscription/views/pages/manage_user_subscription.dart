import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/admin_dashboard_page_header.dart';
import 'package:wond3rcard/src/admin/common/widgets/dynamic_date_time.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';


// ManageUserSubscription Page
class ManageUserSubscription extends ConsumerWidget {
  const ManageUserSubscription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State to track selected subscription filter
    final selectedFilter = ValueNotifier<String>('All');

    // Example billing data (Replace with your actual data)
    final List<Map<String, dynamic>> subscriptionData = [
      {
        'userName': 'John Doe',
        'planType': 'Premium',
        'amount': 49.99,
        'paymentStatus': 'Completed',
           'expireyDate': '23/10/2025'
      },
      {
        'userName': 'Jane Smith',
        'planType': 'Basic',
        'amount': 19.99,
        'paymentStatus': 'Pending',
           'expireyDate': '23/10/2025'
      },
      {
        'userName': 'Alex Johnson',
        'planType': 'Business',
        'amount': 99.99,
        'paymentStatus': 'Failed',
           'expireyDate': '23/10/2025'
      },
      {
        'userName': 'Alice Brown',
        'planType': 'Premium',
        'amount': 59.99,
        'paymentStatus': 'Completed',
        'expireyDate': '23/10/2025'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "User Subscription",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          WonderCardButton(
            textColor: AppColors.defaultWhite,
            onPressed: () {},
            leadingIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.settings, color: Colors.white),
            ),
            text:'Payment Settings',
           
          ),
          const SizedBox(width: 15),
          Icon(Icons.notification_add, color: AppColors.primaryShade),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Monitor and manage all User   Subscription in the system',
              style: TextStyle(
                color: Color(0xff3A3541),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),


            ValueListenableBuilder<String>(
              valueListenable: selectedFilter,
              builder: (context, value, _) {
                return Container(
                  padding: EdgeInsets.all(30),
                   decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(8), // Border radius
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000), // #00000026
              offset: Offset(0, 0), // No horizontal/vertical offset
              blurRadius: 4, // Blur radius
              spreadRadius: 0, // Spread radius
            ),
          ],
        ),
                  child: Row(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['All', 'Basic', 'Premium', 'Business']
                            .map((type) => 
                            
                            WonderCardButton(
                               
                                  onPressed: () => selectedFilter.value = type,
                                  leadingIcon: const Icon(Icons.people),
                                  text: type,
                                      backgroundColor: value == type
                                        ? AppColors.primaryShade
                                        : Colors.white,
                      
                                        textColor:  value == type
                                        ? AppColors.defaultWhite
                                        : AppColors.grayScale600,
                                 
                                )
                                
                                )
                            .toList(),
                      ),
                  DynamicDateText(),
                Spacer(),
                ResponsiveSearchTextField(),
                HeroIcon(HeroIcons.document),
                   
                    ],
                  ),
                );
              },
            ),
           
            const SizedBox(height: 20),

            const Text(
              'Payment Transactions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Filtered Data Table
            ValueListenableBuilder<String>(
              valueListenable: selectedFilter,
              builder: (context, value, _) {
                final filteredBilling = subscriptionData.where((billing) {
                  if (value == 'All') return true;
                  return billing['planType'] == value;
                }).toList();

                return DataTable(
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(label: Text('User')),
                    DataColumn(label: Text('Plan')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Payment Status')),
                    DataColumn(label: Text('Renewal Date')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredBilling.map((billing) {
                    return DataRow(cells: [
                      DataCell(Text(billing['userName'])),
                      DataCell(Text(billing['planType'])),
                      DataCell(Text('\$${billing['amount']}')),
                      DataCell(
                        Row(
                          children: [
                            Icon(Icons.circle,
                                size: 12,
                                color: getStatusColor(
                                    billing['paymentStatus'])),
                            const SizedBox(width: 8),
                            Text(billing['paymentStatus']),
                          ],
                        ),
                      ),
                       DataCell(Text(billing['expireyDate'])),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            // Handle actions (e.g., view details, refund)
                          },
                        ),
                      ),
                    ]);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get payment status colors
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
