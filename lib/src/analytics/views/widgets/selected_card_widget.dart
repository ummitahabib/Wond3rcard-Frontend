import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/admin_dashboard_page_header.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class SelectedCardWidget extends HookConsumerWidget {
  const SelectedCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.read(cardProvider);
    final profileController = ref.watch(profileProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (cardController.getCardsResponse == null) {
          await cardController.getAllUsersCard();
          await profileController.getProfile(context);
        }
      });
      return null;
    }, []);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Text(
              'Today',
              style: TextStyle(
                fontFamily: 'Barlow',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ResponsiveSearchTextField(),
          SizedBox(
            height: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  cardController.getCardsResponse?.payload?.cards?.length ?? 0,
              itemBuilder: (context, index) {
                return listOfAllCards(context, cardController, index);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector listOfAllCards(
      BuildContext context, CardNotifier cardController, int index) {
    return GestureDetector(
      onTap: () {
        context.go('${RouteString.selectedCardAnalyticsUser}/$index');
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.defaultWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryShade,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned.fill(
                  child: ClipOval(
                    child: Image.network(
                      ImageAssets.bgBlur,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      cardController.getCardsResponse?.payload?.cards?[index]
                              .cardName ??
                          emptyString,
                      style: WonderCardTypography.boldTextH5(
                        fontSize: 23,
                        color: AppColors.grayScale700,
                      )),
                  Text(
                      '${cardController.getCardsResponse?.payload?.cards?[index].firstName ?? emptyString} ${cardController.getCardsResponse?.payload?.cards?[index].lastName ?? emptyString}',
                      style: WonderCardTypography.regularTextTitle2(
                          fontSize: 16, color: AppColors.grayScale600)),
                  personalProfileTag(
                    text: cardController.getCardsResponse?.payload
                            ?.cards?[index].cardType ??
                        emptyString,
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.grayScale600,
            )
          ],
        ),
      ),
    );
  }
}
