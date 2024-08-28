
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/profile.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom_register.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';
import 'package:web_dashboard/ui/modals/email_profile_modal.dart';

class MyAccountView extends StatefulWidget {

  const MyAccountView({super.key});

  @override
  State<MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<MyAccountView> {
  @override
  void initState() {
    super.initState();
    final profilesProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    profilesProvider.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                  color: Colors.black,
                  onPressed: () {
                    NavigationService.replaceTo('/dashboard/settings');
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              Expanded(
                child: Text(
                  'Update Profile',
                  style: CustomLabels.h1,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          _ProfileViewBody()
        ],
      ),
    );
  }
}

class _ProfileViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        if (profileProvider.profile == null) {
          return const Center(
            child: CircularProgressIndicator(
                color: Colors.transparent),
          );
        }
        return SizedBox(
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(350),
            },
            children: [
              TableRow(
                children: [
                  // AVATAR
                  _AvatarContainer(),

                  // Formulario de actualización
                  const _ProfileViewForm(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileViewForm extends StatefulWidget {
  const _ProfileViewForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_ProfileViewForm> createState() => _ProfileViewFormState();
}

class _ProfileViewFormState extends State<_ProfileViewForm> {
  final formKey = GlobalKey<FormState>();
  late ProfileProvider profileProvider;
  Profile? profile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileProvider = Provider.of<ProfileProvider>(context);
    if (profileProvider.profile != null) {
      profile = profileProvider.profile;
    } else {
      profile = Profile(
        estado: true,
        id: '',
        codigo: '',
        idfiscal: '',
        nombre: '',
        razons: '',
        direccion: '',
        telefono: '',
        web: '',
        correos: [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
        title: 'General Information',
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: profile?.idfiscal,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Tax ID',
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
                  labelText: 'Tax ID',
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  prefixIcon: profile!.idfiscal.isEmpty
                      ? const Icon(Icons.info_sharp,
                          color: Colors.black, size: 20)
                      : null,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 58, 60, 65),
                  )),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 58, 60, 65),
                  )),
                ),
                onChanged: (value) {
                  final uppercaseValue = value.toUpperCase();
                  if (profile != null) profile!.idfiscal = uppercaseValue;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'TAX ID is Required';
                  }
                  if (value.length < 2) {
                    return 'The TAX required minimum 3 characters';
                  }
                  if (value.length > 21) return 'Max 20 characters';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: profile?.razons,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Legal Name',
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
                  labelText: 'Legal Name',
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  prefixIcon: profile!.razons.isEmpty
                      ? const Icon(Icons.business_outlined,
                          color: Colors.black, size: 20)
                      : null,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 58, 60, 65),
                  )),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 58, 60, 65),
                  )),
                ),
                onChanged: (value) {
                  final uppercaseValue = value.toUpperCase();
                  if (profile != null) profile!.razons = uppercaseValue;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Legal Name is Required';
                  }
                  if (value.length < 2) {
                    return 'The Legal required minimum 3 characters';
                  }
                  if (value.length > 51) {
                    return 'Max 50 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: profile?.nombre,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Bussiness Name',
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
                  labelText: 'Bussiness Name',
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  prefixIcon: profile!.razons.isEmpty
                      ? const Icon(Icons.burst_mode_sharp,
                          color: Colors.black, size: 20)
                      : null,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 58, 60, 65),
                  )),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 58, 60, 65),
                  )),
                ),
                onChanged: (value) {
                  final uppercaseValue = value.toUpperCase();
                  if (profile != null) profile!.nombre = uppercaseValue;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Legal Name is Required';
                  }
                  if (value.length < 2) {
                    return 'The Legal required minimum 3 characters';
                  }
                  if (value.length > 51) {
                    return 'Max 50 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                  initialValue: profile?.direccion,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 16),
                    labelText: 'Address',
                    labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    prefixIcon: profile!.razons.isEmpty
                        ? const Icon(Icons.burst_mode_sharp,
                            color: Colors.black, size: 20)
                        : null,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final uppercaseValue = value.toUpperCase();
                    if (profile != null) profile!.direccion = uppercaseValue;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is Required';
                    }
                    if (value.length < 2) {
                      return 'The Address required minimum 3 characters';
                    }
                    if (value.length > 91) {
                      return 'Max 90 characters';
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              TextFormField(
                  initialValue: profile?.telefono,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 16),
                    labelText: 'Phone',
                    labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    prefixIcon: profile!.razons.isEmpty
                        ? const Icon(Icons.web_asset,
                            color: Colors.black, size: 20)
                        : null,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final uppercaseValue = value.toUpperCase();
                    if (profile != null) profile!.telefono = uppercaseValue;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone is Required';
                    }
                    if (!RegExp(r'^\+?[0-9]+$').hasMatch(value)) {
                      return 'Only numbers and a leading + are allowed (No space allowed)';
                    }
                    if (value.length > 21) {
                      return 'Max 20 characters';
                    }
                    return null;
                  }),
              const SizedBox(height: 48),
              CustomOutlineButtomRegister(
                onPressed: () async {
                  print('Antes Response');
                      final saved = await profileProvider.updateProfile();
                  print('Despues Response');
                      if (saved) {
                        NotificationService.showSnackBa(
                            '${profile!.razons} Updated');
                            NavigationService.replaceTo('/dashboard/products');
                      } else {
                        NotificationService.showSnackBarError(
                            'Could not save the Profile');
                      }
                  
                },
                text: 'Save',
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}

