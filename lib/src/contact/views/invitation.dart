// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:provider/provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/rendering.dart';
// import 'dart:ui' as ui;
// import 'package:contacts_service/contacts_service.dart';
// import 'package:share_plus/share_plus.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//     final directory = await getApplicationDocumentsDirectory();
//   await [
//     Permission.camera,
//     Permission.contacts,
//     Permission.storage,
//   ].request();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ScanProvider(),
//       child: MaterialApp(
//         title: 'Barcode Scanner',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//           useMaterial3: true,
//         ),
//         home: const HomeScreen(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }

// class ContactInfo {
//   final String name;
//   final String phone;
//   final String email;
//   final String organization;
//   final String barcode;

//   ContactInfo({
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.organization,
//     required this.barcode,
//   });

//   // Factory constructor to parse barcode data
//   factory ContactInfo.fromBarcode(String barcodeData) {
//     try {
//       // Attempt to parse structured data if available
//       if (barcodeData.contains(";") || barcodeData.contains(":")) {
//         // This is a simple parser, you may need to adjust based on your barcode format
//         Map<String, String> data = {};

//         // Try to parse semicolon or colon separated data
//         final pairs = barcodeData.split(RegExp(r'[;:]'));
//         for (var pair in pairs) {
//           final keyValue = pair.split('=');
//           if (keyValue.length == 2) {
//             data[keyValue[0].trim().toLowerCase()] = keyValue[1].trim();
//           }
//         }

//         return ContactInfo(
//           name: data['name'] ?? data['n'] ?? "Unknown Name",
//           phone: data['phone'] ?? data['tel'] ?? data['p'] ?? "No Phone",
//           email: data['email'] ?? data['e'] ?? "No Email",
//           organization: data['org'] ??
//               data['organization'] ??
//               data['o'] ??
//               "Unknown Organization",
//           barcode: barcodeData,
//         );
//       }

//       // If no structured data, use the barcode as an ID and provide default values
//       return ContactInfo(
//         name: "Contact from Barcode",
//         phone: "N/A",
//         email: "N/A",
//         organization: "Scanned on ${DateTime.now().toString().split(' ')[0]}",
//         barcode: barcodeData,
//       );
//     } catch (e) {
//       debugPrint("Error parsing barcode: $e");
//       // Fallback to default values if parsing fails
//       return ContactInfo(
//         name: "Unknown Contact",
//         phone: "N/A",
//         email: "N/A",
//         organization: "Scan Error",
//         barcode: barcodeData,
//       );
//     }
//   }
// }

// class ScanProvider with ChangeNotifier {
//   ContactInfo? _contactInfo;
//   String? _lastScannedBarcode;
//   bool _isProcessing = false;

//   ContactInfo? get contactInfo => _contactInfo;
//   String? get lastScannedBarcode => _lastScannedBarcode;
//   bool get isProcessing => _isProcessing;

//   void setScannedBarcode(String barcode) {
//     if (barcode.isEmpty || barcode == '-1') {
//       return; // Don't process empty or canceled scans
//     }

//     _isProcessing = true;
//     notifyListeners();

//     try {
//       _lastScannedBarcode = barcode;
//       _contactInfo = ContactInfo.fromBarcode(barcode);
//       debugPrint("Barcode processed successfully: $barcode");
//     } catch (e) {
//       debugPrint("Error processing barcode: $e");
//     } finally {
//       _isProcessing = false;
//       notifyListeners();
//     }
//   }

//   Future<String> saveContactAsImage(GlobalKey key) async {
//     try {
//       _isProcessing = true;
//       notifyListeners();

//       // Check if context is available
//       if (key.currentContext == null) {
//         throw Exception("Widget context is not available");
//       }

//       // Find the RenderRepaintBoundary
//       RenderRepaintBoundary boundary =
//           key.currentContext!.findRenderObject() as RenderRepaintBoundary;

//       // Convert to image
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);

//       if (byteData != null) {
//         Uint8List pngBytes = byteData.buffer.asUint8List();

//         // Get the directory for storing files
//         final directory = await getApplicationDocumentsDirectory();
//         final fileName =
//             'contact_card_${DateTime.now().millisecondsSinceEpoch}.png';
//         final filePath = '${directory.path}/$fileName';

//         // Write file
//         File file = File(filePath);
//         await file.writeAsBytes(pngBytes);

//         debugPrint("Image saved to: $filePath");
//         return filePath;
//       }
//       throw Exception('Failed to get image data');
//     } catch (e) {
//       debugPrint("Error saving image: $e");
//       rethrow;
//     } finally {
//       _isProcessing = false;
//       notifyListeners();
//     }
//   }

//   void clearContact() {
//     _contactInfo = null;
//     _lastScannedBarcode = null;
//     notifyListeners();
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool _isScanning = false;

//   Future<void> _scanBarcode(BuildContext context) async {
//     if (_isScanning) return; // Prevent multiple scan attempts

//     setState(() {
//       _isScanning = true;
//     });

//     try {
//       // Check camera permission
//       PermissionStatus status = await Permission.camera.status;
//       if (!status.isGranted) {
//         status = await Permission.camera.request();
//         if (!status.isGranted) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Camera permission is required')),
//             );
//           }
//           return;
//         }
//       }

//       // Start barcode scan
//       debugPrint("Starting barcode scan...");
//       String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#FF6666',
//         'Cancel',
//         true,
//         ScanMode.DEFAULT,
//       );

//       debugPrint("Scan result: $barcodeScanRes");

//       // Check if scan was canceled
//       if (barcodeScanRes == '-1' || !mounted) {
//         debugPrint("Scan canceled or context is not mounted");
//         return;
//       }

