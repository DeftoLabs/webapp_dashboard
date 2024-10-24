import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:email_validator/email_validator.dart';


import 'package:web_dashboard/models/usuario.dart';
import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/user_form_provider.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom_register.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/inputs/custom_inputs.dart';

import 'package:web_dashboard/ui/labels/custom_labels.dart';



class UserView extends StatefulWidget {

  final String uid;

  const UserView({
    Key? key, 
    required this.uid,
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

        if( userDB != null) {
        userFormProvider.user = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
        setState((){ user = userDB; });
        } else {
          NavigationService.replaceTo('/dashboard/users');
        }
      }
    );
    
  }
  @override
  void dispose() {
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const  EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox( height: 10 ),
          Row(
            children: [
            IconButton(
              color: Colors.black,
              onPressed: (){
                NavigationService.replaceTo('/dashboard/users');
              }, 
              icon:const Icon(Icons.arrow_back_rounded)),
              Expanded
              (child: Text('Update User', style: CustomLabels.h1, textAlign: TextAlign.center, ),)
            
            ],
          ),
          const SizedBox( height: 10 ),


          if( user == null ) 
            WhiteCard(
              child: Container(
                alignment: Alignment.center,
                height: 400,
                child: const CircularProgressIndicator(
            color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 4.0),
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
      title: 'General Information',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [

            TextFormField(
              initialValue: user.nombre,
              decoration: CustomInput.formInputDecoration(
                hint: 'User Name', 
                label: 'Name', 
                icon: Icons.person_pin_rounded
              ),
              onChanged: ( value )=> userFormProvider.copyUserWith( nombre: value ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter a Name.';
                if (value.length < 2) return 'The Name must be at least two letters long.';
                if (value.length > 20) return 'The Name must be no more than 20 characters long.';
                return null;
              },
            ),

            const SizedBox( height: 20 ),

            TextFormField(
              initialValue: user.correo,
              decoration: CustomInput.formInputDecoration(
                hint: 'User Email', 
                label: 'Email', 
                icon: Icons.mark_email_read_outlined
              ),
              onChanged: ( value )=> userFormProvider.copyUserWith( correo: value ),
              validator: ( value ) {
                if( !EmailValidator.validate(value ?? '') ) return 'Invalid Email.';

                return null;
              },
            ),
            const SizedBox( height: 20 ),

            TextFormField(
              initialValue: user.phone,
              decoration: CustomInput.formInputDecoration(
                hint: 'Phone', 
                label: 'Phone Number', 
                icon: Icons.phone_android_rounded
              ),
              onChanged: ( value )=> userFormProvider.copyUserWith( phone: value ),
              validator: ( value ) {
                if ( value == null || value.isEmpty ) return 'Invalid Phone Number';
                if ( value.length < 8 ) return 'Mimimun 9 Charactes';
                return null;
              },
            ),
            const SizedBox( height: 20 ),

            TextFormField(
              initialValue: user.zone,
              decoration: CustomInput.formInputDecoration(
                hint: 'Code', 
                label: 'Code', 
                icon: Icons.map
              ),
              onChanged: ( value )=> userFormProvider.copyUserWith( zone: value ),
              validator: ( value ) {
                if ( value == null || value.isEmpty ) return 'Invalid Register';
                if ( value.length < 2 ) return 'Mimimun 2 Charactes';
                return null;
              },
             ),
            const SizedBox( height: 48 ),

            CustomOutlineButtomRegister(
              onPressed: () async {
                final saved = await userFormProvider.updateUser();
                if( saved) {
                  NotificationService.showSnackBa('User Updated');
                  if(!context.mounted) return;
                  Provider.of<UsersProvider>(context, listen: false).refreshUser(user);
                } else {
                  NotificationService.showSnackBarError('Error try to Update the User');
                }
            
              }, 
              text: 'Save',
            ),
            const SizedBox(height: 40,)

          ],
        ),
  
      )
    );
  }
}

class StatusUserView extends StatelessWidget {

  const StatusUserView({
    super.key,
    required this.user,
  });

  final Usuario user;

  @override
  Widget build(BuildContext context) {

    final userFormProvider = Provider.of<UserFormProvider>(context);
    final currentUserId = Provider.of<AuthProvider>(context).user;
    
    if(user.rol == 'MASTER_ROL' || user.uid == currentUserId?.uid ) {
      return const SizedBox(height: 64);
    } else {
      return Column(
      children: [
        SwitchListTile(
          title: Text(
            'Status ', 
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),),
          subtitle: Text(  user.estado ? 'Active' : 'Inactive'),
          value: user.estado, 
         onChanged: (value) {
            userFormProvider.copyUserWith(estado: value);
          }
          ),
      ],
    );
    }

  }
}




class _AvatarContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    final image = (user.img == null || !Uri.parse(user.img!).isAbsolute)
    ? const Image(image: AssetImage('noimage.jpeg')) 
    : FadeInImage.assetNetwork(
      placeholder: 'load.gif', 
      image: user.img!);

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
                  
                  ClipOval(
                    child: image,
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
                        onPressed: () async  {
                         FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'jpeg', 'png'],
                          allowMultiple: false,
                         );

                          if (result != null) {
                            if(!context.mounted) return;
                            NotificationService.showBusyIndicator(context);
                            final newUser = await userFormProvider.uploadImage('/uploads/usuarios/${user.uid}', result.files.first.bytes!);
                            if(!context.mounted) return;
                            Provider.of<UsersProvider>(context, listen: false).refreshUser(newUser);   
                            if(!context.mounted) return;             
                            Navigator.of(context).pop();
                          } else {
                            NotificationService.showSnackBarError('Failed to Create User');                            // User canceled the picker
                          }
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
            ),
            const SizedBox( height: 20 ),
            Text(user.rol == 'USER_ROLE' ? 'SALES REP' 
            : user.rol == 'ADMIN_ROLE' ? 'ADMIN' 
            : user.rol == 'MASTER_ROL' ? 'MANAGER' : user.rol,),

            const SizedBox( height: 20 ),

            const Divider(),

            StatusUserView(user: user),

            const SizedBox( height: 20 ),

          ],
        ),
      )
    );
  }
}