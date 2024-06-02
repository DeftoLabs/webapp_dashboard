
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




import 'package:email_validator/email_validator.dart';

import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/register_form_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';


import 'package:web_dashboard/ui/buttons/custom_outlined_buttom_register.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/cards/white_card_new_user.dart';
import 'package:web_dashboard/ui/inputs/custom_Imput_register_user.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class NewUserRegister extends StatelessWidget {
  const NewUserRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => RegisterFormProvider(),
      child: Builder(builder: (context) {

        final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              Row(
              children: [
                IconButton(
              color: Colors.black,
              onPressed: (){
                NavigationService.replaceTo('/dashboard/users');
              }, 
              icon:const Icon(Icons.arrow_back_rounded)),
              Expanded
              (child: Text('Create a New User', style: CustomLabels.h1, textAlign: TextAlign.center, ),)
            
              ],
              ),
              const SizedBox(height: 20,),
              _NewUserViewBody(registerFormProvider: registerFormProvider),
            ],
          ));
      })
      );
  }

}

class _NewUserViewBody extends StatelessWidget {
  const _NewUserViewBody({
    super.key,
    required this.registerFormProvider,
  });

  final RegisterFormProvider registerFormProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(250)
        },

        children: [
          TableRow(
            children: [
              // AVATAR
              _AvatarContainer(),

              // Formulario de actualización
              _UserFormView(registerFormProvider: registerFormProvider),

            ]
          )
        ],
      ),
    );
  }
}

class _UserFormView extends StatelessWidget {
  const _UserFormView({
    required this.registerFormProvider,
  });

  final RegisterFormProvider registerFormProvider;

  @override
  Widget build(BuildContext context) {
    return WhiteCardNewUser(
      title: 'General Information',
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
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  decoration: CustomInputsRegisterUser.loginInputDecoration(
                    hint: 'Enter your Name',
                    label: 'Name',
                    icon: Icons.person_pin_rounded,
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
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  decoration: CustomInputsRegisterUser.loginInputDecoration(
                    hint: 'Enter your email',
                    label: 'Email',
                    icon: Icons.mark_email_read_outlined,
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
                  decoration: CustomInputsRegisterUser.loginInputDecoration(
                    hint: 'Enter your password',
                    label: 'Password',
                    icon: Icons.lock_outline_rounded,
                  ),
                ),
               const SizedBox(height: 20),
            TextFormField(
              onChanged: ( value ) => registerFormProvider.phone = value,
              decoration: CustomInputsRegisterUser.loginInputDecoration(
                hint: 'Phone', 
                label: 'Phone Number', 
                icon: Icons.phone_android_rounded
              ),
              validator: ( value ) {
                if ( value == null || value.isEmpty ) return 'Invalid Phone Number';
                if ( value.length < 8 ) return 'Mimimun 9 Charactes';
                return null;
              },
            ),
            const SizedBox( height: 20 ),

            TextFormField(
              onChanged: ( value ) => registerFormProvider.zone = value,
              decoration: CustomInputsRegisterUser.loginInputDecoration(
                hint: 'Zone', 
                label: 'Zone', 
                icon: Icons.map
              ),
              validator: ( value ) {
                if ( value == null || value.isEmpty ) return 'Invalid Register';
                if ( value.length < 2 ) return 'Mimimun 2 Charactes';
                return null;
              },
             ),

               const SizedBox(height: 20),

          
               CustomOutlineButtomRegister(
                onPressed: () {
          
                  final validForm = registerFormProvider.validateForm();
                  if(!validForm) return;
          
                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  authProvider.newUserRegister(
                    registerFormProvider.email, 
                    registerFormProvider.password, 
                    registerFormProvider.name,

                    );
          
                }, 
                text: 'Create User'),
          

          
              ],
            ))
        );
  }
}
class _AvatarContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return WhiteCard(
      width: 250,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile', style: CustomLabels.h2),
            const SizedBox( height: 20 ),

            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  
                  const ClipOval(
                
                  ),

                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all( color: Colors.white, width: 5 )
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        elevation: 0,
                        child: const  Icon( Icons.camera_alt_outlined, size: 20,color: Colors.white,),
                        onPressed: () {

                         
                        },
                      ),
                    ),
                  )

                ],
              )
            ),
          ],
        ),
      )
    );
  }
}