import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/cards/data/model/card_model.dart';
import 'package:wond3rcard/src/cards/data/model/get_a_card.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/get_card.dart';
import 'package:wond3rcard/src/cards/data/repository/card_repository.dart';
import 'package:wond3rcard/src/utils/alert.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

enum CardType { business, personal, organization }

final cardProvider = ChangeNotifierProvider<CardNotifier>((ref) {
  return CardNotifier(ref);
});

class CardNotifier extends ChangeNotifier {
  final Ref ref;

  CardNotifier(this.ref);

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Uint8List? _selectedImage;

  Uint8List? get selectedImage => _selectedImage;

  void setSelectedImage(Uint8List? image) {
    _selectedImage = image;
    notifyListeners();
  }

  Color selectedColor = AppColors.primaryShade;
  String selectedFont = 'Roboto';
  CardType selectedCardType = CardType.personal;

  CardModel? _cardModel;

  CardModel? get cardModel => _cardModel;

  set cardModel(CardModel? card) {
    _cardModel = card;
    notifyListeners();
  }



  GetCard? _card;

  GetCard? get card => _card;

  set card(GetCard? crd) {
    _card = crd;
    notifyListeners();
  }




  GetCard? _getCardsResponse;

  GetCard? get getCardsResponse => _getCardsResponse;

  set getCardsResponse(GetCard? cardResponse) {
    _getCardsResponse = cardResponse;
    notifyListeners();
  }

  List<GetCardsResponse> _getCards = [];

  List<GetCardsResponse> get getCards => _getCards;

  set getCards(List<GetCardsResponse> getCardsList) {
    _getCards = getCardsList;
    notifyListeners();
  }

  List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  set cards(List<CardModel> cardList) {
    _cards = cardList;
    notifyListeners();
  }

  PlatformFile? _selectedPhoto;

  PlatformFile? get selectedPhoto => _selectedPhoto;

  void setSelectedPhoto(PlatformFile? file) {
    _selectedPhoto = file;
    notifyListeners();
  }

