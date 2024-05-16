import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class Map extends ConsumerStatefulWidget {
  const Map({super.key});

  @override
  ConsumerState<Map> createState() => _MapState();
}

class _MapState extends ConsumerState<Map> {
  late BattleViewModel viewModel;
  late GoogleMapController mapController;
  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() async {
    if (viewModel.points.length < 2) return;
    LatLng point1 = viewModel.points.first;
    LatLng point2 = viewModel.points.last;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        point1.latitude < point2.latitude ? point1.latitude : point2.latitude,
        point1.longitude < point2.longitude
            ? point1.longitude
            : point2.longitude,
      ),
      northeast: LatLng(
        point1.latitude > point2.latitude ? point1.latitude : point2.latitude,
        point1.longitude > point2.longitude
            ? point1.longitude
            : point2.longitude,
      ),
    );

    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    viewModel.imageBytes = await widgetsToImageController.capture();

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
      child: WidgetsToImage(
        controller: widgetsToImageController,
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
      ),
    );
  }
}
