import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/data/controller/card_template_controller.dart';
import 'package:wond3rcard/src/cards/data/controller/order_physical_card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/billing_summary.dart';
import 'package:wond3rcard/src/cards/views/widgets/cards_template.dart';
import 'package:wond3rcard/src/cards/views/widgets/list_of_dropdown.dart';
import 'package:wond3rcard/src/physical_card/data/controller/order_physical_card_controller.dart';
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:file_picker/file_picker.dart';

class OrderPhysicalCard extends HookConsumerWidget {
  const OrderPhysicalCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState<int>(0);
    final region = useState<String>('nigeria');
    final addressController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final cardController = ref.read(cardProvider);
        final profileController = ref.read(profileProvider);
        final cardListController =
            ref.read(physicalCardListControllerProvider.notifier);
        if (cardController.getCardsResponse == null) {
          await cardController.getAllUsersCard();
          await profileController.getProfile(context);
          await cardListController.getPhysicalCardsByUserId(
            profileController.profileData?.payload.user.id ?? '',
          );
        }
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Physical Card',
          style: WonderCardTypography.boldTextH5(
            fontSize: 23,
            color: AppColors.grayScale,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            isDesktop(context)
                ? context.go(RouteString.viewPhysicalCard)
                : context.go(RouteString.mainDashboard);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.grayScale,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: isDesktop(context)
            ? _orderCardDesktop(
                context, selectedIndex, region, addressController, formKey)
            : _orderCard(context, ref, selectedIndex, region, addressController,
                formKey),
      ),
    );
  }

  Widget _orderCardDesktop(
    BuildContext context,
    ValueNotifier<int> selectedIndex,
    ValueNotifier<String> region,
    TextEditingController addressController,
    GlobalKey<FormState> formKey,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const OrderPhysicalCardSection(),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const ChooseAndUploadWidget(),
                const SizedBox(height: 10),
                _ShippingAddressAndOrderForm(
                  selectedIndex: selectedIndex,
                  region: region,
                  addressController: addressController,
                  formKey: formKey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderCard(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<int> selectedIndex,
    ValueNotifier<String> region,
    TextEditingController addressController,
    GlobalKey<FormState> formKey,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OrderPhysicalCardSection(),
        const SizedBox(height: 10),
        _ShippingAddressAndOrderForm(
          selectedIndex: selectedIndex,
          region: region,
          addressController: addressController,
          formKey: formKey,
        ),
      ],
    );
  }
}

class _ShippingAddressAndOrderForm extends HookConsumerWidget {
  final ValueNotifier<int> selectedIndex;
  final ValueNotifier<String> region;
  final TextEditingController addressController;
  final GlobalKey<FormState> formKey;

