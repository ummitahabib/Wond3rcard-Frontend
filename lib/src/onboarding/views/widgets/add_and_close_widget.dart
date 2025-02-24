import 'package:flutter/material.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/plus_icon.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class AddAndCloseWidget extends StatelessWidget {
  const AddAndCloseWidget({
    super.key,
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return _addAndCloseMethod();
  }

  Container _addAndCloseMethod() {
    return Container(
      width: SpacingConstants.size80,
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(SpacingConstants.size100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(SpacingConstants.size10),
        child: Row(
          children: [
            isExpanded ? const SizedBox() : const PlusIcon(),
            Text(
              isExpanded ? closeText : addText,
              style: WonderCardTypography.boldTextTitle2(
                color: AppColors.grayScale500,
                fontSize: SpacingConstants.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
