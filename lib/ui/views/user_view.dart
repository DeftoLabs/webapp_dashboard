import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:email_validator/email_validator.dart';


import 'package:web_dashboard/models/usuario.dart';
import 'package:web_dashboard/providers/user_form_provider.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/inputs/custom_inputs.dart';

import 'package:web_dashboard/ui/labels/custom_labels.dart';



class UserView extends StatefulWidget {

  final String uid;

  const UserView({
    Key? key, 
    required this.uid
  }) : super(key: key);

  @override
  UserViewState createState() => UserViewState();
}

class UserViewState extends State<UserView> {

  Usuario? user;


  @override
  void initState() { 
    super.initState();
    final usersProvider    = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider = Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.uid)
      .then((userDB) {
        
        userFormProvider.user = userDB;
        setState((){ user = userDB; });

      }
    );
    
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const  EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('User View', style: CustomLabels.h1 ),

          const SizedBox( height: 10 ),

          if( user == null ) 
            WhiteCard(
              child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(),
              )
            ),
          
          if( user != null ) 
            _UserViewBody()

        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
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
              const  _UserViewForm(),
            ]
          )
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    return WhiteCard(
      title: 'Información general',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [

            TextFormField(
              initialValue: user.nombre,
              decoration: CustomInput.formInputDecoration(
                hint: 'Nombre del usuario', 
                label: 'Nombre', 
                icon: Icons.supervised_user_circle_outlined
              ),
              onChanged: ( value )=> userFormProvider.copyUserWith( nombre: value ),
              validator: ( value ) {
                if ( value == null || value.isEmpty ) return 'Ingrese un nombre.';
                if ( value.length < 2 ) return 'El nombre debe de ser de dos letras como mínimo.';
                return null;
              },
            ),

            const SizedBox( height: 20 ),

            TextFormField(
              initialValue: user.correo,
              decoration: CustomInput.formInputDecoration(
                hint: 'Correo del usuario', 
                label: 'Correo', 
                icon: Icons.mark_email_read_outlined
              ),
              onChanged: ( value )=> userFormProvider.copyUserWith( correo: value ),
              validator: ( value ) {
                if( !EmailValidator.validate(value ?? '') ) return 'Email no válido';

                return null;
              },
            ),

            const SizedBox( height: 20 ),

            ConstrainedBox(
              constraints: const BoxConstraints( maxWidth: 100 ),
              child: ElevatedButton(
                onPressed: () {


                }, 
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all( Colors.indigo ),
                  shadowColor: WidgetStateProperty.all( Colors.transparent ),
                ),
                child: const Row(
                  children: [
                    Icon( Icons.save_outlined, size: 20 ),
                    Text('  Guardar')
                  ],
                )
              ),
            )

          ],
        ),
      )
    );
  }
}




class _AvatarContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

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
                    child: Image(
                      image: AssetImage('no-image.jpg'),
                    ),
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
                        child: const  Icon( Icons.camera_alt_outlined, size: 20,),
                        onPressed: () {
                          // TODO: Seleccionar la imagen
                        },
                      ),
                    ),
                  )

                ],
              )
            ),

            const SizedBox( height: 20 ),

            Text(
              user.nombre,
              style: const TextStyle( fontWeight: FontWeight.bold ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    );
  }
}