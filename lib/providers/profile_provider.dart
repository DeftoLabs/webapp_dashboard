

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/profile_responde.dart';
import 'package:web_dashboard/models/profile.dart';


class ProfileProvider extends ChangeNotifier {

  Profile? profile;

  List <Profile> profiles = [];
  bool isLoading = true;


  ProfileProvider (){
    getProfile();
  }

 getProfile() async {
  final resp = await CafeApi.httpGet('/perfiles');
  final profileResp = ProfileResponse.fromMap(resp);
  profiles = [... profileResp.profile];
  isLoading = false;
  notifyListeners();
}

 Future<Profile?> getProfilById(String id) async {

  try {
  final resp = await CafeApi.httpGet('/perfiles/$id');
  final profile = Profile.fromMap(resp);
  return profile;

  } catch (e) {
    return null;
  }
}

void refreshProfile ( Profile newProfile) {

  profiles = profiles.map(
    (profile){
      if (profile.id == newProfile.id) {
        profile = newProfile;
      }
      return profile;
    }
  ).toList();

  notifyListeners();
  
}


}
