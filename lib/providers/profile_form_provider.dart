

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/profile.dart';

class ProfileFormProvider extends ChangeNotifier {

  Profile? profile;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validForm() {
    return formKey.currentState!.validate();
  }
}