  Future<void> pickImage(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      if (context.mounted) {
        setSelectedPhoto(file);
      }
    }
  }

  final TextEditingController cardType = TextEditingController();
  final TextEditingController cardName = TextEditingController();
  final TextEditingController suffix = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController position = TextEditingController();
  final TextEditingController notes = TextEditingController();
  final TextEditingController videoUrl = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController cardBackground = TextEditingController();
  final TextEditingController textColor = TextEditingController();
  final TextEditingController contactInfoEmail = TextEditingController();
  final TextEditingController contactInfoPhone = TextEditingController();
  final TextEditingController contactInfoWebsite = TextEditingController();
  final TextEditingController contactInfoAddress = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController organizationName = TextEditingController();
  final TextEditingController organizationId = TextEditingController();
  final TextEditingController instagram = TextEditingController();
  final TextEditingController facebook = TextEditingController();
  final TextEditingController linkedin = TextEditingController();
  final TextEditingController twitter = TextEditingController();
  final TextEditingController tiktok = TextEditingController();
  final TextEditingController github = TextEditingController();
  final TextEditingController youtube = TextEditingController();
  final TextEditingController cardTypeController = TextEditingController();
  final TextEditingController fontFamilyName = TextEditingController();
  final TextEditingController fontSize = TextEditingController();
  final TextEditingController fontFamily = TextEditingController();
  final TextEditingController fontWeight = TextEditingController();
  final TextEditingController fontStyle = TextEditingController();

  void clearControllers() {
    cardType.clear();
    cardName.clear();
    suffix.clear();
    firstName.clear();
    middleName.clear();
    lastName.clear();
    dateOfBirth.clear();
    position.clear();
    notes.clear();
    videoUrl.clear();
    cardBackground.clear();
  }

  Future<bool> createCard(
      BuildContext context, List<Map<String, dynamic>> socialMediaLinks) async {
    try {
      if (selectedPhoto == null) {
        alert.showErrorToast(
            message: "Please upload an image before creating the card.");
        print("❌ Card creation failed: Card photo or cover photo is null.");
        return false;
      }

      final String? cardId = StorageUtil.getString(key: SessionString.userId);
      String defaultColor = "#000000";
      String validatedSecondaryColor =
          cardBackground.text.isNotEmpty ? cardBackground.text : defaultColor;
      String validatedTextColor =
          textColor.text.isNotEmpty ? textColor.text : defaultColor;

      final CardModel createCard = CardModel(
        cardType: cardType.text,
        ownerId: cardId,
        cardName: cardName.text,
        suffix: suffix.text,
        firstName: firstName.text,
        middleName: middleName.text,
        lastName: lastName.text,
        dateOfBirth: dateOfBirth.text,
        notes: notes.text,
        address: contactInfoAddress.text,
        designation: designation.text,
        email: contactInfoEmail.text,
        fontFamilyName: selectedFont,
        fontSize: fontSize.text.isNotEmpty ? fontSize.text : "16",
        fontStyle: fontStyle.text.isNotEmpty ? fontStyle.text : "normal",
        fontWeight: fontWeight.text.isNotEmpty ? fontWeight.text : "normal",
        organizationId: organizationId.text,
        phone: contactInfoPhone.text,
        primaryColor: selectedColor.value.toString(),
        secondaryColor: validatedSecondaryColor,
        textColor: validatedTextColor,
        website: website.text,
        socialMediaLinks: socialMediaLinks,
        cardPhoto: selectedPhoto,
        cardCoverPhoto: selectedPhoto,
      );

      final formData = await createCard.toFormData();

      loading = true;
      final response =
          await ref.read(cardRepositoryProvider).createCard(formData);
      loading = false;

      if (response.hasError()) {
        print('❌ API Error: ${response.error!.message}');
        alert.showErrorToast(message: response.error!.message);
      } else {
        print("✅ Card created successfully: ${createCard.cardName}");
        cardModel = createCard;
        clearControllers();
        context.go(RouteString.mainDashboard);
        return true;
      }
    } catch (e) {
      loading = false;
      print('❌ Card creation error: $e');
      alert.showErrorToast(message: "An error occurred: ${e.toString()}");
    }
    return false;
  }

  Future<List<GetCardsResponse>> getAllUsersCard() async {
    try {
      loading = true;
      final response =
          await ref.watch(cardRepositoryProvider).getAllUsersCard();
      loading = false;

      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        return [];
      } else {
        getCardsResponse = response.response ?? [];
        return getCards;
      }
    } catch (e) {
      alert.showErrorToast(message: 'An error occurred');
      loading = false;
      return [];
    }
  }

  Future<CardModel?> getAUsersCard(BuildContext context, String cardId) async {
    try {
      loading = true;
      final response =
          await ref.watch(cardRepositoryProvider).getAUsersCard(cardId);
      if (response.hasError()) {
        // alert.showErrorToast(message: response.error!.message);
        log(response.error!.message);
        loading = false;
      } else {
        _cardModel = response.response;
        cardModel = _cardModel;
        return cardModel;
      }
    } catch (e) {
     // alert.showErrorToast(message: 'error occured here please check');
      log('error occured here please check');
      loading = false;
      print(e);
      return cardModel;
    }
    return cardModel;
  }

  Future<CardModel?> viewCard(BuildContext context) async {
    try {
      final String cardId = '';
      loading = true;
      final response = await ref.watch(cardRepositoryProvider).viewCard(cardId);
      if (response.hasError()) {
        log(response.error!.message);
        // alert.showErrorToast(message: response.error!.message);
        loading = false;
      } else {
        _cardModel = response.response;
        cardModel = _cardModel;
        return cardModel;
      }
    } catch (e) {
       log( 'error occured here please check');
      // alert.showErrorToast(message: 'error occured here please check');
      loading = false;
      print(e);
      return cardModel;
    }
    return cardModel;
  }

  Future<void> deleteCard(String? cardId, BuildContext context) async {
    try {
      loading = true;
      final response =
          await ref.read(cardRepositoryProvider).deleteCard(cardId!);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
        loading = false;
      } else {
        await getAUsersCard(context, cardId);
      }
    } catch (e) {}
  }

  Future<void> deleteUserOrgCard(BuildContext context) async {
    final String cardId = '';
    final String organizationId = cardModel?.organizationId ?? emptyString;

    final queries = {
      "organizationId": organizationId,
      "cardId": cardId,
    };

    try {
      loading = true;
      final response = await ref
          .read(cardRepositoryProvider)
          .deleteUserOrgCard(queries, cardId);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
        loading = false;
      } else {
        await getAllUsersCard();
      }
    } catch (e) {}
  }

  Future<void> deleteAllCard(BuildContext context) async {
    try {
      loading = true;
      final response = await ref.watch(cardRepositoryProvider).deleteAllCard();
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        loading = false;
      } else {
        alert.showSuccessToast(message: 'all cards deleted');
        loading = false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    cardType.dispose();
    cardName.dispose();
    suffix.dispose();
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    dateOfBirth.dispose();
    position.dispose();
    notes.dispose();
    videoUrl.dispose();
    cardBackground.dispose();
    super.dispose();
  }

  updateSelectedColor(BuildContext context) {
    Color tempColor = selectedColor;
    selectedColor = tempColor;
    notifyListeners();
    Navigator.of(context).pop();
    notifyListeners();
  }
}
