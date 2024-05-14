import 'package:flutter/material.dart';
import 'package:web_dashboard/router/router.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/buttons/link_text.dart';
import 'package:web_dashboard/ui/inputs/custom_inputs.dart';

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
                decoration: CustomInput.loginInputDecoration(
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
                decoration: CustomInput.loginInputDecoration(
                  hint: 'Enter your password',
                  label: 'Password',
                  icon: Icons.lock_outline_rounded,
                ),
              ),
             const SizedBox(height: 20),

             CustomOutlineButtom(
              onPressed: (){
              }, 
              text: 'Login'),


              const SizedBox(height: 20),
             LinkText(text: 'New Account',
             onPressed: () {
             Navigator.pushNamed(context, Flurorouter.registerRoute);
             },)

            ],
          ))
        ),)
    );
  }

}