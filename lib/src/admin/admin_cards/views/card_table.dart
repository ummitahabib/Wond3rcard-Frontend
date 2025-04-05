import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_cards/data/controller/admin_card_controller.dart';
import 'package:wond3rcard/src/admin/admin_cards/data/model/admin_card_model.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/dashboard_users_and_recently_joined.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/recently_created_main_widget.dart';
import 'package:wond3rcard/src/admin/common/widgets/dynamic_date_time.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/admin_dashboard_page_header.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/user_type_filter.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';


class CardManagementAdmin extends ConsumerWidget {
  const CardManagementAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
              Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: ManageUserTypeAndRecentlyJoinedWidget()),
                    SizedBox(width: 15,),
                  Expanded(
                    flex: 3,
                    child: RecentlyCreatedMainWidget()),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: CardTableScreen(),
            ),
          ],
        ),
      ),
    );
  }
}


// CardTableScreen Class
class CardTableScreen extends ConsumerWidget {
  const CardTableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State to track selected subscription filter
    final selectedFilter = ValueNotifier<String>('All');

    // Watch card state from the controller
    final cardState = ref.watch(cardControllerProvider);

    return cardState.when(
      data: (cards) {
        if (cards.isEmpty) {
          return const Center(child: Text("No cards available."));
        }

        return Column(
          children: [
            // Subscription Filter and Search Bar
            ValueListenableBuilder<String>(
              valueListenable: selectedFilter,
              builder: (context, value, _) {
                return Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        offset: Offset(0, 0),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Subscription Filter Buttons
                      Row(
                        // this will be base on card type
                        children: ['All', 'personal', 'Premium', 'Business']
                            .map((type) => WonderCardButton(
                                  onPressed: () => selectedFilter.value = type,
                                  leadingIcon: const Icon(Icons.people),
                                  text: type,
                                  backgroundColor: value == type
                                      ? AppColors.primaryShade
                                      : Colors.white,
                                  textColor: value == type
                                      ? AppColors.defaultWhite
                                      : AppColors.grayScale600,
                                ))
                            .toList(),
                      ),

                      // Dynamic Date Display (Assuming it shows the current date range)
                      const DynamicDateText(),

                      const Spacer(),

                      // Search Field (Assuming it's for card name, owner, etc.)
                      const ResponsiveSearchTextField(),

                      // Document Icon
                      const HeroIcon(HeroIcons.document),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            // Filtered Data Table
            ValueListenableBuilder<String>(
              valueListenable: selectedFilter,
              builder: (context, value, _) {
                // Filter cards based on the selected subscription type
                final filteredCards = _filterCards(cards, value);
                return _buildTable(filteredCards);
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: ${e.toString()}")),
    );
  }

  /// Helper method to filter cards by subscription type
  List<CardModel> _filterCards(List<CardModel> cards, String filter) {
    if (filter == 'All') return cards; // No filter applied
    return cards.where((card) => card.cardType == filter).toList();
  }

  /// DataTable builder
  Widget _buildTable(List<CardModel> cards) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 800),
        child: DataTable(
          border: TableBorder.all(color: Colors.grey[300]!),
          columns: const [
            DataColumn(
                label: Text('Card Profile',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Card Name',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Email',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Phone',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Owner',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Views',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Shares',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Subscription',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Status',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: cards.map((card) => _buildDataRow(card)).toList(),
        ),
      ),
    );
  }

  /// Builds a DataRow for each card
  DataRow _buildDataRow(CardModel card) {
    return DataRow(cells: [
      // Card Profile (Image or Placeholder)
      DataCell(
        card.cardPictureUrl != null
            ? Image.network(
                card.cardPictureUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              )
            : const Icon(Icons.image_not_supported),
      ),

      // Card Details
      DataCell(Text(card.cardName ?? 'N/A')),
      DataCell(Text(card.contactInfo.email ?? 'N/A')),
      DataCell(Text(card.contactInfo.phone ?? 'N/A')),
      DataCell(Text(card.ownerId ?? 'N/A')),
      DataCell(Text(card.sharedWith.toString() ?? '0')), 
       DataCell(Text(card.sharedWith.toString() ?? '0')), 
      DataCell(Text(card.cardType ?? 'N/A')),
      DataCell(Text(card.active ? 'Active' : 'Inactive')),
    ]);
  }
}











class AdminDashboardCardListWidget extends HookConsumerWidget {
  const AdminDashboardCardListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
       
      final cardState = ref.watch(cardControllerProvider);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [

          
        
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 31),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Cards List ',
                    style: TextStyle(
                      color: AppColors.grayScale,
                      fontFamily: 'Barlow',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                     TextSpan(
                        text: cardState.when(
                          data: (cards) => '(${cards.length})', 
                          loading: () => '(...)', 
                          error: (_, __) => '(Error)', 
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    UserTypeFilter(),
                    SizedBox(width: 10),
                    Text('3rd January, 2025',
                        style: TextStyle(color: Color(0xff707070))),
                    Spacer(),
                    ResponsiveSearchTextField(),
                    HeroIcon(HeroIcons.document),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
