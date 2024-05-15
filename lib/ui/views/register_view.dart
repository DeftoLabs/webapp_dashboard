import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/register_form_provider.dart';
import 'package:web_dashboard/router/router.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/buttons/link_text.dart';
import 'package:web_dashboard/ui/inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => RegisterFormProvider(),
      child: Builder(builder: (context) {

        final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
      margin: const EdgeInsets.only(top: 100),
      padding:const EdgeInsets.symmetric(horizontal: 20),
      child: Center (
        child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 370),
        child: Form(
          key: registerFormProvider.formKey,
          child: Column(
            children: [
              // Name
              TextFormField(
                onChanged: ( value ) => registerFormProvider.name = value,
                validator: ( value ) {
                  if( value == null || value.isEmpty) return 'Requiered valid name';
                  return null;
                },
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
                onChanged: ( value ) => registerFormProvider.email = value,
                validator: ( value ) {
                  if ( !EmailValidator.validate( value ?? '')) return 'Requiered valid Email';
                  return null;
                },
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
                onChanged: ( value ) => registerFormProvider.password = value,
                  validator: ( value ){
                    if( value == null || value.isEmpty ) return ' Password required';
                    if( value.length < 6  ) return ' Password will have 6 characters';
      
                    return null;
                  },
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

                registerFormProvider.validateForm();

              }, 
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
      })
      );
  }

}