  const _ShippingAddressAndOrderForm({
    required this.selectedIndex,
    required this.region,
    required this.addressController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileProvider);
    final cardState = ref.watch(physicalCardProvider);
    final controller = ref.read(physicalCardProvider.notifier);
    final selectedTemplate = cardState.selectedTemplate;
    final quantity = useState<int>(cardState.quantity);
    final pricePerItem = selectedTemplate?.priceNaira ?? 0;
    final total = quantity.value * pricePerItem;
    final cardList = ref.watch(physicalCardListControllerProvider).value ?? [];

    return Form(
      key: formKey,
      child: Column(
        children: [
          // Address input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Shipping Address',
                border: OutlineInputBorder(),
              ),
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'Enter address' : null,
              maxLines: 2,
            ),
          ),
          // Region dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonFormField<String>(
              value: region.value,
              items: const [
                DropdownMenuItem(value: "nigeria", child: Text("Nigeria")),
                DropdownMenuItem(value: "other", child: Text("Other")),
              ],
              onChanged: (val) => region.value = val!,
              decoration: const InputDecoration(labelText: "Region"),
            ),
          ),
          // Quantity controls
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Text(
                  'Quantity',
                  style: WonderCardTypography.boldTextTitle2(
                    color: const Color(0xff414651),
                    fontSize: 12,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addSubtractButton(
                      '-',
                      () {
                        if (quantity.value > 1) {
                          quantity.value--;
                          controller.setQuantity(quantity.value);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('${quantity.value}',
                          style: const TextStyle(fontSize: 16)),
                    ),
                    addSubtractButton(
                      '+',
                      () {
                        quantity.value++;
                        controller.setQuantity(quantity.value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Total price
          Container(
            height: 51,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEFEFEF)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                region.value == "nigeria"
                    ? "₦${total.toStringAsFixed(0)}"
                    : "\$${total.toStringAsFixed(0)}",
                style: WonderCardTypography.regularTextTitle1(
                  fontSize: 19,
                  color: const Color(0xff212121),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Review Order button
          WonderCardButton(
            onPressed: () {
              final controllerCard =
                  ref.read(orderPhysicalCardControllerProvider.notifier);
              if (formKey.currentState!.validate()) {
                controllerCard.createOrderAndPay(
                  userId:
                      profileController.profileData?.payload.profile.id ?? '',
                  physicalCardId: cardList.isNotEmpty
                      ? cardList[selectedIndex.value].id
                      : '',
                  cardTemplateId: selectedTemplate?.id ?? '',
                  quantity: quantity.value,
                  region: region.value,
                  address: addressController.text,
                  context: context,
                );
              }
            },
            text: 'Pay Now',
            backgroundColor: AppColors.primaryShade,
            textColor: AppColors.defaultWhite,
          ),
          const SizedBox(height: 10),
          WonderCardButton(
            textColor: AppColors.primaryShade,
            onPressed: () {},
            text: 'Cancel Order',
            backgroundColor: AppColors.defaultWhite,
          ),
        ],
      ),
    );
  }
}

class ChooseAndUploadWidget extends StatefulHookConsumerWidget {
  const ChooseAndUploadWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChooseAndUploadWidgetState();
}

class _ChooseAndUploadWidgetState extends ConsumerState<ChooseAndUploadWidget> {
  Future<void> _pickImage() async {
    final physicalCardController = ref.read(physicalCardProvider.notifier);

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null && result.files.first.bytes != null) {
      physicalCardController.setImageBytes(result.files.first.bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = ref.watch(physicalCardProvider).imageBytes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Design',
                style: WonderCardTypography.boldTextTitleBold(
                  color: AppColors.grayScale800,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: const [
                      HeroIcon(
                        HeroIcons.cloudArrowUp,
                        color: Colors.black,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Upload Design',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff414651),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (imageBytes != null)
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                imageBytes!,
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'No image selected yet.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}

final List<Widget> cardTemplates = const [
  CardsTemplate5(),
  CardsTemplate1(),
  CardsTemplate2(),
  CardsTemplate3(),
];

class OrderPhysicalCardSection extends HookConsumerWidget {
  const OrderPhysicalCardSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    final physicalCardController = ref.read(physicalCardProvider.notifier);
    final selectedIndex = ref.watch(physicalCardProvider).selectedIndex;
    final templatesAsync = ref.watch(templateListProvider);

    final selectedCard = ref.watch(selectedCardProvider);
    final profileController = ref.watch(profileProvider);

    return templatesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (templates) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Choose card',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF4B4B4B),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const ListOfDropDownCards(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Physical Card Design',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF402577),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Choose Design from template',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF402577),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemCount: templates.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final template = templates[index];
                  return GestureDetector(
                    onTap: () {
                      physicalCardController.setSelectedIndex(index);
                      physicalCardController.setSelectedTemplate(template);
                    },
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedIndex == index
                              ? Colors.green
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: template.design.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        SvgPicture.network(
                                          template.design,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: SizeConfig.h(200),
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: SizeConfig.w(20),
                                            right: SizeConfig.w(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Company Info (Left Side)
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      SizeConfig.w(10)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.network(
                                                        selectedCard
                                                                ?.cardPictureUrl ??
                                                            ImageAssets.profile,
                                                        width: SizeConfig.w(24),
                                                        height:
                                                            SizeConfig.h(24),
                                                      ),
                                                      Text(
                                                        profileController
                                                                .profileData
                                                                ?.payload
                                                                .profile
                                                                .companyName ??
                                                            emptyString,
                                                        style: TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              SizeConfig.h(6)),
                                                      Text(
                                                        '${selectedCard?.firstName ?? emptyString} ${selectedCard?.lastName ?? emptyString}',
                                                        // softWrap: true,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff3B82F6),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              SizeConfig.h(6)),
                                                      Text(
                                                        selectedCard
                                                                ?.designation ??
                                                            emptyString,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              Color(0xff3B82F6),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              SizeConfig.h(17)),
                                                      HeroIcon(
                                                        HeroIcons.qrCode,
                                                        size: 30,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              Spacer(),

                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      //  left: SizeConfig.w(20),
                                                      top: SizeConfig.h(10),
                                                      bottom: SizeConfig.h(10)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    //    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Address',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              SizeConfig.h(8)),
                                                      Container(
                                                        height: 3,
                                                        color:
                                                            Color(0xff3B82F6),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              SizeConfig.h(5)),
                                                      viewPhysicalCardChildren(
                                                        icon: HeroIcons.phone,
                                                        text: selectedCard
                                                                ?.contactInfo
                                                                ?.phone ??
                                                            emptyString,
                                                      ),
                                                      viewPhysicalCardChildren(
                                                        icon:
                                                            HeroIcons.envelope,
                                                        text: selectedCard
                                                                ?.contactInfo
                                                                ?.email ??
                                                            emptyString,
                                                      ),
                                                      viewPhysicalCardChildren(
                                                        icon: HeroIcons.mapPin,
                                                        text:
                                                            '${selectedCard?.contactInfo?.addresses ?? emptyString}',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const Center(child: Icon(Icons.image)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              template.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Selected Design Preview',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF4B4B4B),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ref
                          .watch(physicalCardProvider)
                          .selectedTemplate
                          ?.design
                          .isNotEmpty ==
                      true
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          SvgPicture.network(
                            ref
                                .watch(physicalCardProvider)
                                .selectedTemplate!
                                .design,
                            placeholderBuilder: (context) => const Center(
                                child: CircularProgressIndicator()),
                            width: MediaQuery.of(context).size.width,
                            height: SizeConfig.h(200),
                            fit: BoxFit.cover,
                          ),

                          // Content Overlay
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.w(20),
                              right: SizeConfig.w(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Company Info (Left Side)
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(SizeConfig.w(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.network(
                                          selectedCard?.cardPictureUrl ??
                                              ImageAssets.profile,
                                          width: SizeConfig.w(24),
                                          height: SizeConfig.h(24),
                                        ),
                                        Text(
                                          profileController.profileData?.payload
                                                  .profile.companyName ??
                                              emptyString,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.h(6)),
                                        Text(
                                          '${selectedCard?.firstName ?? emptyString} ${selectedCard?.lastName ?? emptyString}',
                                          // softWrap: true,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xff3B82F6),
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.h(6)),
                                        Text(
                                          selectedCard?.designation ??
                                              emptyString,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff3B82F6),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.h(17)),
                                        HeroIcon(
                                          HeroIcons.qrCode,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                Spacer(),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        //  left: SizeConfig.w(20),
                                        top: SizeConfig.h(10),
                                        bottom: SizeConfig.h(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      //    mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Address',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.h(8)),
                                        Container(
                                          height: 3,
                                          color: Color(0xff3B82F6),
                                        ),
                                        SizedBox(height: SizeConfig.h(5)),
                                        viewPhysicalCardChildren(
                                          icon: HeroIcons.phone,
                                          text: selectedCard
                                                  ?.contactInfo?.phone ??
                                              emptyString,
                                        ),
                                        viewPhysicalCardChildren(
                                          icon: HeroIcons.envelope,
                                          text: selectedCard
                                                  ?.contactInfo?.email ??
                                              emptyString,
                                        ),
                                        viewPhysicalCardChildren(
                                          icon: HeroIcons.mapPin,
                                          text:
                                              '${selectedCard?.contactInfo?.addresses ?? emptyString}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(child: Text('No preview available')),
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Row viewPhysicalCardChildren({
    required String text,
    required HeroIcons icon,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xff3B82F6),
          ),
          child: HeroIcon(
            icon,
            color: AppColors.defaultWhite,
            size: 5,
          ),
        ),
        Text(text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontSize: 8,
            )),
      ],
    );
  }
}

Widget addSubtractButton(String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    ),
  );
}
