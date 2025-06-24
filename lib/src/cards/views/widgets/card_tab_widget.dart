import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/pages/mobile/physical_card_screen.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_list_widget.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

import 'package:shimmer/shimmer.dart';

class CardsTabWidget extends StatefulWidget {
  final CardNotifier cardController;
  const CardsTabWidget({super.key, required this.cardController});
  @override
  _CardsTabWidgetState createState() => _CardsTabWidgetState();
}

class _CardsTabWidgetState extends State<CardsTabWidget> {
  bool isDigitalSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isDigitalSelected = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      isDigitalSelected ? AppColors.primaryShade : Colors.white,
                  border: Border.all(color: AppColors.primaryShade),
                ),
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(12),
                child: Row(
                  children: [
                    HeroIcon(
                      HeroIcons.user,
                      color: isDigitalSelected
                          ? Colors.white
                          : AppColors.primaryShade,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Digital Cards',
                      style: TextStyle(
                        color: isDigitalSelected
                            ? Colors.white
                            : AppColors.primaryShade,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isDigitalSelected = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      isDigitalSelected ? Colors.white : AppColors.primaryShade,
                  border: Border.all(color: AppColors.primaryShade),
                ),
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(12),
                child: Row(
                  children: [
                    HeroIcon(
                      HeroIcons.user,
                      color: isDigitalSelected
                          ? AppColors.primaryShade
                          : Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Physical Card',
                      style: TextStyle(
                        color: isDigitalSelected
                            ? AppColors.primaryShade
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        isDigitalSelected
            ? widget.cardController.loading
                ? _buildShimmer()
                : GestureDetector(
                    onTap: () {},
                    child:
                        CardListWidget(cardController: widget.cardController),
                  )
            : PhysicalCardWidget(),
      ],
    );
  }

  Widget _buildShimmer() {
    // Adjust the shimmer layout to match your CardListWidget skeleton
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: List.generate(
            2,
            (index) => Container(
              margin: EdgeInsets.only(bottom: 16),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