//       // Process the barcode data
//       if (barcodeScanRes.isNotEmpty) {
//         debugPrint("Processing barcode: $barcodeScanRes");
//         Provider.of<ScanProvider>(context, listen: false)
//             .setScannedBarcode(barcodeScanRes);

//         if (mounted) {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const ResultScreen()));
//         }
//       }
//     } catch (e) {
//       debugPrint("Error during scan: $e");
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error scanning: ${e.toString()}')),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isScanning = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Barcode Scanner'),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.qr_code_scanner,
//               size: 120,
//               color: Colors.blue,
//             ),
//             const SizedBox(height: 40),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 32),
//               child: Text(
//                 'Scan a barcode to store contact information or generate a digital ID card',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             _isScanning
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton.icon(
//                     onPressed: () => _scanBarcode(context),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text('SCAN BARCODE'),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 32, vertical: 16),
//                       textStyle: const TextStyle(fontSize: 18),
//                     ),
//                   ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: () {
//                 // Demo data - commonly formatted vCard-like data
//                 Provider.of<ScanProvider>(context, listen: false).setScannedBarcode(
//                     "name=John Doe;phone=+1234567890;email=john@example.com;org=Example Corp");
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ResultScreen()),
//                 );
//               },
//               child: const Text('Try with Demo Data'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResultScreen extends StatelessWidget {
//   const ResultScreen({super.key});

//   // Save contact to device
//   Future<void> _saveContact(BuildContext context, ContactInfo info) async {
//     final status = await Permission.contacts.request();

//     if (status.isGranted) {
//       try {
//         final contact = Contact(
//           givenName: info.name,
//           phones: [Item(label: 'mobile', value: info.phone)],
//           emails: [Item(label: 'work', value: info.email)],
//           company: info.organization,
//         );

//         await ContactsService.addContact(contact);

//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Contact saved successfully')),
//           );
//         }
//       } catch (e) {
//         debugPrint("Error saving contact: $e");
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error saving contact: $e')),
//           );
//         }
//       }
//     } else {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Contact permission denied')),
//         );
//       }
//     }
//   }

//   // Save as ID card
//   Future<void> _saveAsIdCard(BuildContext context, GlobalKey cardKey) async {
//     try {
//       final provider = Provider.of<ScanProvider>(context, listen: false);
//       final filePath = await provider.saveContactAsImage(cardKey);

//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text('ID card saved successfully'),
//             action: SnackBarAction(
//               label: 'SHARE',
//               onPressed: () => Share.shareXFiles([XFile(filePath)]),
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint("Error saving ID card: $e");
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error saving ID card: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ScanProvider>(context);
//     final contactInfo = provider.contactInfo;

//     // For capturing the card as image
//     final GlobalKey cardKey = GlobalKey();

//     if (contactInfo == null) {
//       return const Scaffold(
//         body: Center(child: Text('No barcode data available')),
//       );
//     }

//     debugPrint("Displaying result for barcode: ${contactInfo.barcode}");

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan Result'),
//         backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//       ),
//       body: provider.isProcessing
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // ID Card preview
//                   RepaintBoundary(
//                     key: cardKey,
//                     child: Card(
//                       elevation: 8,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Container(
//                         padding: const EdgeInsets.all(24),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const CircleAvatar(
//                               radius: 50,
//                               backgroundColor: Colors.blue,
//                               child: Icon(Icons.person,
//                                   size: 60, color: Colors.white),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               contactInfo.name,
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               contactInfo.organization,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             const Divider(height: 30),
//                             _buildInfoRow(Icons.phone, contactInfo.phone),
//                             const SizedBox(height: 12),
//                             _buildInfoRow(Icons.email, contactInfo.email),
//                             const SizedBox(height: 20),
//                             // Display the barcode value
//                             Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black12),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 'ID: ${contactInfo.barcode}',
//                                 style: const TextStyle(
//                                   fontFamily: 'monospace',
//                                   fontSize: 16,
//                                 ),
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   // Action buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () => _saveContact(context, contactInfo),
//                         icon: const Icon(Icons.contacts),
//                         label: const Text('Save Contact'),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 12),
//                         ),
//                       ),
//                       ElevatedButton.icon(
//                         onPressed: () => _saveAsIdCard(context, cardKey),
//                         icon: const Icon(Icons.image),
//                         label: const Text('Save as ID Card'),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 12),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           onPressed: () {
//                             // Clear current scan and go back to home
//                             provider.clearContact();
//                             Navigator.pop(context);
//                           },
//                           icon: const Icon(Icons.refresh),
//                           label: const Text('Scan Another'),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Raw barcode data for debugging
//                   const SizedBox(height: 24),
//                   const Text('Raw Barcode Data:',
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 4),
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       contactInfo.barcode,
//                       style: const TextStyle(fontFamily: 'monospace'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.blue),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // pubspec.yaml - Make sure to include these dependencies in your pubspec.yaml file:
// /*
// name: barcode_scanner_app
// description: A Flutter app that scans barcodes and saves data as contacts or digital ID cards.
// publish_to: 'none'
// version: 1.0.0+1

// environment:
//   sdk: ">=2.19.0 <4.0.0"

// dependencies:
//   flutter:
//     sdk: flutter
//   cupertino_icons: ^1.0.5
//   flutter_barcode_scanner: ^2.0.0  # For scanning barcodes
//   path_provider: ^2.1.1            # For file operations
//   image: ^4.0.17                   # For image processing
//   contacts_service: ^0.6.3         # For contacts operations
//   permission_handler: ^10.2.0      # For handling permissions
//   share_plus: ^7.0.2               # For sharing files
//   provider: ^6.0.5                 # For state management

// dev_dependencies:
//   flutter_test:
//     sdk: flutter
//   flutter_lints: ^2.0.1

// flutter:
//   uses-material-design: true
// */
