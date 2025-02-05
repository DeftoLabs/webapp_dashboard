import 'package:flutter/material.dart';




class CustomInputsRegisterUser {

   static InputDecoration loginInputDecoration ({
    required String hint,
    required String label,
    required IconData icon,
  }){

    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color:const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.3))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.3))),
          hintText: hint,
          labelText: label,
          prefixIcon: Icon ( icon, color: const Color.fromARGB(255, 0, 0, 0)),
          labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          hintStyle: const TextStyle( color: Color.fromARGB(255, 0, 0, 0)),

    );
  }

  static InputDecoration searchInputDecoration ({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
      labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      hintStyle: const TextStyle( color: Color.fromARGB(255, 0, 0, 0))
    );
  }

   static InputDecoration formInputDecoration ({
    required String hint,
    required String label,
    required IconData icon,
  }){

    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color:const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.3))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.3))),
          hintText: hint,
          labelText: label,
          prefixIcon: Icon ( icon, color: const Color.fromARGB(255, 0, 0, 0)),
          labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          hintStyle: const TextStyle( color: Color.fromARGB(255, 0, 0, 0)),

    );
  }
}