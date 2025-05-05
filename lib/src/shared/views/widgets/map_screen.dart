import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:wond3rcard/src/shared/data/controller/shared_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class MapScreen extends StatefulHookConsumerWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(9.0800128, 7.4481664);
  LatLng? _pickedLocation;
  TextEditingController _searchController = TextEditingController();
  String _selectedAddress = searchForPlaceText;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  void _onMapTap(LatLng location) async {
    setState(() {
      _pickedLocation = location;
      _selectedAddress = fetchingAddressText;
    });

    final sharedController = ref.read(sharedProvider);
    String address = await sharedController.getAddressFromCoordinates(
        location.latitude, location.longitude);

    setState(() {
      _selectedAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sharedController = ref.read(sharedProvider);
    return Scaffold(
      appBar: AppBar(
          title: Text(searchAndSelectLocationText,
              style: WonderCardTypography.boldTextH5(
                  color: AppColors.grayScale,
                  fontSize: SpacingConstants.size23))),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: size25,
            ),
            onMapCreated: (controller) {
              setState(() {
                _mapController = controller;
              });
            },
            onTap: _onMapTap,
            markers: _pickedLocation != null
                ? {
                    Marker(
                      markerId: MarkerId("selected"),
                      position: _pickedLocation!,
                    )
                  }
                : {},
          ),
          Positioned(
            top: size20,
            left: size25,
            right: size15,
            child: Column(
              children: [
                GooglePlaceAutoCompleteTextField(
                  textEditingController: _searchController,
                  googleAPIKey: sharedController.googleApiKey,
                  inputDecoration: InputDecoration(
                    hintText: searchForPlaceText,
                    fillColor: AppColors.defaultWhite,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size8),
                    ),
                  ),
                  debounceTime: SpacingConstants.int400,
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (prediction) async {
                    print("Selected: ${prediction.description}");
                    setState(() {
                      _selectedAddress = prediction.description!;
                      _searchController.text = _selectedAddress;
                    });

                    if (prediction.lat != null && prediction.lng != null) {
                      LatLng newLocation = LatLng(double.parse(prediction.lat!),
                          double.parse(prediction.lng!));
                      _mapController
                          ?.animateCamera(CameraUpdate.newLatLng(newLocation));
                      setState(() {
                        _pickedLocation = newLocation;
                      });
                    }
                  },
                  itemClick: (prediction) {
                    _searchController.text = prediction.description!;
                  },
                ),
                SizedBox(height: size10),
                Container(
                  padding: EdgeInsets.all(size10),
                  decoration: BoxDecoration(
                    color: AppColors.defaultWhite,
                    borderRadius: BorderRadius.circular(size8),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: size5),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.redDisable),
                      SizedBox(width: size8),
                      Expanded(
                        child: Text(
                          _selectedAddress,
                          maxLines: int2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (_pickedLocation != null) {
            Navigator.pop(context, _pickedLocation);
          }
        },
      ),
    );
  }
}
