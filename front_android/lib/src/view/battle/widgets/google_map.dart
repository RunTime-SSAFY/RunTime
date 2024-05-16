import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends ConsumerStatefulWidget {
  const Map({super.key});

  @override
  ConsumerState<Map> createState() => _MapState();
}

class _MapState extends ConsumerState<Map> {
  late BattleViewModel viewModel;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    // viewModel.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(battleViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                viewModel.distanceService.lastPosition?.latitude ?? 37.5642135,
                viewModel.distanceService.lastPosition?.longitude ??
                    127.0016985,
              ),
              zoom: 17,
            ),
          ),
        );
      },
    );

    return Expanded(
      child: Center(
        child: GoogleMap(
          mapType: MapType.normal,
          mapToolbarEnabled: false,
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          compassEnabled: false,
          indoorViewEnabled: false,
          myLocationButtonEnabled: false,
          liteModeEnabled: true,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          buildingsEnabled: false,
          polylines: viewModel.polyLines,
          onTap: (argument) {
            return;
          },
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(
              37.5642135,
              127.0016985,
            ),
            zoom: 17,
          ),
        ),
      ),
    );
  }
}
