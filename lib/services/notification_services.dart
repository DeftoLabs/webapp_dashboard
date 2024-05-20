

import 'package:flutter/material.dart';

class NotificationService {

  static GlobalKey<ScaffoldMessengerState> messegerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBarError ( String message ) {

    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 20), )
      );

   messegerKey.currentState!.showSnackBar(snackBar);   

  }
   static showSnackBa ( String message ) {

    final snackBar = SnackBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
      content: Text(message, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20), )
      );

   messegerKey.currentState!.showSnackBar(snackBar);   

  }

}