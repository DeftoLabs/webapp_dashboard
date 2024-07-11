import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_dashboard/models/usuario.dart';
import 'package:web_dashboard/providers/providers.dart';

part 'userlocation_event.dart';
part 'userlocation_state.dart';

class UserlocationBloc extends Bloc<UserlocationEvent, UserlocationState> {

  final UsersProvider userProvider;
  Timer? _timer;

  UserlocationBloc({required this.userProvider}) : super(const UserlocationState()) {
      on<FetchUserLocations>(_onFetchUserLocations);

      _startFetchingUserLocations();
  }
  
  void _onFetchUserLocations( FetchUserLocations event, Emitter<UserlocationState> emit) async {
    try{
      emit(UserLocationLoadInProgress());
      final users = await userProvider.users;
      emit(UserLocationLoadSucess(users));
    } catch (_) {
      emit(UserLocationLoadFailure());
    }
  }

  void _startFetchingUserLocations() {
    _timer = Timer.periodic( const Duration(minutes: 1), (timer) {
      add(FetchUserLocations());
    });
  }

    @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

}

