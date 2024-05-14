import 'package:flutter/material.dart';
import 'package:web_dashboard/router/router.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/buttons/link_text.dart';
import 'package:web_dashboard/ui/inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
              // Name
              TextFormField(
                // validator: (),
                style: const TextStyle(color: Colors.white),
                decoration: CustomInput.loginInputDecoration(
                  hint: 'Enter your Name',
                  label: 'Name',
                  icon: Icons.supervised_user_circle_sharp,
                ),
              ),
                const SizedBox(height: 20),

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
              onPressed: (){}, 
              text: 'Create Account'),


              const SizedBox(height: 20),
             LinkText(text: 'Back to login',
             onPressed: () {
              Navigator.pushNamed(context, Flurorouter.loginRoute);
             },)

            ],
          ))
        ),)
    );
  }

}