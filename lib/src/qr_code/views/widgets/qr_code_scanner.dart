import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends HookConsumerWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Scan QR Code',
          style: WonderCardTypography.boldTextH5(
            fontSize: 23,
            color: AppColors.defaultWhite,
          ),
        ),
        backgroundColor: AppColors.primaryShade,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            context.go(
              RouteString.shareCardLink,
            );
          },
        ),
      ),
      body: kIsWeb ? _buildWebScanner(context) : _buildMobileScanner(context),
    );
  }

  Widget _buildMobileScanner(BuildContext context) {
    return MobileScanner(
      onDetect: (capture) {
        final barcode = capture.barcodes.first;
        final String? rawData = barcode.rawValue;

        _handleScannedData(context, rawData);
      },
    );
  }

  Widget _buildWebScanner(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Web QR Scan (Upload QR Code Image)'),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.upload),
            label: const Text('Upload QR Code Image'),
            onPressed: () async {
              final picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                try {
                  final qrCode = await QrCodeToolsPlugin.decodeFrom(image.path);
                  _handleScannedData(context, qrCode);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to decode QR code')),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _handleScannedData(BuildContext context, String? rawData) {
    if (rawData == null) return;

    try {
      context.go(RouteString.viewCard);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid QR code data')),
      );
    }
  }
}
