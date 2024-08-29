

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
      content: Text(message, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20), )
      );

   messegerKey.currentState!.showSnackBar(snackBar);   

  }

  static showBusyIndicator (BuildContext context ) {
    AlertDialog dialog =  AlertDialog(
      content: SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Column(
            children: [
              Text('Wait ....', style: GoogleFonts.plusJakartaSans(fontSize: 16),),
              const SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.pink[300], strokeWidth: 2),
            ],
          ),
        ),
      ),
    );

    showDialog(context: context, builder: (_) => dialog);
  }

}