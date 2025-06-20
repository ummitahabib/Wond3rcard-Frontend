import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/create_card_reusable_app_bar.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wond3rcard/src/shared/data/controller/shared_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/map_screen.dart';
import 'package:wond3rcard/src/utils/util.dart';

final formKey = GlobalKey<FormState>();

class EditCardScreen extends StatefulHookConsumerWidget {
  const EditCardScreen({super.key, this.cardId});
  final String? cardId;
  final String routeName = RouteString.createNewCard;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends ConsumerState<EditCardScreen> {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final cardController = ref.read(cardProvider);
      final profileController = ref.read(profileProvider);

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (widget.cardId != null && widget.cardId!.isNotEmpty) {
          await cardController.getAUsersCard(context, widget.cardId!);
        } else {
          cardController.clearForm();
        }
        await profileController.getProfile(context);
      });

      return null;
    }, []);

    return Scaffold(
      appBar: CreateCardReusableAppBar(
        titleText: (widget.cardId == null || widget.cardId == "")
            ? 'Create Card'
            : 'Edit Card',
        route: RouteString.mainDashboard,
      ),
      backgroundColor: AppColors.defaultWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: SpacingConstants.size20, horizontal: size25),
          child: isMobile(context)
              ? CreateCardForm(
                  cardId: widget.cardId ?? emptyString,
                )
              : Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(20),
                      child: CreateCardForm(
                        cardId: widget.cardId ?? emptyString,
                      )),
                ),
        ),
      ),
    );
  }
}

class CreateCardForm extends StatefulHookConsumerWidget {
  const CreateCardForm({super.key, required this.cardId});
  final String cardId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCardFormState();
}

class _CreateCardFormState extends ConsumerState<CreateCardForm> {
  late TextEditingController dobController;

  @override
  void initState() {
    super.initState();
    dobController = TextEditingController();
    _initializeFields();
  }

  void _initializeFields() {
    final cardController = ref.read(cardProvider);
    // Use the first card (index 0) or adjust as needed
    final int index = 0;
    final cardModel = cardController.getCardsResponse?.payload?.cards != null &&
            cardController.getCardsResponse!.payload!.cards!.isNotEmpty
        ? cardController.getCardsResponse!.payload!.cards![index]
        : null;

    if (cardModel != null) {
      cardController.firstName.text = cardModel.firstName ?? '';
      cardController.lastName.text = cardModel.lastName ?? '';
      cardController.middleName.text = cardModel.otherName ?? '';
      // dobController.text             = cardModel. ?? '';
      cardController.suffix.text = cardModel.suffix ?? '';
      cardController.contactInfoAddress.text =
          cardModel.contactInfo?.address ?? '';
    } else {
      cardController.clearForm();
      dobController.clear();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cardController = ref.watch(cardProvider);
    cardController.addListener(_initializeFields);
  }

  @override
  void dispose() {
    dobController.dispose();
    final cardController = ref.read(cardProvider);
    cardController.removeListener(_initializeFields);
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate =
        DateTime.tryParse(dobController.text) ?? DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _saveAndContinue(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      if (mounted) {
        context.go(RouteString.createNewCardTwo);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all required fields.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final cardController = ref.read(cardProvider);
      final profileController = ref.read(profileProvider);

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        if (widget.cardId.isNotEmpty) {
          await cardController.getAUsersCard(context, widget.cardId);
        } else {
          cardController.clearForm();
        }
        if (mounted) {
          await profileController.getProfile(context);
        }
      });

      return null;
    }, []);

    final cardController = ref.watch(cardProvider);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Personal Details',
            style: WonderCardTypography.boldTextTitleBold(),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: 'Enter your firstname',
            text: 'First name',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.firstName,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),
          CustomTextField(
            hintText: 'Enter your lastname',
            text: 'Last name',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.lastName,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
          ),
          CustomTextField(
            hintText: 'Enter your othername',
            text: 'Other name',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.middleName,
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomTextField(
                hintText: 'Select your date of birth',
                text: 'DOB',
                fillColor: AppColors.defaultWhite,
                textEditingController: dobController,
                isRequired: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date of birth is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          CustomTextField(
            hintText: "e.g., Mr., Mrs., Eng.",
            text: 'Suffix',
            fillColor: AppColors.defaultWhite,
            textEditingController: cardController.suffix,
          ),
          const SizedBox(height: 15),
          AddressField(
            address: cardController.contactInfoAddress,
          ),
          const SizedBox(height: 15),
          Center(
            child: WonderCardButton(
              textColor: Colors.white,
              showLoader: cardController.loading,
              text: cardController.cardModel == null
                  ? 'Save and Continue'
                  : 'Update and Continue',
              onPressed: () => _saveAndContinue(context),
            ),
          ),
        ],
      ),
    );
  }
}





class AddressField extends StatefulHookConsumerWidget {
  final TextEditingController address;

  AddressField({super.key, required this.address});

  @override
  _AddressFieldState createState() => _AddressFieldState();
}

class _AddressFieldState extends ConsumerState<AddressField> {
  Future<void> _openMap() async {
    LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        widget.address.text = fetchingAddressText;
      });

      final sharedController = ref.read(sharedProvider);
      String address = await sharedController.getAddressFromCoordinates(
        pickedLocation.latitude,
        pickedLocation.longitude,
      );
      setState(() {
        widget.address.text = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.address,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grayScale50),
              borderRadius: BorderRadius.circular(size8),
            ),
            labelText: enterAddressOrSelectMap,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.map,
                color: AppColors.primaryShade,
              ),
              onPressed: _openMap,
            ),
          ),
        ),
      ],
    );
  }
}
