import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/auth_provider.dart';

import 'package:web_dashboard/providers/login_form_provider.dart';

import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';

import 'package:web_dashboard/ui/inputs/custom_inputs.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => LoginFormProvider(),
      child: Builder(builder: (context) {

        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);

        return Container(
        margin: const EdgeInsets.only(top: 100),
        padding:const EdgeInsets.symmetric(horizontal: 20),
        child: Center (
          child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
            key: loginFormProvider.formKey,
            child: Column(
              children: [
      
                // Email
                TextFormField(
                  onFieldSubmitted: ( _ ) => onFormSubmit(loginFormProvider, authProvider),
                  validator: ( value ) {
                    if ( !EmailValidator.validate( value ?? ' ')) return 'Email not valid';

                    return null;
                  },
                  onChanged: ( value ) => loginFormProvider.email = value,
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
                  onFieldSubmitted: ( _ ) => onFormSubmit(loginFormProvider, authProvider),
                  onChanged: ( value ) => loginFormProvider.password = value,
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
                onPressed: () => onFormSubmit(loginFormProvider, authProvider),
                text: 'Login'),
      
      
              const SizedBox(height: 20),
             //  LinkText(text: 'New Account',
             //  onPressed: () {
             //  Navigator.pushReplacementNamed(context, Flurorouter.registerRoute);
             //  },)
      
              ],
            ))
          ),)
      );
      })
    );
  }
  
  void onFormSubmit (LoginFormProvider loginFormProvider, AuthProvider authProvider){
      final isValid =  loginFormProvider.validateForm();
      if (isValid) {
      authProvider.login(loginFormProvider.email, loginFormProvider.password);
  }
} 
}