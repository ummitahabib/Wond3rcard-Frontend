import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_widgets.dart';
import 'package:wond3rcard/src/utils/decoration_box.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CardOptions extends StatefulHookConsumerWidget {
  const CardOptions({super.key, required this.index});
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardOptionsState();
}

class _CardOptionsState extends ConsumerState<CardOptions> {
  @override
  Widget build(BuildContext context) {
    final cardController = ref.watch(cardProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          Future.delayed(Duration.zero, () async {
            await ref.read(cardProvider).getAUsersCard(context, '');
          });
        });
        return null;
      },
      [],
    );

    return Container(
      padding: EdgeInsets.all(8),
      decoration: DecorationBox.cardBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Text(
            cardController.getCardsResponse?.payload?.cards?[widget.index]
                    .cardName ??
                'Card',
            style: WonderCardTypography.boldTextH5(),
          ),),
          SizedBox(height: 10),
          cardRow(
            onTap: () {},
            text: editCard,
            icon: HeroIcons.pencilSquare,
          ),
          cardRow(
            onTap: () {},
            text: 'Duplicated Card',
            icon: HeroIcons.paperAirplane,
          ),
          cardRow(
            onTap: () {},
            text: shareCard,
           icon: HeroIcons.share
          ),
          cardRow(
            onTap: () {},
            text: 'Order Physical Card',
             icon: HeroIcons.shoppingCart,
          ),
          cardRow(
            onTap: () {},
            text: deleteCard,
            icon: HeroIcons.trash,
          ),
        ],
      ),
    );
  }
}
