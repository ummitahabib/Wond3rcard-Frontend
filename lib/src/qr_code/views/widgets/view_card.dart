import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/data/model/card_model.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/get_card.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/getcard.dart';
import 'package:wond3rcard/src/qr_code/views/widgets/share_card_widget.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

// class ViewCard extends HookConsumerWidget {
//   const ViewCard({
//     super.key,
//     required this.cardId,
//     required this.index,
//   });

//   final String cardId;
//   final int index;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cardController = ref.watch(cardProvider);
//     final ExportDelegate exportDelegate = ExportDelegate();
//     final isLoading = useState(true);

//     useEffect(() {
//       Future.microtask(() async {
//         await ref.read(cardProvider).getAUsersCard(context, cardId);
//         isLoading.value = false;
//       });
//       return null;
//     }, []);

//     SizeConfig.init(context);

//     final ScreenshotController _screenshotController = ScreenshotController();

//     Future<void> _saveAsImage(BuildContext context) async {
//       final image = await _screenshotController.capture();
//       if (image == null) return;

//       final status = await Permission.storage.request();
//       if (status.isGranted) {
//         final directory = await getExternalStorageDirectory();
//         final imagePath =
//             '${directory!.path}/${cardController.GetCard?.cardName ?? ''}_card.png';
//         final imageFile = File(imagePath);
//         await imageFile.writeAsBytes(image);

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Image saved successfully')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Storage permission denied')),
//         );
//       }
//     }

//     Future<void> _saveToContacts(BuildContext context) async {
//       final permission = await Permission.contacts.request();
//       if (!permission.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Contacts permission denied")),
//         );
//         return;
//       }

//       // final contact = Contact(
//       //   givenName: userData.name,
//       //   company: userData.company,
//       //   jobTitle: userData.title,
//       //   phones: [Item(label: 'mobile', value: userData.phone)],
//       //   emails: [Item(label: 'work', value: userData.email)],
//       // );

//       // await ContactsService.addContact(contact);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Contact saved to phone")),
//       );
//     }

//     Future<void> _saveAsPDF(BuildContext context) async {
//       final status = await Permission.storage.request();
//       if (!status.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Storage permission denied")),
//         );
//         return;
//       }

//       final pdfDocument =
//           await exportDelegate.exportToPdfDocument('card_frame');
//       final pdfBytes = await pdfDocument.save();

//       final directory = await getTemporaryDirectory();
//       final filePath = '${directory.path}/exported_card.pdf';
//       final file = File(filePath);
//       await file.writeAsBytes(pdfBytes);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Card exported as PDF")),
//       );
//     }

