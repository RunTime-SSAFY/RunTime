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

  void _onMapCreated(GoogleMapController controller) {
    viewModel.mapController = controller;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.stopCamera = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(battleViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (viewModel.stopCamera) {
          return;
        }
        try {
          viewModel.mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  viewModel.distanceService.lastPosition?.latitude ??
                      37.5642135,
                  viewModel.distanceService.lastPosition?.longitude ??
                      127.0016985,
                ),
                zoom: 17,
              ),
            ),
          );
        } catch (error) {
          debugPrint('이 로그는 한 번 무시하세요. 단, 한 번에 여러 개 뜨면 문제임');
        }
      },
    );

    return Expanded(
      child: WidgetsToImage(
        controller: viewModel.widgetsToImageController,
        child: Center(
          child: GoogleMap(
            mapType: MapType.normal,
            mapToolbarEnabled: false,
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            indoorViewEnabled: false,
            myLocationButtonEnabled: false,
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
