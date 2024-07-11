import 'package:bloc/bloc.dart';
import '../../../providers/auth_provider.dart';
import '../location/location_bloc.dart';

class LocationBlocObserver extends BlocObserver {
  final AuthProvider authProvider;

  LocationBlocObserver(this.authProvider);

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    
    if (bloc is LocationBloc) {
      final newState = change.nextState as LocationState;
      final oldState = change.currentState as LocationState;
      
      if (newState.lastKnowLocation != oldState.lastKnowLocation) {
        
        print('Update Location: ${newState}');
      }
    }
  }
}