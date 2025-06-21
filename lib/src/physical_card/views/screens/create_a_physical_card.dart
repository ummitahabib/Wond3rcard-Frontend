import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:wond3rcard/src/physical_card/data/controller/physical_card_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wond3rcard/src/cards/data/controller/card_template_controller.dart';
import 'package:wond3rcard/src/cards/data/controller/order_physical_card_controller.dart';
import 'package:wond3rcard/src/cards/views/widgets/list_of_dropdown.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CreatePhysicalCardScreenSection extends HookConsumerWidget {
  const CreatePhysicalCardScreenSection({
    super.key,
    required this.userId,
    required this.cardId,
  });

  final String userId;
  final String cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    final templatesAsync = ref.watch(templateListProvider);
    final selectedCard = ref.watch(selectedCardProvider);
    final profileController = ref.watch(profileProvider);

    // Track selected template index for UI and logic
    final selectedIndex = useState<int?>(null);

    return templatesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (templates) {
        return Scaffold(
          appBar: AppBar(),
          body:  Container()

          //temp
        
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Choose card',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Color(0xFF4B4B4B),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Physical Card Design',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Color(0xFF402577),
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Choose Design from template',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Color(0xFF402577),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 height: 300,
//                 width: double.infinity,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.all(10),
//                   itemCount: templates.length,
//                   separatorBuilder: (_, __) => const SizedBox(width: 12),
//                   itemBuilder: (context, index) {
//                     final template = templates[index];
//                     return GestureDetector(
//                       onTap: () async {

//                         String cleanSvg(String svg) {
//   return svg
//     .replaceAll(RegExp(r'<filter[\s\S]*?</defs>'), '') // remove filter block
//     .replaceAll(RegExp(r'<clipPath[\s\S]*?</clipPath>'), ''); // remove clip paths
// }
//                         selectedIndex.value = index;

//                         try {
//                           final response =
//                               await http.get(Uri.parse(template.design));
//                           if (response.statusCode == 200) {
//                             final svgContent = response
//                                 .body; // This is the raw <svg>...</svg> string

//                             await ref
//                                 .read(physicalCardControllerProvider.notifier)
//                                 .createCard(
//                                   userId: userId,
//                                   cardId: cardId,
//                                   templateId: template.id,
//                                   primaryColor: "#FF5733",
//                                   secondaryColor: "#33FF57",
//                                   finalDesign:
//                                       cleanSvg(svgContent), // Now the cleaned SVG content is passed
//                                 );

//                             ref
//                                 .read(physicalCardProvider.notifier)
//                                 .setSelectedTemplate(template);
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text("Failed to load SVG content")),
//                             );
//                           }
//                         } catch (e) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text("Error: $e")),
//                           );
//                         }
//                       },
//                       child: Container(
//                         width: 200,
//                         margin: const EdgeInsets.all(10),
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: selectedIndex.value == index
//                                 ? Colors.green
//                                 : Colors.grey.shade300,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: template.design.isNotEmpty
//                                   ? ClipRRect(
//                                       borderRadius: BorderRadius.circular(12),
//                                       child: Stack(
//                                         children: [
//                                           SvgPicture.network(
//                                             template.design,
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             height: SizeConfig.h(200),
//                                             fit: BoxFit.cover,
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                               left: SizeConfig.w(20),
//                                               right: SizeConfig.w(20),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 // Company Info (Left Side)
//                                                 Expanded(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.all(
//                                                         SizeConfig.w(10)),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: [
//                                                         Image.network(
//                                                           selectedCard
//                                                                   ?.cardPictureUrl ??
//                                                               ImageAssets
//                                                                   .profile,
//                                                           width:
//                                                               SizeConfig.w(24),
//                                                           height:
//                                                               SizeConfig.h(24),
//                                                         ),
//                                                         Text(
//                                                           profileController
//                                                                   .profileData
//                                                                   ?.payload
//                                                                   .profile
//                                                                   .companyName ??
//                                                               emptyString,
//                                                           style:
//                                                               const TextStyle(
//                                                             fontFamily: 'Inter',
//                                                             fontWeight:
//                                                                 FontWeight.w800,
//                                                             fontSize: 14,
//                                                             color: Colors.black,
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                             height:
//                                                                 SizeConfig.h(
//                                                                     6)),
//                                                         Text(
//                                                           '${selectedCard?.firstName ?? emptyString} ${selectedCard?.lastName ?? emptyString}',
//                                                           style:
//                                                               const TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontSize: 16,
//                                                             color: Color(
//                                                                 0xff3B82F6),
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                             height:
//                                                                 SizeConfig.h(
//                                                                     6)),
//                                                         Text(
//                                                           selectedCard
//                                                                   ?.designation ??
//                                                               emptyString,
//                                                           style:
//                                                               const TextStyle(
//                                                             fontSize: 10,
//                                                             color: Color(
//                                                                 0xff3B82F6),
//                                                             fontWeight:
//                                                                 FontWeight.w700,
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                             height:
//                                                                 SizeConfig.h(
//                                                                     17)),
//                                                         const HeroIcon(
//                                                           HeroIcons.qrCode,
//                                                           size: 30,
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const Spacer(),
//                                                 Expanded(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(
//                                                       top: SizeConfig.h(10),
//                                                       bottom: SizeConfig.h(10),
//                                                     ),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         const Text(
//                                                           'Address',
//                                                           style: TextStyle(
//                                                             fontSize: 14,
//                                                             color: Colors.black,
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                             height:
//                                                                 SizeConfig.h(
//                                                                     8)),
//                                                         Container(
//                                                           height: 3,
//                                                           color: const Color(
//                                                               0xff3B82F6),
//                                                         ),
//                                                         SizedBox(
//                                                             height:
//                                                                 SizeConfig.h(
//                                                                     5)),
//                                                         viewPhysicalCardChildren(
//                                                           icon: HeroIcons.phone,
//                                                           text: selectedCard
//                                                                   ?.contactInfo
//                                                                   ?.phone ??
//                                                               emptyString,
//                                                         ),
//                                                         viewPhysicalCardChildren(
//                                                           icon: HeroIcons
//                                                               .envelope,
//                                                           text: selectedCard
//                                                                   ?.contactInfo
//                                                                   ?.email ??
//                                                               emptyString,
//                                                         ),
//                                                         viewPhysicalCardChildren(
//                                                           icon:
//                                                               HeroIcons.mapPin,
//                                                           text:
//                                                               '${selectedCard?.contactInfo?.addresses ?? emptyString}',
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : const Center(child: Icon(Icons.image)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 template.name,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 30),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Selected Design Preview',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                     color: Color(0xFF4B4B4B),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: ref
//                             .watch(physicalCardProvider)
//                             .selectedTemplate
//                             ?.design
//                             .isNotEmpty ==
//                         true
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Stack(
//                           children: [
//                             SvgPicture.network(
//                               ref
//                                   .watch(physicalCardProvider)
//                                   .selectedTemplate!
//                                   .design,
//                               placeholderBuilder: (context) => const Center(
//                                   child: CircularProgressIndicator()),
//                               width: MediaQuery.of(context).size.width,
//                               height: SizeConfig.h(200),
//                               fit: BoxFit.cover,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                 left: SizeConfig.w(20),
//                                 right: SizeConfig.w(20),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Expanded(
//                                     child: Padding(
//                                       padding: EdgeInsets.all(SizeConfig.w(10)),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Image.network(
//                                             selectedCard?.cardPictureUrl ??
//                                                 ImageAssets.profile,
//                                             width: SizeConfig.w(24),
//                                             height: SizeConfig.h(24),
//                                           ),
//                                           Text(
//                                             profileController
//                                                     .profileData
//                                                     ?.payload
//                                                     .profile
//                                                     .companyName ??
//                                                 emptyString,
//                                             style: const TextStyle(
//                                               fontFamily: 'Inter',
//                                               fontWeight: FontWeight.w800,
//                                               fontSize: 14,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(height: SizeConfig.h(6)),
//                                           Text(
//                                             '${selectedCard?.firstName ?? emptyString} ${selectedCard?.lastName ?? emptyString}',
//                                             style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16,
//                                               color: Color(0xff3B82F6),
//                                             ),
//                                           ),
//                                           SizedBox(height: SizeConfig.h(6)),
//                                           Text(
//                                             selectedCard?.designation ??
//                                                 emptyString,
//                                             style: const TextStyle(
//                                               fontSize: 10,
//                                               color: Color(0xff3B82F6),
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                           SizedBox(height: SizeConfig.h(17)),
//                                           const HeroIcon(
//                                             HeroIcons.qrCode,
//                                             size: 30,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const Spacer(),
//                                   Expanded(
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         top: SizeConfig.h(10),
//                                         bottom: SizeConfig.h(10),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           const Text(
//                                             'Address',
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(height: SizeConfig.h(8)),
//                                           Container(
//                                             height: 3,
//                                             color: const Color(0xff3B82F6),
//                                           ),
//                                           SizedBox(height: SizeConfig.h(5)),
//                                           viewPhysicalCardChildren(
//                                             icon: HeroIcons.phone,
//                                             text: selectedCard
//                                                     ?.contactInfo?.phone ??
//                                                 emptyString,
//                                           ),
//                                           viewPhysicalCardChildren(
//                                             icon: HeroIcons.envelope,
//                                             text: selectedCard
//                                                     ?.contactInfo?.email ??
//                                                 emptyString,
//                                           ),
//                                           viewPhysicalCardChildren(
//                                             icon: HeroIcons.mapPin,
//                                             text:
//                                                 '${selectedCard?.contactInfo?.addresses ?? emptyString}',
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : const Center(child: Text('No preview available')),
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
    
    
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
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xff3B82F6),
          ),
          child: HeroIcon(
            icon,
            color: AppColors.defaultWhite,
            size: 16,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            fontSize: 8,
          ),
        ),
      ],
    );
  }
}
