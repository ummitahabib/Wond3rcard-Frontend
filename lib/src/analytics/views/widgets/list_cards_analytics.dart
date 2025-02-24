import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

class ListOfCardsAnalytics extends HookConsumerWidget {
  const ListOfCardsAnalytics({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = useState<String>('All');

    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildFilterRow(selectedFilter),
        ),
      ],
    ));
  }

  Widget buildFilterRow(ValueNotifier<String> selectedFilter) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cardsfilterOptions.map((filter) {
          final isSelected = selectedFilter.value == filter.label;
          return GestureDetector(
            onTap: () {
              selectedFilter.value = filter.label;
              filter.onTap(); // Trigger the associated action
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryShade
                    : AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(100),
                border: isSelected
                    ? Border.all(color: AppColors.primaryShade, width: 2)
                    : Border.all(color: AppColors.grayScale300),
              ),
              child: Text(
                filter.label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.defaultWhite
                      : AppColors.grayScale700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
