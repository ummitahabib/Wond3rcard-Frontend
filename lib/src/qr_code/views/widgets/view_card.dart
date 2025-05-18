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
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/qr_code/views/widgets/barcode_widget.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

class ViewCard extends HookConsumerWidget {
  const ViewCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.read(profileProvider);
    final cardController = ref.watch(cardProvider);
    final ExportDelegate exportDelegate = ExportDelegate();
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          if (profileController.profileData == null) {
            Future.delayed(Duration.zero, () async {
              await profileController.getProfile(context);
              await ref.read(cardProvider).getAUsersCard(context, '');
            });
          }
        });
        return null;
      },
      [],
    );

    SizeConfig.init(context);

    final ScreenshotController _screenshotController = ScreenshotController();

    Future<void> _saveAsImage(BuildContext context) async {
      final image = await _screenshotController.capture();
      if (image == null) return;

      final status = await Permission.storage.request();
      if (status.isGranted) {
        final directory = await getExternalStorageDirectory();
        final imagePath =
            '${directory!.path}/${cardController.cardModel?.cardName ?? ''}_card.png';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(image);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image saved successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
      }
    }

    Future<void> _saveToContacts(BuildContext context) async {
      final permission = await Permission.contacts.request();
      if (!permission.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Contacts permission denied")),
        );
        return;
      }

      // final contact = Contact(
      //   givenName: userData.name,
      //   company: userData.company,
      //   jobTitle: userData.title,
      //   phones: [Item(label: 'mobile', value: userData.phone)],
      //   emails: [Item(label: 'work', value: userData.email)],
      // );

      // await ContactsService.addContact(contact);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contact saved to phone")),
      );
    }

    Future<void> _saveAsPDF(BuildContext context) async {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage permission denied")),
        );
        return;
      }

      final pdfDocument =
          await exportDelegate.exportToPdfDocument('card_frame');
      final pdfBytes = await pdfDocument.save();

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/exported_card.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Card exported as PDF")),
      );
    }

    void _showDownloadOptions(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Download Options'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("Save as Image"),
                  onTap: () async {
                    Navigator.of(context).pop(); // Close dialog
                    await _saveAsImage(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: const Text("Export as PDF"),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _saveAsPDF(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_page),
                  title: const Text("Save Contact"),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _saveToContacts(context);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'View Card',
          style: WonderCardTypography.boldTextH5(
            fontSize: 23,
            color: AppColors.defaultWhite,
          ),
        ),
        backgroundColor: AppColors.primaryShade,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.defaultWhite,
          ),
          onPressed: () {
            context.go(RouteString.shareCardLink);
          },
        ),
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: AppColors.primaryShade,
        child: IconButton(
          icon: Icon(Icons.download, color: AppColors.defaultWhite),
          onPressed: () => _showDownloadOptions(context),
        ),
      ),
      body: ExportFrame(
        frameId: 'card_frame',
        exportDelegate: exportDelegate,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(SizeConfig.w(10)),
            margin: EdgeInsets.all(SizeConfig.w(10)),
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
                              Text(
                                'Learnoch Edu',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Personalized Learning AI ',
                                style: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffDAB6FF)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.h(30),
                      ),
                      CustomStyledContainer(),
                      Text(
                        'MUHAMMAD',
                        style: TextStyle(
                          fontFamily: 'Barlow',
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          color: Color(0xff6D41CA),
                        ),
                      ),
                      Text(
                        'Garba wudil',
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
                        'UIUX DESIGNER',
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
                        children: [
                          Expanded(
                              child:
                                  ShareCardWithBarCode2(cardId: emptyString)),
                          SizedBox(
                            height: SizeConfig.w(8),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                viewCardRow(
                                  HeroIcons.phone,
                                  '000-123-456-7890',
                                ),
                                SizedBox(
                                  height: SizeConfig.h(5),
                                ),
                                viewCardRow(
                                  HeroIcons.envelope,
                                  'email@yourdomain.com',
                                ),
                                SizedBox(
                                  height: SizeConfig.h(5),
                                ),
                                viewCardRow(
                                  HeroIcons.map,
                                  '125 Street, USA',
                                ),
                              ],
                            ),
                          )
                        ],
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
    );
  }

  Widget viewCardRow(HeroIcons icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SizedBox(
            width: SizeConfig.w(10),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryShade,
              child: HeroIcon(
                icon,
                color: AppColors.defaultWhite,
                size: 10,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomStyledContainer extends StatelessWidget {
  const CustomStyledContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.w(150),
      height: SizeConfig.h(150),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.profile),
          fit: BoxFit.cover,
        ),
        color: const Color(0xFFADADAD),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white,
          width: SizeConfig.w(3.32),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 0.55),
            blurRadius: 1.66,
          ),
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 0.55),
            blurRadius: 1.11,
          ),
        ],
      ),
    );
  }
}
