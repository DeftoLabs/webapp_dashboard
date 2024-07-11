part of 'userlocation_bloc.dart';

class UserlocationState extends Equatable {
  const UserlocationState();
  
  @override
  List<Object> get props => [];
}

class UserLocationInitial extends UserlocationState{}

class UserLocationLoadInProgress extends UserlocationState{}

class UserLocationLoadSucess extends UserlocationState {
  final List<Usuario> users;

  const UserLocationLoadSucess([this.users = const []]);

    @override
  List<Object> get props => [users];

}

class UserLocationLoadFailure extends UserlocationState {}


