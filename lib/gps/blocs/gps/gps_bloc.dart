import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super( const GpsState(isGpsEnabled: false, isGpsPermissionGrated: false))  {

    on<GpsAndPermissionEvent>((event, emit) => emit ( state.copyWith(
      isGpsEnabled: event.isGpsEnabled,
      isGpsPermissionGranted: event.isGpsPermissionGranted
    ) ));

  }
}