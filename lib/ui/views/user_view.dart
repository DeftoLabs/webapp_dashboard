
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/usuaro.dart';
import 'package:web_dashboard/providers/user_form_provider.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/inputs/custom_inputs.dart';

import 'package:web_dashboard/ui/labels/custom_labels.dart';


class UserView extends StatefulWidget {

  final String uid;

  const UserView({
   required this.uid,
    super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {

  Usuario? user;

  @override
  void initState() {
    super.initState();

    final userProvider      = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider  = Provider.of<UserFormProvider>(context, listen: false);

    userProvider.getUserById(widget.uid)
    .then((userDB) {
      userFormProvider.user = userDB;
      setState(() { user = userDB;}); 
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Text('${user?.nombre}', style: CustomLabels.h1, textAlign: TextAlign.center,),

          const SizedBox(height: 20),

              if( user == null) 
              WhiteCard(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          child: const CircularProgressIndicator(),
        ),
      ),
      _UserViewBody()
    ]
    )
    )
    ;
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
              _AvatarContainer(),

             
              _UserViewForm()
            ]
          )
        ],
        )
    );
  }
}

class _UserViewForm extends StatelessWidget {
const _UserViewForm ({
  Key? key
}) : super ( key: key);

  @override
  Widget build(BuildContext context) {

    final userFormProviver = Provider.of<UserFormProvider>(context);
    final user = userFormProviver.user;


    return WhiteCard(
      title: 'General Information',
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              initialValue: user!.nombre,
              decoration: CustomInput.formInputDecoration(
                hint: 'User Name', 
                label: 'Name', 
                icon:Icons.person),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              initialValue: user.phone,
              decoration: CustomInput.formInputDecoration(
                hint: 'User Phone', 
                label: 'Phone', 
                icon:Icons.phone_enabled_outlined),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              initialValue: user.correo,
              decoration: CustomInput.formInputDecoration(
                hint: 'User Email', 
                label: 'Email', 
                icon:Icons.email_outlined),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              initialValue: user.zone,
              decoration: CustomInput.formInputDecoration(
                hint: 'User Zone', 
                label: 'Zone', 
                icon:Icons.map_outlined),
            ),
            const SizedBox(height: 20,),
            
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: ElevatedButton(
                onPressed: (){}, 
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.indigo),
                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                  padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
                ),
                child: const Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.save, color: Colors.white, size: 20,),
                    Text('  Save', style: TextStyle(color: Colors.white, fontSize: 20),)
                  ],)
                      ),
            )],
        )));
  }
}

class _AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      width: 250,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile', style: CustomLabels.h2),
            const SizedBox(height: 20),

            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [

                  const ClipOval(
                    child: Image(
                      image: AssetImage('noimage.jpeg'))
                      ),

                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all( color: Colors.white, width: 5)
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.indigo,
                      elevation: 0,
                      child: const Icon(Icons.camera_alt_outlined, size: 20, color: Colors.white,),
                      onPressed: () {
                      // TODO Select image
                    },)
                  )

              )],
              ),
            ),
            const SizedBox(height: 20),

            
          ],
        ),
      ));
  }
}