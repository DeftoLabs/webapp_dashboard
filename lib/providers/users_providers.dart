import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/user_response.dart';
import 'package:web_dashboard/models/usuaro.dart';



class UsersProvider extends ChangeNotifier {

  List <Usuario>users = [];
  bool isLoading = true;

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

}