//     void _showDownloadOptions(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Download Options'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.image),
//                   title: const Text("Save as Image"),
//                   onTap: () async {
//                     Navigator.of(context).pop(); // Close dialog
//                     await _saveAsImage(context);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.picture_as_pdf),
//                   title: const Text("Export as PDF"),
//                   onTap: () async {
//                     Navigator.of(context).pop();
//                     await _saveAsPDF(context);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.contact_page),
//                   title: const Text("Save Contact"),
//                   onTap: () async {
//                     Navigator.of(context).pop();
//                     await _saveToContacts(context);
//                   },
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 child: const Text("Cancel"),
//                 onPressed: () => Navigator.of(context).pop(),
//               )
//             ],
//           );
//         },
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'View Card',
//           style: WonderCardTypography.boldTextH5(
//             fontSize: 23,
//             color: AppColors.defaultWhite,
//           ),
//         ),
//         backgroundColor: AppColors.primaryShade,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: AppColors.defaultWhite,
//           ),
//           onPressed: () {
//             context.go(RouteString.shareCardLink);
//           },
//         ),
//       ),
//       floatingActionButton: CircleAvatar(
//         backgroundColor: AppColors.primaryShade,
//         child: IconButton(
//           icon: Icon(Icons.download, color: AppColors.defaultWhite),
//           onPressed: () => _showDownloadOptions(context),
//         ),
//       ),
//       body: isLoading.value
//           ? const Center(child: CircularProgressIndicator())
//           : ExportFrame(
//               frameId: 'card_frame',
//               exportDelegate: exportDelegate,
//               child: Center(
//                 child: Container(
//                   padding: EdgeInsets.all(SizeConfig.w(10)),
//                   margin: EdgeInsets.all(SizeConfig.w(10)),
//                   child: Stack(
//                     children: [
//                       SvgPicture.asset(
//                         'images/horizontal_user_card_template.svg',
//                         width: MediaQuery.of(context).size.width,
//                         fit: BoxFit.cover,
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(SizeConfig.w(10)),
//                         margin: EdgeInsets.all(SizeConfig.w(10)),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               children: [
//                                 Image.asset(ImageAssets.profile,
//                                     width: SizeConfig.w(25),
//                                     height: SizeConfig.h(25)),
//                                 SizedBox(
//                                   width: SizeConfig.w(10),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       cardController.GetCard?.cardName ?? '',
//                                       style: TextStyle(
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: 25,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: SizeConfig.h(30),
//                             ),
//                             CustomStyledContainer(
//                               image: cardController.getCardsResponse?.payload
//                                       ?.cards?[index].cardPictureUrl ??
//                                   emptyString,
//                             ),
//                             Text(
//                               cardController.getCardsResponse?.payload?.cards?[index]
//                                       .firstName ??
//                                   emptyString,
//                               style: TextStyle(
//                                 fontFamily: 'Barlow',
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 30,
//                                 color: Color(0xff6D41CA),
//                               ),
//                             ),
//                             Text(
//                               cardController.getCardsResponse?.payload?.cards?[index]
//                                       .lastName ??
//                                   emptyString,
//                               style: TextStyle(
//                                 fontFamily: 'Barlow',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 20,
//                                 color: Color(0xff212121),
//                               ),
//                             ),
//                             SizedBox(
//                               height: SizeConfig.h(20),
//                             ),
//                             Text(
//                               cardController.getCardsResponse?.payload?.cards?[index]
//                                       .designation ??
//                                   emptyString,
//                               style: TextStyle(
//                                 fontFamily: 'Barlow',
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 35,
//                                 color: AppColors.darkDisable,
//                               ),
//                             ),
//                             SizedBox(
//                               height: SizeConfig.w(10),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       viewCardRow(
//                                         HeroIcons.phone,
//                                         cardController.getCardsResponse?.payload
//                                                 ?.cards?[index].contactInfo?.phone ??
//                                             emptyString,
//                                       ),
//                                       SizedBox(
//                                         height: SizeConfig.h(5),
//                                       ),
//                                       viewCardRow(
//                                         HeroIcons.envelope,
//                                         cardController.getCardsResponse?.payload
//                                                 ?.cards?[index].contactInfo?.email ??
//                                             emptyString,
//                                       ),
//                                       SizedBox(
//                                         height: SizeConfig.h(5),
//                                       ),
//                                       viewCardRow(
//                                         HeroIcons.map,
//                                         '${cardController.getCardsResponse?.payload?.cards?[index].contactInfo?.addresses ?? emptyString}',
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Spacer(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget viewCardRow(HeroIcons icon, String text) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Expanded(
//           child: SizedBox(
//             width: SizeConfig.w(10),
//             child: CircleAvatar(
//               backgroundColor: AppColors.primaryShade,
//               child: HeroIcon(
//                 icon,
//                 color: AppColors.defaultWhite,
//                 size: 10,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             text,
//             style: TextStyle(
//               fontFamily: 'Inter',
//               fontWeight: FontWeight.w400,
//               fontStyle: FontStyle.italic,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ViewCard extends ConsumerWidget {
//   final String cardId;
//   final int index;

//   const ViewCard({
//     super.key,
//     required this.cardId,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return FutureBuilder<GetCard?>(
//       future: _loadCardFromHive(cardId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         } else if (snapshot.hasError) {
//           return Scaffold(
//             backgroundColor: Colors.red,
//             body: Center(child: Text('Error loading card: ${snapshot.error}')),
//           );
//         } else if (!snapshot.hasData || snapshot.data == null) {
//           return const Scaffold(
//             backgroundColor: Colors.pink,
//             body: Center(child: Text('Card not found in cache')),
//           );
//         }

//         final card = snapshot.data!;
//         final cardList = card.payload?.cards ?? [];

//         if (index < 0 || index >= cardList.length) {
//           return const Scaffold(
//             backgroundColor: Colors.purpleAccent,
//             body: Center(child: Text('Invalid card index')),
//           );
//         }

//         final cardData = cardList[index];

//         return Scaffold(
//           backgroundColor: Colors.green,
//           appBar: AppBar(title: const Text("View Card")),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Name: ${cardData.firstName} ${cardData.lastName}"),
//                   Text("Email: ${cardData.contactInfo?.email ?? 'N/A'}"),
//                   Text("Phone: ${cardData.contactInfo?.phone ?? 'N/A'}"),
//                   const SizedBox(height: 20),
//                   Text("Card Name: ${cardData.cardName ?? 'N/A'}"),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// Load a card from Hive using the card ID
//   Future<GetCard?> _loadCardFromHive(String cardId) async {
//     final box = await Hive.openBox<GetCard>('cardsBox');
//     return box.get(cardId);
//   }
// }

// class CustomStyledContainer extends StatelessWidget {
//   const CustomStyledContainer({super.key, required this.image});

//   final String image;
//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 20,
//       child: Image.network(image),
//     );
//   }
// }

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
    return FutureBuilder<CardData?>(
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Error loading card: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Go Back'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _debugPrintCacheData(cardId),
                    child: const Text('Debug Cache'),
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              'View Card',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Card Container
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Profile Image
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: _getImageProvider(cardData),
                            child: _getImageProvider(cardData) == null
                                ? const Icon(Icons.person,
                                    size: 50, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Name
                        Text(
                          _getFullName(cardData),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        // Card Name
                        if (_getSafeString(cardData.cardName).isNotEmpty)
                          Text(
                            _getSafeString(cardData.cardName),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 20),

                        // Contact Information
                        _buildContactInfo(cardData),
                      ],
                    ),
                  ),

                  // Additional Information
                  _buildAdditionalInfo(cardData),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactInfo(CardData cardData) {
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
            ),
          ),
          const SizedBox(height: 12),

          // Email
          if (_getContactEmail(cardData).isNotEmpty)
            _buildInfoRow(
              Icons.email_outlined,
              'Email',
              _getContactEmail(cardData),
            ),

          // Phone
          if (_getContactPhone(cardData).isNotEmpty)
            _buildInfoRow(
              Icons.phone_outlined,
              'Phone',
              _getContactPhone(cardData),
            ),

          // Website
          if (_getContactWebsite(cardData).isNotEmpty)
            _buildInfoRow(
              Icons.language_outlined,
              'Website',
              _getContactWebsite(cardData),
            ),

          // Address
          if (_getContactAddress(cardData).isNotEmpty)
            _buildInfoRow(
              Icons.location_on_outlined,
              'Address',
              _getContactAddress(cardData),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(CardData cardData) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4,
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
            ),
          ),
          const SizedBox(height: 12),

          // Card ID
          _buildInfoRow(
            Icons.credit_card,
            'Card ID',
            _getSafeString(cardData.id),
          ),

          // Company
          if (_getSafeString(cardData.designation).isNotEmpty)
            _buildInfoRow(
              Icons.business_outlined,
              'Company',
              _getSafeString(cardData.designation),
            ),

          // Job Title
          if (_getSafeString(cardData.designation).isNotEmpty)
            _buildInfoRow(
              Icons.work_outline,
              'Job Title',
              _getSafeString(cardData.designation),
            ),

          // Bio
          if (_getSafeString(cardData.cardName).isNotEmpty)
            _buildInfoRow(
              Icons.info_outline,
              'Bio',
              _getSafeString(cardData.cardName),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
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
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Safe string getter
  String _getSafeString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  String _normalizeContactField(dynamic field) {
  if (field == null) return '';
  if (field is List && field.isNotEmpty) return field.first.toString();
  return field.toString();
}

String _getContactEmail(CardData cardData) {
  return _normalizeContactField(cardData.contactInfo?.email);
}

String _getContactPhone(CardData cardData) {
  return _normalizeContactField(cardData.contactInfo?.phone);
}

String _getContactWebsite(CardData cardData) {
  return _normalizeContactField(cardData.contactInfo?.website);
}

String _getContactAddress(CardData cardData) {
  return _normalizeContactField(cardData.contactInfo?.address);
}

  // Safe full name getter
  String _getFullName(CardData cardData) {
    final firstName = _getSafeString(cardData.firstName);
    final lastName = _getSafeString(cardData.lastName);
    final fullName = '$firstName $lastName'.trim();
    return fullName.isEmpty ? 'Unknown User' : fullName;
  }

  // Safe image provider
  ImageProvider? _getImageProvider(CardData cardData) {
    try {
      final imageUrl = _getSafeString(cardData.cardPictureUrl);
      if (imageUrl.isNotEmpty && imageUrl.startsWith('http')) {
        return NetworkImage(imageUrl);
      }
    } catch (e) {
      debugPrint('Error loading image: $e');
    }
    return null;
  }

  // Load card from Hive cache
  Future<CardData?> _loadCardFromHive(String cardId) async {
    try {
      debugPrint('Loading card with ID: $cardId');

      final box = await Hive.openBox('cardsBox');
      final rawData = box.get(cardId);

      debugPrint('Raw data from Hive: $rawData');
      debugPrint('Raw data type: ${rawData.runtimeType}');

      if (rawData == null) {
        debugPrint('No data found for cardId: $cardId');
        return null;
      }

      // Handle different data types
      if (rawData is GetCard) {
        // Extract the card data from GetCard
        final cards = rawData.payload?.cards;
        if (cards != null && cards.isNotEmpty) {
          // Return the first card that matches our cardId or just the first card
          final matchingCard = cards.firstWhere(
            (card) => card.id == cardId,
            orElse: () => cards.first,
          );
          debugPrint('Found matching card: ${matchingCard.id}');
          return matchingCard;
        }
      } else if (rawData is CardData) {
        // Direct CardData object
        debugPrint('Found direct CardData object');
        return rawData;
      } else if (rawData is Map) {
        // Try to convert Map to CardData
        debugPrint('Converting Map to CardData');
        try {
          return CardData.fromMap(Map<String, dynamic>.from(rawData));
        } catch (e) {
          debugPrint('Error converting Map to CardData: $e');
        }
      }

      debugPrint('Could not process data type: ${rawData.runtimeType}');
      return null;
    } catch (e, stackTrace) {
      debugPrint('Error loading card from Hive: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Debug method to print cache data
  void _debugPrintCacheData(String cardId) async {
    try {
      final box = await Hive.openBox('cardsBox');
      debugPrint('=== CACHE DEBUG FOR $cardId ===');
      debugPrint('All keys in cache: ${box.keys.toList()}');

      final data = box.get(cardId);
      debugPrint('Raw data: $data');
      debugPrint('Data type: ${data.runtimeType}');

      if (data is GetCard) {
        debugPrint('GetCard status: ${data.status}');
        debugPrint('GetCard message: ${data.message}');
        debugPrint('GetCard payload: ${data.payload}');
        debugPrint('Cards count: ${data.payload?.cards?.length}');

        if (data.payload?.cards != null) {
          for (int i = 0; i < data.payload!.cards!.length; i++) {
            final card = data.payload!.cards![i];
            debugPrint(
                'Card $i: ID=${card.id}, Name=${card.firstName} ${card.lastName}');
          }
        }
      } else if (data is CardData) {
        debugPrint('CardData ID: ${data.id}');
        debugPrint('CardData Name: ${data.firstName} ${data.lastName}');
      }

      debugPrint('=== END CACHE DEBUG ===');
    } catch (e) {
      debugPrint('Debug error: $e');
    }
  }
}
