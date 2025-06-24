import 'dart:convert';
import 'dart:math' as math;
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
import 'package:wond3rcard/src/utils/util.dart';

//final selectedCardProvider = StateProvider<PhysicalCardModel?>((ref) => null);

class CreatePhysicalCardScreenSection extends HookConsumerWidget {
  const CreatePhysicalCardScreenSection({
    super.key,
    required this.userId,
    required this.cardId,
    required this.index,
  });

  final String userId;
  final String cardId;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    final templatesAsync = ref.watch(templateListProvider);
    final profileController = ref.watch(profileProvider);

    // Track selected template index for UI and logic
    final selectedIndex = useState<int?>(null);
    final isProcessing = useState<bool>(false);

    return templatesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (templates) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
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
                height: 300,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  itemCount: templates.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final template = templates[index];
                    return GestureDetector(
                      onTap: () async {
                        if (isProcessing.value) return; // Prevent multiple taps

                        selectedIndex.value = index;
                        isProcessing.value = true;

                        try {
                          String svgContent = '';

                          // Handle different design formats and clean SVG
                          if (template.design != null &&
                              template.design.isNotEmpty) {
                            if (template.design.startsWith('<svg')) {
                              // Already SVG format - clean and simplify it
                              svgContent =
                                  _cleanAndSimplifySvg(template.design);
                            } else if (template.design.startsWith('http')) {
                              // URL - fetch and convert to simple SVG
                              svgContent = await _fetchAndConvertToSimpleSvg(
                                  template.design);
                            } else {
                              // Other formats - use default SVG
                              svgContent = _getDefaultCardSvg();
                            }
                          } else {
                            // Empty design - use default SVG
                            svgContent = _getDefaultCardSvg();
                          }

                          if (svgContent.isNotEmpty) {
                            // Debug: Print the SVG being sent
                            print(
                                'Sending SVG: ${svgContent.substring(0, math.min(200, svgContent.length))}...');

                            await ref
                                .read(physicalCardControllerProvider.notifier)
                                .createCard(
                                  userId: userId,
                                  cardId: cardId,
                                  templateId: template.id ?? '',
                                  primaryColor: "#FF5733",
                                  secondaryColor: "#33FF57",
                                  finalDesign: svgContent,
                                );

                            // Update the template with cleaned SVG content for preview
                            final updatedTemplate =
                                template.copyWith(design: svgContent);
                            ref
                                .read(physicalCardProvider.notifier)
                                .setSelectedTemplate(updatedTemplate);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Card template selected successfully!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Failed to process template design"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          print('Error creating card: $e'); // Debug log
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Error creating card: ${e.toString()}"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } finally {
                          isProcessing.value = false;
                        }
                      },
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedIndex.value == index
                                ? Colors.green
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: _buildTemplatePreview(template, index,
                                      profileController, context),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    template.name ?? 'Unnamed Template',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            if (isProcessing.value &&
                                selectedIndex.value == index)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
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
                child: _buildSelectedTemplatePreview(
                    ref, index, profileController, context),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  // Clean and simplify complex SVG content
  String _cleanAndSimplifySvg(String svgContent) {
    try {
      // Remove carriage returns and normalize whitespace
      String cleaned = svgContent
          .replaceAll('\r\n', ' ')
          .replaceAll('\r', ' ')
          .replaceAll('\n', ' ')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();

      // Check if SVG is too complex (has filters, complex gradients, etc.)
      if (cleaned.contains('<filter') ||
          cleaned.contains('<feFlood') ||
          cleaned.contains('<feColorMatrix') ||
          cleaned.length > 2000) {
        // Extract basic dimensions and create simpler version
        final widthMatch = RegExp(r'width="(\d+)"').firstMatch(cleaned);
        final heightMatch = RegExp(r'height="(\d+)"').firstMatch(cleaned);
        final viewBoxMatch = RegExp(r'viewBox="([^"]*)"').firstMatch(cleaned);

        final width = widthMatch?.group(1) ?? '400';
        final height = heightMatch?.group(1) ?? '250';
        final viewBox = viewBoxMatch?.group(1) ?? '0 0 $width $height';

        // Create simplified version with card-like appearance
        return _createSimplifiedCardSvg(width, height, viewBox);
      }

      // If not too complex, just clean it
      return cleaned;
    } catch (e) {
      print('Error cleaning SVG: $e');
      return _getDefaultCardSvg();
    }
  }

  // Create a simplified card-like SVG
  String _createSimplifiedCardSvg(String width, String height, String viewBox) {
    return '''<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="$height" viewBox="$viewBox" fill="none"><rect width="100%" height="100%" rx="12" fill="url(#grad)"/><defs><linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" style="stop-color:#3B82F6;stop-opacity:1"/><stop offset="100%" style="stop-color:#1D4ED8;stop-opacity:1"/></linearGradient></defs><circle cx="85%" cy="15%" r="8%" fill="rgba(255,255,255,0.2)"/><rect x="5%" y="75%" width="40%" height="3%" rx="1.5%" fill="rgba(255,255,255,0.3)"/></svg>''';
  }

  // Helper method to fetch URL content and convert to simple SVG
  Future<String> _fetchAndConvertToSimpleSvg(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final content = response.body;

        // Check if it's already SVG
        if (content.trim().startsWith('<svg')) {
          return _cleanAndSimplifySvg(content);
        }

        // If it's not SVG, create a simple card SVG
        return _getDefaultCardSvg();
      }
    } catch (e) {
      print('Error fetching URL content: $e');
    }

    return _getDefaultCardSvg();
  }

