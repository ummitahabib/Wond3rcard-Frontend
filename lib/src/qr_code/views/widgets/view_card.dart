import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/getcard.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewCard extends ConsumerWidget {
  final String cardId;
  final int index;

  const ViewCard({
    super.key,
    required this.cardId,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ExportDelegate exportDelegate = ExportDelegate();
    return FutureBuilder<Map<String, dynamic>?>(
      future: _loadCardFromHive(cardId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.orange,
            appBar: AppBar(title: const Text("View Card")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading card: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        final cardData = snapshot.data;
        if (cardData == null) {
          return Scaffold(
            backgroundColor: Colors.pink,
            appBar: AppBar(title: const Text("View Card")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.credit_card_off,
                      size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Card not found in cache',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.primaryShade,
          appBar: AppBar(
            backgroundColor: AppColors.primaryShade,
            title: Text(
              'View Card',
              style: WonderCardTypography.boldTextH5(
                fontSize: 23,
                color: AppColors.defaultWhite,
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.defaultWhite,
                ),
                child:
                    HeroIcon(HeroIcons.arrowLeft, color: AppColors.grayScale),
              ),
            ),
          ),
          body: ExportFrame(
            frameId: 'card_frame',
            exportDelegate: exportDelegate,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'images/horizontal_user_card_template.svg',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.all(SizeConfig.w(10)),
                        margin: EdgeInsets.all(SizeConfig.w(10)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(ImageAssets.profile,
                                    width: SizeConfig.w(25),
                                    height: SizeConfig.h(25)),
                                SizedBox(
                                  width: SizeConfig.w(10),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Text(
                                    //   cardController.GetCard?.cardName ?? '',
                                    // style: TextStyle(
                                    //   fontFamily: 'Inter',
                                    //   fontWeight: FontWeight.w800,
                                    //   fontSize: 25,
                                    //   color: Colors.white,
                                    // ),
                                    // ),

                                    if (_getStringValue(cardData, 'cardName') !=
                                        null)
                                      Text(
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                        _getStringValue(cardData, 'cardName')!,
                                      )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.h(30),
                            ),
                            CustomStyledContainer(
                              image:
                                  _getStringValue(cardData, 'cardPictureUrl') ??
                                      ImageAssets.profileImage,
                            ),
                            Text(
                              '${_getStringValue(cardData, 'firstName') ?? ''}',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                fontWeight: FontWeight.w800,
                                fontSize: 30,
                                color: Color(0xff6D41CA),
                              ),
                            ),
                            Text(
                              '${_getStringValue(cardData, 'lastName') ?? ''}',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color(0xff212121),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.h(20),
                            ),
                            Text(
                              '${_getStringValue(cardData, 'designation') ?? ''}',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                fontWeight: FontWeight.w900,
                                fontSize: 35,
                                color: AppColors.darkDisable,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.w(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [_buildContactInfo(cardData)],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactInfo(Map<String, dynamic> cardData) {
    final contactInfo = cardData['contactInfo'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: wonderCardFontName,
            ),
          ),
          const SizedBox(height: 12),

          // Email
          if (contactInfo != null && contactInfo['email'] != null)
            _buildInfoRow(
              Icons.email_outlined,
              'Email',
              contactInfo['email'].toString(),
            ),

          // Phone
          if (contactInfo != null && contactInfo['phone'] != null)
            _buildInfoRow(
              Icons.phone_outlined,
              'Phone',
              contactInfo['phone'].toString(),
            ),

          // Website
          if (contactInfo != null && contactInfo['website'] != null)
            _buildInfoRow(
              Icons.language_outlined,
              'Website',
              contactInfo['website'].toString(),
            ),

          // Address
          if (contactInfo != null && contactInfo['address'] != null)
            _buildInfoRow(
              Icons.location_on_outlined,
              'Address',
              contactInfo['address'].toString(),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(Map<String, dynamic> cardData) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Card Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: wonderCardFontName,
            ),
          ),
          const SizedBox(height: 12),

          // Card ID
          _buildInfoRow(
            Icons.credit_card,
            'Card ID',
            _getStringValue(cardData, 'id') ?? 'N/A',
          ),

          // Company
          if (_getStringValue(cardData, 'company') != null)
            _buildInfoRow(
              Icons.business_outlined,
              'Company',
              _getStringValue(cardData, 'company')!,
            ),

          // Job Title
          if (_getStringValue(cardData, 'jobTitle') != null)
            _buildInfoRow(
              Icons.work_outline,
              'Job Title',
              _getStringValue(cardData, 'jobTitle')!,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.grayScale700,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontFamily: wonderCardFontName,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: wonderCardFontName,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _getStringValue(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value == null) return null;
    return value.toString();
  }

  Future<Map<String, dynamic>?> _loadCardFromHive(String cardId) async {
    try {
      final box = await Hive.openBox('cardsBox');
      final rawData = box.get(cardId);

      debugPrint('Raw card from Hive: $rawData');
      debugPrint('Raw data type: ${rawData.runtimeType}');

      if (rawData == null) {
        debugPrint('No data found for cardId: $cardId');
        return null;
      }

      Map<String, dynamic>? cardData;

      // Accepts both Map<dynamic, dynamic> and GetCard
      if (rawData is Map) {
        // Convert dynamic map keys to string
        cardData = Map<String, dynamic>.from(rawData.map(
          (key, value) => MapEntry(key.toString(), value),
        ));
      } else if (rawData is GetCard) {
        cardData = _convertGetCardToMap(rawData);
      } else {
        debugPrint('Unexpected data type: ${rawData.runtimeType}');
        return null;
      }

      debugPrint('Processed card data: $cardData');
      return cardData;
    } catch (e, stackTrace) {
      debugPrint('Error loading card from Hive: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> _convertGetCardToMap(GetCard getCard) {
    // This method should convert your GetCard object to a Map
    // You'll need to implement this based on your GetCard model structure
    // For example:
    return {
      'id': getCard.payload?.cards?[index].id ?? '',
      'firstName': getCard.payload?.cards?[index].firstName ?? '',
      'lastName': getCard.payload?.cards?[index].lastName ?? '',
      'cardName': getCard.payload?.cards?[index].cardName ?? '',
      'cardPictureUrl': getCard.payload?.cards?[index].cardPictureUrl ?? '',
      'contactInfo': {
        'email': getCard.payload?.cards?[index].contactInfo?.email,
        'phone': getCard.payload?.cards?[index].contactInfo?.phone,
        'website': getCard.payload?.cards?[index].contactInfo?.website,
        'address': getCard.payload?.cards?[index].contactInfo?.address,
      },
      // 'company': getCard.company,
      // 'jobTitle': getCard.jobTitle,
      // Add other fields as needed
    };
  }
}

class CustomStyledContainer extends StatelessWidget {
  const CustomStyledContainer({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      child: Image.network(image),
    );
  }
}
