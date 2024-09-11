import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/user_response.dart';
import 'package:web_dashboard/models/usuario.dart';



class UsersProvider extends ChangeNotifier {

  List <Usuario>users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  List<Usuario> _usersNoEnRutas = [];
  List<Usuario> get usersNoEnRutas => _usersNoEnRutas; 

  UsersProvider(){
    getPaginatedUsers();
  }

  getPaginatedUsers () async  {

    final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResp = UsersResponse.fromMap(resp);

    users = [...usersResp.usuarios];

    isLoading = false;

    notifyListeners();
  }


  Future <Usuario?> getUserById (String uid) async  {
    try {
    final resp = await CafeApi.httpGet('/usuarios/$uid');
    final user = Usuario.fromMap(resp);
    return user;
    } catch (e) {
      return null;
    }
  }


  void sort<T>( Comparable<T> Function (Usuario user) getField) {
    users.sort( (a , b) {
      final aValue = getField( a );
      final bValue = getField ( b );

      return ascending 
      ? Comparable.compare (aValue, bValue) 
      : Comparable.compare (bValue, aValue) ;
    });

    ascending = !ascending;
    notifyListeners();
  }

  void refreshUser ( Usuario newUser) {

   users = users.map(
    (user) {
      if (user.uid == newUser.uid) {
        user = newUser;
      }
      return user;
    }
   ).toList();


    notifyListeners();
  }

    Future<void> fetchUsers() async {
    final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResp = UsersResponse.fromMap(resp);
    users = usersResp.usuarios;
    notifyListeners();
  }

 Future<void> loadUsersNoEnRutas() async {
    try {
      final response = await CafeApi.httpGet('/rutas/usuarios/noenrutas');
      final List<Usuario> users = (response['usuarios'] as List)
          .map((user) => Usuario.fromMap(user))
          .toList();
      _usersNoEnRutas = users;
      notifyListeners();
    } catch (e) {
      print('Error loading users: $e');
    }
  }

}