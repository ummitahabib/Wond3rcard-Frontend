import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/data/model/card_model.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/get_card.dart';
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
    final cachedCards = ref.watch(cachedCardsProvider);

    // Find the matching card (regardless of index)
    final matchingCard = cachedCards
        .expand((getCard) => getCard.payload?.cards ?? [])
        .firstWhere(
          (card) => card.id == cardId,
          orElse: () => null,
        );

    if (matchingCard == null) {
      return const Scaffold(
        body: Center(
          child: Text("Card not found in cache."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("View Card")),
      body: buildCardContent(matchingCard),
    );
  }

  Widget buildCardContent(GetCard card) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Name: ${card.payload?.cards?.first.firstName} ${card.payload?.cards?.first.lastName}"),
          Text(
              "Email: ${card.payload?.cards?.first.contactInfo?.email ?? 'N/A'}"),
          Text(
              "Phone: ${card.payload?.cards?.first.contactInfo?.phone ?? 'N/A'}"),
        ],
      ),
    );
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
