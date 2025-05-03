import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/controller/create_subscription_controller.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_get_subscription_model.dart';
import 'package:wond3rcard/src/utils/util.dart';

class SubscriptionPlanTable extends ConsumerWidget {
  const SubscriptionPlanTable({Key? key}) : super(key: key);

  void _deleteSubscription(BuildContext context, WidgetRef ref, String id,
      List<GetSubscriptionTier> tiers) {
    if (tiers.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cannot delete the only subscription tier!"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    String newTierId = tiers.firstWhere((tier) => tier.id != id).id;

    ref
        .read(deleteSubscriptionProvider.notifier)
        .deleteSubscription(id, newTierId)
        .then((_) {
      ref.refresh(getSubscriptionTiersProvider);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Subscription deleted successfully!"),
        backgroundColor: Colors.green,
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${error.toString()}"),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionState = ref.watch(getSubscriptionTiersProvider);
    final deleteState = ref.watch(deleteSubscriptionProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: subscriptionState.when(
        data: (tiers) => LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 3.63,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          'Name',
                          style: WonderCardTypography.regularTextTitle1(
                            fontSize: 19,
                            color: Color(0xff3A3541),
                          ),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        'Price',
                        style: WonderCardTypography.regularTextTitle1(
                          fontSize: 19,
                          color: Color(0xff3A3541),
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'Feature',
                        style: WonderCardTypography.regularTextTitle1(
                          fontSize: 19,
                          color: Color(0xff3A3541),
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'Active Users',
                        style: WonderCardTypography.regularTextTitle1(
                          fontSize: 19,
                          color: Color(0xff3A3541),
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'Action',
                        style: WonderCardTypography.regularTextTitle1(
                          fontSize: 19,
                          color: Color(0xff3A3541),
                        ),
                      )),
                    ],
                    rows: tiers.map((tier) {
                      return DataRow(cells: [
                        DataCell(
                          Text(
                            tier.name,
                            style: _textStyle(
                              color: Color(0xff344767),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            'Free',
                            style: _textStyle(),
                          ),
                        ),
                        DataCell(Text(
                          'Limited',
                          style: _textStyle(),
                        )),
                        DataCell(Text(
                          '200,002',
                          style: _textStyle(),
                        )),
                        DataCell(
                          deleteState.isLoading
                              ? const CircularProgressIndicator()
                              : Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.grayScale300),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const HeroIcon(
                                          HeroIcons.pencilSquare,
                                          color: AppColors.grayScale400,
                                        ),
                                        onPressed: () => _deleteSubscription(
                                            context, ref, tier.id, tiers),
                                      ),
                                      IconButton(
                                        icon: const HeroIcon(HeroIcons.trash,
                                            color: AppColors.redDisable),
                                        onPressed: () => _deleteSubscription(
                                            context, ref, tier.id, tiers),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Error: $error")),
      ),
    );
  }

  TextStyle _textStyle({FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontFamily: 'Barlow',
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: 14,
      color: color ?? Color(0xff7B809A),
    );
  }
}
