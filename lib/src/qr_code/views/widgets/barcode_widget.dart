import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/qr_code/data/controller/share_card_qr_controller.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';


class ShareCardWithBarCode2 extends ConsumerStatefulWidget {
  final String cardId;

  const ShareCardWithBarCode2({Key? key, required this.cardId})
      : super(key: key);

  @override
  ConsumerState<ShareCardWithBarCode2> createState() =>
      _ShareCardWithBarCode2State();
}

class _ShareCardWithBarCode2State extends ConsumerState<ShareCardWithBarCode2> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(shareCardQrControllerProvider.notifier).getQrCode(widget.cardId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final qrCodeState = ref.watch(shareCardQrControllerProvider);

    return Container(
      decoration: BoxDecoration(
        border: DashedBorder.all(
          color: AppColors.darkDisable,
          dashLength: 40,
          width: 2,
          isOnlyCorner: true,
          strokeAlign: BorderSide.strokeAlignInside,
          strokeCap: StrokeCap.round,
        ),
      ),
      child: qrCodeState.when(
        data: (qrData) => QrImageView(
          data: qrData,
          version: QrVersions.auto,
          gapless: false,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => QrImageView(
          data: "DUMMY_QR_CODE", 
          version: QrVersions.auto,
          gapless: false,
        ),
      ),
    );
  }
}
