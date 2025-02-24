import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/cards/data/model/card_model.dart';
import 'package:wond3rcard/src/cards/data/model/get_a_card.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/get_card.dart';
import 'package:wond3rcard/src/cards/data/repository/card_repository.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
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

  Color selectedColor = AppColors.primaryShade;
  CardType selectedCardType = CardType.personal;

  late CardModel _cardModel;

  CardModel get cardModel => _cardModel;

  set cardModel(CardModel card) {
    _cardModel = card;
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

  File? _uploadedImage;

  File? get uploadedImage => _uploadedImage;

  void setUploadedImage(File image) {
    _uploadedImage = image;
    notifyListeners();
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

  Future<bool> createCard(BuildContext context) async {
    final String? cardId = StorageUtil.getString(
      key: SessionString.userId,
    );

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
      fontFamilyName: fontFamilyName.text,
      fontSize: fontSize.text,
      fontStyle: fontStyle.text,
      fontWeight: fontWeight.text,
      organizationId: organizationId.text,
      phone: contactInfoPhone.text,
      primaryColor: cardBackground.text,
      secondaryColor: cardBackground.text,
      textColor: textColor.text,
      website: website.text,
    );

    try {
      loading = true;

      final response = await ref.read(cardRepositoryProvider).createCard(
            createCard.toJson(),
          );
      loading = false;
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
      } else {
        cardModel = createCard;
        clearControllers();
        // context.go(RouteString.successPage);
        print('card created success');
        return true;
      }
    } catch (e) {
      loading = false;
      print('card created error occured $e');
      alert.showErrorToast(message: "An error occurred: ${e.toString()}");
    }
    return false;
  }

  // Future<bool> createCardOrganization(BuildContext context) async {
  //   final String cardId = StorageUtil.getString(
  //     key: SessionString.userId,
  //   );
  //   final CardModel createCard = CardModel(
  //     cardType: cardType.text,
  //     creatorId: cardId,
  //     ownerId: cardId,
  //     cardName: cardName.text,
  //     suffix: suffix.text,
  //     firstName: firstName.text,
  //     middleName: middleName.text,
  //     lastName: lastName.text,
  //     dateOfBirth: dateOfBirth.text,
  //     position: position.text,
  //     notes: notes.text,
  //     testimonials: [],
  //     videoUrl: videoUrl.text,
  //     profilePicture: _uploadedImage?.path ?? emptyString,
  //     cardBackground: cardBackground.text,
  //     active: true,

  //     // active: true, // Default value
  //     textStyle: TextStyles(
  //       fontSize: "18",
  //       fontStyle: "normal",
  //       fontWeight: "normal",
  //       textAlign: "left",
  //       textColor: "black",
  //     ),
  //     cardDesign: CardDesign(
  //       backgroundColor: "white",
  //       backgroundImage: "",
  //       borderStyle: "none",
  //       borderColor: "",
  //       borderWidth: "",
  //       borderRadius: "",
  //       boxShadow: "",
  //     ),
  //     cardLayout: CardLayout(
  //       padding: "10",
  //       margin: "15",
  //       layoutOrientation: "horizontal",
  //     ),
  //     organizationInfo: OrganizationInfo(
  //       organizationId: "",
  //       organizationName: "",
  //     ),
  //     contactInfo: ContactInfo(
  //       email: contactInfoEmail.text,
  //       phone: contactInfoPhone.text,
  //       website: "",
  //       address: contactInfoAddress.text,
  //     ),
  //     socialMediaLinks: SocialMediaLinks(
  //       linkedin: "",
  //       twitter: "",
  //       facebook: "",
  //       instagram: "",
  //       tiktok: "",
  //       github: "",
  //       youtube: "",
  //       customLinks: [],
  //     ),
  //   );

  //   try {
  //     loading = true;

  //     final response =
  //         await ref.read(cardRepositoryProvider).createCardOrganization(
  //               createCard.toJson(),
  //             );

  //     loading = false;

  //     if (response.hasError()) {
  //       alert.showErrorToast(message: response.error!.message);
  //     } else {
  //       cardModel = createCard;

  //       StorageUtil.putString(
  //           key: SessionString.cardId, value: cardModel.cardId ?? emptyString);
  //       clearControllers();
  //       // context.go(RouteString.successPage);
  //       print('card created success');
  //       return true;
  //     }
  //   } catch (e) {
  //     loading = false;
  //     print('card created error occured $e');
  //     alert.showErrorToast(message: "An error occurred: ${e.toString()}");
  //   }

  //   return false;
  // }

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

  Future<CardModel> getAUsersCard(BuildContext context) async {
    final String cardId = '';
    //cardModel.cardId ?? emptyString;
    try {
      loading = true;
      final response =
          await ref.watch(cardRepositoryProvider).getAUsersCard(cardId);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        loading = false;
      } else {
        _cardModel = response.response;
        cardModel = _cardModel;
        return cardModel;
      }
    } catch (e) {
      alert.showErrorToast(message: 'error occured here please check');
      loading = false;
      print(e);
      return cardModel;
    }
    return cardModel;
  }

  Future<CardModel> viewCard(BuildContext context) async {
    try {
      final String cardId = '';
      //cardModel.cardId ?? emptyString;
      loading = true;
      final response = await ref.watch(cardRepositoryProvider).viewCard(cardId);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        loading = false;
      } else {
        _cardModel = response.response;
        cardModel = _cardModel;
        return cardModel;
      }
    } catch (e) {
      alert.showErrorToast(message: 'error occured here please check');
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
        await getAUsersCard(context);
      }
    } catch (e) {}
  }

  Future<void> deleteUserOrgCard(BuildContext context) async {
    final String cardId = '';
    //cardModel.cardId ?? emptyString;
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
        // or get all users organization card
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