class _AvatarContainer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // final image = (user.img == null)
    // ? const Image(image: AssetImage('noimage.jpeg'))
    // : FadeInImage.assetNetwork(
    //   placeholder: 'load.gif',
    //   image: user.img!);

    return Column(
      children: [
        WhiteCard(
            width: 350,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Logo', style: CustomLabels.h2),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 150,
                      height: 160,
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.asset('bozzicon.png'),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(color: Colors.white, width: 5)),
                              child: FloatingActionButton(
                                backgroundColor: const Color.fromRGBO(177, 255, 46, 1),
                                elevation: 0,
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['jpg', 'jpeg', 'png'],
                                    allowMultiple: false,
                                  );
        
                                  if (result != null) {
                                    if (!context.mounted) return;
                                    NotificationService.showBusyIndicator(context);
                                    // final newUser = await userFormProvider.uploadImage('/uploads/usuarios/${user.uid}', result.files.first.bytes!);
                                    if (!context.mounted) return;
                                    // Provider.of<UsersProvider>(context, listen: false).refreshUser(newUser);
                                    if (!context.mounted) return;
                                    Navigator.of(context).pop();
                                  } else {
                                    NotificationService.showSnackBarError(
                                        'Failed to Create User'); // User canceled the picker
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            )
            ),

         Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            if (profileProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (profileProvider.profile == null || profileProvider.profile!.correos.isEmpty) {
              return WhiteCard(
                width: 350,
                child: Center(
                  child: Text('No emails found', style: CustomLabels.h2),
                ),
              );
            }

            return WhiteCard(
              width: 350,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email Accounts', style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold) ),
                    const SizedBox(height: 20),
                    ...profileProvider.profile!.correos.map((correo) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(correo.email, style: GoogleFonts.plusJakartaSans(fontSize: 16)),
                              Text(correo.departamento, style:GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold) )
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                   OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(const Color.fromRGBO(177, 255, 46, 100),),
                      padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                minimumSize: WidgetStateProperty.all(
                  const Size(200, 60)
                )
                    ),
                    onPressed: (){
                       showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EmailProfileModal();
                              },
                            );
                    }, 
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add_outlined, color: Colors.black,),
                        const SizedBox(width: 8),
                        Text('Update Emails', style:GoogleFonts.plusJakartaSans(fontSize: 16, color: Colors.black),)
                      ],
                    ),
                    ),
                  const SizedBox(height: 20),
                  ],
                            
                ),
              ),

            );
          },
        ),

      
      ],
    );
  }
}
