import 'package:flutter/material.dart';


class CustomInput {

   static InputDecoration loginInputDecoration ({
    required String hint,
    required String label,
    required IconData icon,
  }){

    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.white.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // Borde redondeado cuando está enfocado
        borderSide: const BorderSide(color: Colors.white, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // Borde redondeado cuando hay error
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // Borde redondeado cuando está enfocado y hay error
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
          hintText: hint,
          labelText: label,
          prefixIcon: Icon ( icon, color: Colors.white),
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: const TextStyle( color: Colors.white),

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
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle( color: Colors.grey)
    );
  }

   static InputDecoration formInputDecoration ({
    required String hint,
    required String label,
    required IconData icon,
  }){

    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color:const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3))),
          hintText: hint,
          labelText: label,
          prefixIcon: Icon ( icon, color: const Color.fromARGB(255, 0, 0, 0)),
          labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          hintStyle: const TextStyle( color: Color.fromARGB(255, 0, 0, 0)),

    );
  }
}