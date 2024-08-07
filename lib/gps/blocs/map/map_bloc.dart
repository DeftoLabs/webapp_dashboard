

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  GoogleMapController? _mapController;

  MapBloc() : super(const MapState()) {


    on<OnMapInitializedEvent>(_onInitMap);

  }

  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit ){

    _mapController = event.controller;
    emit(state.copyWith( isMapInitialized: true ));

  }

  void moveCamera( LatLng newLocation) {

    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
    
  }

  void moveUserCamera( double lat, double lng) {
    final userLocation = LatLng(lat, lng);
    final cameraUpdate = CameraUpdate.newLatLng(userLocation);
    _mapController?.animateCamera(cameraUpdate);
  }


}
