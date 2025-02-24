import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/shared/data/controller/shared_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/google_map.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

WonderCardButton closeReviewButton() {
  return WonderCardButton(
    onPressed: () {},
    text: 'Close Preview',
    backgroundColor: AppColors.primaryShade,
    borderRadius: BorderRadius.circular(58),
    buttonWidth: 230,
  );
}

WonderCardButton exchangeContactButton() {
  return WonderCardButton(
    onPressed: () {},
    text: 'Exchange Contact',
    backgroundColor: AppColors.primaryShade,
    borderRadius: BorderRadius.circular(10),
    buttonWidth: 158,
  );
}

WonderCardButton saveContactButton2() {
  return WonderCardButton(
    onPressed: () {},
    text: 'Save contact',
    backgroundColor: AppColors.primaryShade,
    borderRadius: BorderRadius.circular(10),
    buttonWidth: 158,
  );
}

class CustomAddress extends StatefulHookConsumerWidget {
  const CustomAddress({
    super.key,
    this.addressText,
    this.textEditingController,
  });

  final String? addressText;
  final TextEditingController? textEditingController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomAddressState();
}

class _CustomAddressState extends ConsumerState<CustomAddress> {
  @override
  Widget build(BuildContext context) {
    final shared = ref.watch(sharedProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomTextField(
            onTap: () async {
              final selectedAddress = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GoogleMapScreen()),
              );
              if (selectedAddress != null) {
                setState(() {
                  shared.address = selectedAddress;
                });
              }
            },
            hintText: widget.addressText ?? 'Address',
            text: 'Address',
            //shared.address ?? 'Tap to select an address',
            borderColor: AppColors.grayScale,
            borderRadius: 8,
            fillColor: AppColors.defaultWhite,
            textEditingController: widget.textEditingController,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(SpacingConstants.size10),
          decoration: BoxDecoration(
            color: AppColors.primaryShade,
            borderRadius: BorderRadius.circular(100),
          ),
          width: SpacingConstants.size45,
          height: SpacingConstants.size45,
          child: const HeroIcon(
            HeroIcons.map,
            color: AppColors.defaultWhite,
            size: SpacingConstants.size15,
          ),
        ),
      ],
    );
  }
}
