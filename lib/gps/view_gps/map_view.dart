import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_dashboard/gps/blocs/blocs.dart';
import 'package:web_dashboard/theme/map_style.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;

  const MapView({super.key, 
  required this.initialLocation
  });

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 15
      );

      final size = MediaQuery.of(context).size;

      return SizedBox(
        width: size.width,
        height: size.height,
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          style: jsonEncode(mapStyleTheme),
          onMapCreated: (controller) => mapBloc.add(OnMapInitializedEvent(controller)),
          ),
      );
  }
}