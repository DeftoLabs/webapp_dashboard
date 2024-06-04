part of 'gps_bloc.dart';

class GpsState extends Equatable {

  final bool isGpsEnabled;
  final bool isGpsPermissionGrated;

  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGrated,
  });

  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
  }) => GpsState(
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled, 
    isGpsPermissionGrated: isGpsPermissionGrated
    );
  
  @override
  List<Object> get props => [ isGpsEnabled, isGpsPermissionGrated ];
}


