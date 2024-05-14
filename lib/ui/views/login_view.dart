import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/buttons/link_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding:const EdgeInsets.symmetric(horizontal: 20),
      child: Center (
        child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 370),
        child: Form(
          child: Column(
            children: [

              // Email
              TextFormField(
                // validator: (),
                style: const TextStyle(color: Colors.white),
                decoration: buildInputDecoration(
                  hint: 'Enter your email',
                  label: 'Email',
                  icon: Icons.email_outlined,
                ),
              ),
                const SizedBox(height: 20),
                // Password
                TextFormField(
                // validator: (),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: buildInputDecoration(
                  hint: 'Enter your password',
                  label: 'Password',
                  icon: Icons.lock_outline_rounded,
                ),
              ),
             const SizedBox(height: 20),
             LinkText(text: 'New Account',
             onPressed: () {
              // TODO: New Account
             },)

            ],
          ))
        ),)
    );
  }

  InputDecoration buildInputDecoration ({
    required String hint,
    required String label,
    required IconData icon,
  }){

    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.white.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
          hintText: hint,
          labelText: label,
          prefixIcon: Icon ( icon, color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.grey),
          hintStyle: const TextStyle( color: Colors.grey),

    );
  }
}