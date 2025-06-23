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
                  const Icon(Icons.credit_card_off, size: 48, color: Colors.grey),
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
                child: HeroIcon(HeroIcons.arrowLeft, color: AppColors.grayScale),
              ),
            ),
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
                          color: Color(0x0F000000),
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                        BoxShadow(
                          color: Color(0x1A000000),
                          offset: Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Profile Image
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0F000000),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                              BoxShadow(
                                color: Color(0x1A000000),
                                offset: Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 4,
                              color: AppColors.defaultWhite,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.defaultWhite,
                            backgroundImage: NetworkImage(
                              _getStringValue(cardData, 'cardPictureUrl') ?? 
                              ImageAssets.profileImage,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Name
                        Text(
                          '${_getStringValue(cardData, 'firstName') ?? ''} ${_getStringValue(cardData, 'lastName') ?? ''}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: wonderCardFontName,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        
                        // Card Name
                        if (_getStringValue(cardData, 'cardName') != null)
                          Text(
                            _getStringValue(cardData, 'cardName')!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: wonderCardFontName,
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
      final box = await Hive.openBox('cardsBox'); // Remove type parameter
      final rawData = box.get(cardId);
      
      debugPrint('Raw card from Hive: $rawData');
      debugPrint('Raw data type: ${rawData.runtimeType}');
      
      if (rawData == null) {
        debugPrint('No data found for cardId: $cardId');
        return null;
      }

      // Handle different data types
      Map<String, dynamic>? cardData;
      
      if (rawData is Map<String, dynamic>) {
        cardData = rawData;
      } else if (rawData is GetCard) {
        // If it's a GetCard object, convert to Map
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