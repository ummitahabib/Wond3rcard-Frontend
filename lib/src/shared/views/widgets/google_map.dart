import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/shared/data/controller/shared_controller.dart';

//sharedProvider

class GoogleMapScreen extends StatefulHookConsumerWidget {
  const GoogleMapScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GoogleMapScreenState();
}

class _GoogleMapScreenState extends ConsumerState<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    final shared = ref.watch(sharedProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Select Address')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: shared.selectedLocation,
              zoom: 14,
            ),
            onTap: (LatLng position) async {
              setState(() {
                shared.selectedLocation = position;
              });
              shared.address = await _getAddressFromLatLng(position);
            },
            markers: {
              Marker(
                markerId: const MarkerId('selected-location'),
                position: shared.selectedLocation,
                draggable: true,
                onDragEnd: (LatLng position) async {
                  shared.address = await _getAddressFromLatLng(position);
                },
              ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, shared.address); // Pass back the address
              },
              child: const Text('Select this Address'),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.country}';
      }
    } catch (e) {
      print(e);
    }
    return 'Unknown location';
  }
}