  // Simple default card SVG similar to the expected format
  String _getDefaultCardSvg() {
    return '''<svg xmlns="http://www.w3.org/2000/svg" width="400" height="250" viewBox="0 0 400 250" fill="none"><rect width="400" height="250" rx="16" fill="#3B82F6"/><rect x="20" y="20" width="360" height="210" rx="12" fill="rgba(255,255,255,0.1)"/><circle cx="350" cy="50" r="20" fill="rgba(255,255,255,0.2)"/><rect x="20" y="180" width="120" height="8" rx="4" fill="rgba(255,255,255,0.3)"/><rect x="20" y="200" width="80" height="6" rx="3" fill="rgba(255,255,255,0.2)"/></svg>''';
  }

  Widget _buildTemplatePreview(dynamic template, dynamic selectedCard,
      dynamic profileController, BuildContext context) {
    if (template.design == null || template.design.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 50, color: Colors.grey),
            Text('No Design', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Show original design for preview (if URL)
          if (template.design.startsWith('http'))
            SvgPicture.network(
              template.design,
              width: MediaQuery.of(context).size.width,
              height: SizeConfig.h(200),
              fit: BoxFit.cover,
              placeholderBuilder: (context) => Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
            )
          else if (template.design.startsWith('<svg'))
            // For SVG content, show a simplified preview
            Container(
              width: MediaQuery.of(context).size.width,
              height: SizeConfig.h(200),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.credit_card,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            )
          else
            const Center(child: Icon(Icons.image)),

          // Card overlay with user info
          _buildCardOverlay(selectedCard, profileController, context),
        ],
      ),
    );
  }

  Widget _buildSelectedTemplatePreview(WidgetRef ref, dynamic selectedCard,
      dynamic profileController, BuildContext context) {
    final selectedTemplate = ref.watch(physicalCardProvider).selectedTemplate;

    if (selectedTemplate?.design?.isNotEmpty != true) {
      return const Center(child: Text('No preview available'));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: SizeConfig.h(200),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          _buildCardOverlay(selectedCard, profileController, context),
        ],
      ),
    );
  }

  Widget _buildCardOverlay(
      dynamic selectedCard, dynamic profileController, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.w(20),
        right: SizeConfig.w(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Company Info (Left Side)
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.w(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    selectedCard?.cardPictureUrl ?? ImageAssets.profile,
                    width: SizeConfig.w(24),
                    height: SizeConfig.h(24),
                  ),
                  Text(
                    profileController
                            .profileData?.payload.profile.companyName ??
                        emptyString,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: SizeConfig.h(6)),
                  Text(
                    '${selectedCard?.firstName ?? emptyString} ${selectedCard?.lastName ?? emptyString}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: SizeConfig.h(6)),
                  Text(
                    selectedCard?.designation ?? emptyString,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white70,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: SizeConfig.h(17)),
                  const HeroIcon(
                    HeroIcons.qrCode,
                    size: 30,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          // Contact Info (Right Side)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.h(10),
                bottom: SizeConfig.h(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.h(8)),
                  Container(
                    height: 2,
                    width: 60,
                    color: Colors.white70,
                  ),
                  SizedBox(height: SizeConfig.h(5)),
                  viewPhysicalCardChildren(
                    icon: HeroIcons.phone,
                    text: selectedCard?.contactInfo?.phone ?? emptyString,
                  ),
                  viewPhysicalCardChildren(
                    icon: HeroIcons.envelope,
                    text: selectedCard?.contactInfo?.email ?? emptyString,
                  ),
                  viewPhysicalCardChildren(
                    icon: HeroIcons.mapPin,
                    text:
                        '${selectedCard?.contactInfo?.addresses ?? emptyString}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white24,
          ),
          child: HeroIcon(
            icon,
            color: Colors.white,
            size: 12,
          ),
        ),
        SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 8,
              color: Colors.white70,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}




// class CreatePhysicalCardScreenSection extends HookConsumerWidget {
//   const CreatePhysicalCardScreenSection({
//     super.key,
//     required this.userId,
//     required this.cardId,
//   });

//   final String userId;
//   final String cardId;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     SizeConfig.init(context);

//     final templatesAsync = ref.watch(templateListProvider);
//     final selectedCard = ref.watch(selectedCardProvider);
//     final profileController = ref.watch(profileProvider);

//     // Track selected template index for UI and logic
//     final selectedIndex = useState<int?>(null);

//     return templatesAsync.when(
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stack) => Center(child: Text('Error: $error')),
//       data: (templates) {
//         return Scaffold(
//           appBar: AppBar(),
//           body: 
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

                      
//                         selectedIndex.value = index;

//                         try {
                         

//                             await ref
//                                 .read(physicalCardControllerProvider.notifier)
//                                 .createCard(
//                                   userId: userId,
//                                   cardId: cardId,
//                                   templateId: template.id,
//                                   primaryColor: "#FF5733",
//                                   secondaryColor: "#33FF57",
//                                   finalDesign: template.design
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
    
    
//         );
//       },
//     );
//   }

//   Row viewPhysicalCardChildren({
//     required String text,
//     required HeroIcons icon,
//   }) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           margin: const EdgeInsets.all(4),
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100),
//             color: const Color(0xff3B82F6),
//           ),
//           child: HeroIcon(
//             icon,
//             color: AppColors.defaultWhite,
//             size: 16,
//           ),
//         ),
//         Text(
//           text,
//           style: const TextStyle(
//             fontFamily: 'Inter',
//             fontWeight: FontWeight.w400,
//             fontStyle: FontStyle.italic,
//             fontSize: 8,
//           ),
//         ),
//       ],
//     );
//   }
// }
