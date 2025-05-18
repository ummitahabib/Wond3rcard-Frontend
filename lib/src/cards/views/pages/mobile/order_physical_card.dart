import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/data/controller/order_physical_card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/billing_summary.dart';
import 'package:wond3rcard/src/cards/views/widgets/cards_template.dart';
import 'package:wond3rcard/src/cards/views/widgets/list_of_dropdown.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:file_picker/file_picker.dart';

class OrderPhysicalCard extends HookConsumerWidget {
  const OrderPhysicalCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final cardController = ref.read(cardProvider);
          final profileController = ref.watch(profileProvider);
          if (cardController.getCardsResponse == null) {
            Future.delayed(Duration.zero, () async {
              await cardController.getAllUsersCard();
              await profileController.getProfile(context);
            });
          }
        });
        return null;
      },
      [],
    );
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
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              isDesktop(context) ? _orderCardDesktop(context) : _orderCard()),
    );
  }

  Widget _orderCardDesktop(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          OrderPhysicalCardSection(),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ChooseAndUploadWidget(),
                SizedBox(
                  height: 10,
                ),
                ShippingAddressWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _orderCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        OrderPhysicalCardSection(),
        SizedBox(
          height: 10,
        ),
        ChooseAndUploadWidget(),
        SizedBox(
          height: 10,
        ),
        ShippingAddressWidget(),
      ],
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
          height: 205,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cardTemplates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => physicalCardController.setSelectedIndex(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedIndex == index
                          ? Colors.green
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: cardTemplates[index],
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
          child: cardTemplates[selectedIndex],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class ShippingAddressWidget extends HookConsumerWidget {
  const ShippingAddressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            hintText: '125 Street, USA',
            text: 'Shipping Address',
            maxLines: 4,
            fillColor: Colors.white,
          ),
          SizedBox(
            height: 9,
          ),
          CustomTextField(
            hintText: 'Card holdres name',
            text: 'Name on card',
            fillColor: Colors.white,
          ),
          SizedBox(
            height: 9,
          ),
          CustomTextField(
            hintText: '0000 -0000-0000-0000',
            text: 'Card number',
            fillColor: Colors.white,
          ),
          SizedBox(
            height: 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                width: 170,
                hintText: 'dd/mm/yyyy',
                text: 'Expiry date',
                fillColor: Colors.white,
              ),
              SizedBox(
                width: 9,
              ),
              CustomTextField(
                width: 170,
                hintText: '123',
                text: 'CVV/CVC',
                fillColor: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Quantity',
                    style: WonderCardTypography.boldTextTitle2(
                      color: Color(0xff414651),
                      fontSize: 12,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _addSubtractButton(
                      '-',
                      () {},
                    ),
                    Text('3'),
                    _addSubtractButton(
                      '+',
                      () {},
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 51,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFEFEFEF),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0D0A0D12),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "400",
                style: WonderCardTypography.regularTextTitle1(
                  fontSize: 19,
                  color: Color(0xff212121),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          WonderCardButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BillingSummary(
                    selectedCardTemplate: cardTemplates[
                        ref.read(physicalCardProvider).selectedIndex],
                    uploadedDesign: ref.read(physicalCardProvider).imageBytes,
                    shippingAddress: '125 Street, USA',
                    nameOnCard: 'John Doe',
                    cardNumber: '0000-0000-0000-0000',
                    expiryDate: '12/34',
                    cvv: '123',
                    quantity: 3,
                    totalPrice: 400.0,
                  ),
                ),
              );
            },
            text: 'Review Order & Billing Summary',
            backgroundColor: AppColors.primaryShade,
            textColor: AppColors.defaultWhite,
          ),
          SizedBox(
            height: 10,
          ),
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

  GestureDetector _addSubtractButton(String text, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.primaryShade,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
