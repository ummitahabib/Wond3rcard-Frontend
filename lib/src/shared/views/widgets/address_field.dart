import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/shared/data/controller/shared_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/map_screen.dart';
import 'package:wond3rcard/src/utils/util.dart';

class AddressField extends StatefulHookConsumerWidget {
  @override
  _AddressFieldState createState() => _AddressFieldState();
}

class _AddressFieldState extends ConsumerState<AddressField> {
  Future<void> _openMap() async {
    LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(),
      ),
    );

    if (pickedLocation != null) {
      final cardController = ref.watch(cardProvider);
      final addressController = cardController.contactInfoAddress;

      setState(() {
        addressController.text = fetchingAddressText;
      });

      final sharedController = ref.read(sharedProvider);
      String address = await sharedController.getAddressFromCoordinates(
        pickedLocation.latitude,
        pickedLocation.longitude,
      );
      setState(() {
        addressController.text = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardController = ref.watch(cardProvider);
    final _addressController = cardController.contactInfoAddress;
    return Column(
      children: [
        TextField(
          
          controller: _addressController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grayScale50),
              borderRadius: BorderRadius.circular(size8),
            ),
            labelText: enterAddressOrSelectMap,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.map,
                color: AppColors.primaryShade,
              ),
              onPressed: _openMap,
            ),
          ),
          
        ),
      ],
    );
  }
}
