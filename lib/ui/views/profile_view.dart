import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/profile.dart';
import 'package:web_dashboard/providers/profile_form_provider.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class ProfileView extends StatefulWidget {
  final String id;

  const ProfileView({super.key, required this.id});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Profile? profile;

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final profileFormProvider = Provider.of<ProfileFormProvider>(context, listen: false);

    profileProvider.getProfilById(widget.id).then((profileDB) {
      profileFormProvider.profile = profileDB;

      if (profileDB != null) {
        profileFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
          profile = profileDB;
        });
      } else {
        NavigationService.replaceTo('dashboard/settings/profile');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            if (profile == null)
              WhiteCard(
                child: Container(
                    alignment: Alignment.center,
                    height: 600,
                    child: CircularProgressIndicator(
                      color: Colors.pink[300],
                    )),
              ),
            if (profile != null) _ProfileViewBody()
          ],
        ));
  }
}

class _ProfileViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LogoProfile(),
        Table(
          columnWidths: const {
            0: FixedColumnWidth(500),
          },
          children: [
            TableRow(children: [_CentralContainer(), _RigthContainer()])
          ],
        ),
      ],
    );
  }
}

class _LogoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileFormProvider = Provider.of<ProfileFormProvider>(context);
    final profile = profileFormProvider.profile!;

    final image = (profile.img == null)
        ? const Image(image: AssetImage('noimage.jpeg'))
        : FadeInImage.assetNetwork(
            placeholder: 'load.gif', image: profile.img!);

    return Row(
      children: [
        Expanded(
          child: WhiteCardColor(
              width: 250,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            color: Colors.white,
                            onPressed: () {
                              NavigationService.replaceTo(
                                  'dashboard/settings/profile');
                            },
                            icon: const Icon(Icons.arrow_back_rounded)),
                        Text('Back to Profile',
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white)),
                                const SizedBox(width: 260),
                        SizedBox(
                            width: 150,
                            height: 160,
                            child: Stack(
                              children: [
                                ClipOval(child: image),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: Colors.white, width: 5)),
                                    child: FloatingActionButton(
                                      backgroundColor:
                                          const Color.fromRGBO(177, 255, 46, 1),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: [
                                            'jpg',
                                            'jpeg',
                                            'png'
                                          ],
                                          allowMultiple: false,
                                        );
                                        if (result != null) {
                                          if (!context.mounted) return;
                                          NotificationService.showBusyIndicator(
                                              context);
                                          final newProfile =
                                              await profileFormProvider
                                                  .uploadProfileImage(
                                            '/uploads/perfiles/${profile.id}',
                                            result.files.first.bytes!,
                                          );
                                          if (!context.mounted) return;
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .refreshProfile(newProfile);

                                          if (!context.mounted) return;
                                          Navigator.of(context).pop();
                                        } else {
                                          NotificationService.showSnackBarError(
                                              'Failed to Upload Image');
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children: [
                        const SizedBox(height: 120),
                               Text('Recommended Image Size:',
                                   style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white)),
                               Text(
                                 '450x450 Pixels',
                                 style: GoogleFonts.plusJakartaSans(
                                     fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                               ),
                               const SizedBox(height: 20),
                                                 ],
                            )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )),
        )
      ],
    );
  }
}

class _RigthContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileFormProvider = Provider.of<ProfileFormProvider>(context);
    final profile = profileFormProvider.profile!;

    return WhiteCard(
      title: 'Email Accounts',
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
               TextFormField(
                  initialValue: profile.email1,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Email Account # 01',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    labelText: 'Email Account # 01',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.black, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final lowercaseValue = value.toLowerCase();
                    profileFormProvider.copyProfileWith(
                        email1: lowercaseValue);
                  },
      validator: ( value ) {
                    if ( !EmailValidator.validate( value ?? '')) return 'Requiered valid Email';
                    return null;
                  },
                  onSaved: (value) {},
                ),
              const SizedBox(height: 15),
                  TextFormField(
                  initialValue: profile.email2,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Email Account # 02',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    labelText: 'Email Account # 02',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.black, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final lowercaseValue = value.toLowerCase();
                    profileFormProvider.copyProfileWith(
                        email2: lowercaseValue);
                  },
      validator: ( value ) {
                    if ( !EmailValidator.validate( value ?? '')) return 'Requiered valid Email';
                    return null;
                  },
                  onSaved: (value) {},
                ),
                   const SizedBox(height: 15),
                  TextFormField(
                  initialValue: profile.email3,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Email Account # 03',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    labelText: 'Email Account # 03',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.black, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final lowercaseValue = value.toLowerCase();
                    profileFormProvider.copyProfileWith(
                        email3: lowercaseValue);
                  },
      validator: ( value ) {
                    if ( !EmailValidator.validate( value ?? '')) return 'Requiered valid Email';
                    return null;
                  },
                  onSaved: (value) {},
                ),
                  const SizedBox(height: 15),
                  TextFormField(
                  initialValue: profile.email4,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Email Account # 04',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    labelText: 'Email Account # 04',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.black, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final lowercaseValue = value.toLowerCase();
                    profileFormProvider.copyProfileWith(
                        email4: lowercaseValue);
                  },
      validator: ( value ) {
                    if ( !EmailValidator.validate( value ?? '')) return 'Requiered valid Email';
                    return null;
                  },
                  onSaved: (value) {},
                ),
                const SizedBox(height: 15),
                  TextFormField(
                   initialValue: profile.email5,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Email Account # 05',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    labelText: 'Email Account # 05',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.black, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final lowercaseValue = value.toLowerCase();
                    profileFormProvider.copyProfileWith(
                        email5: lowercaseValue);
                  },
      validator: ( value ) {
                    if ( !EmailValidator.validate( value ?? '')) return 'Requiered valid Email';
                    return null;
                  },
                  onSaved: (value) {},
                ),
           
            const SizedBox(height: 110),
            Container(
              height: 50,
              width: 150,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 58, 60, 65),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                child: Text(
                  'Save Emails',
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                ),
                onPressed: () async {
                    final saved = await profileFormProvider.updateProfile();
                      if (saved) {
                        NotificationService.showSnackBa('Email Update');
                        if (context.mounted) {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .getProfile();
                          NavigationService.replaceTo(
                              'dashboard/settings/profile');
                        }
                      } else {
                        NotificationService.showSnackBarError(
                            'The Email not be Updated');
                      }
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _CentralContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileFormProvider = Provider.of<ProfileFormProvider>(context);
    final profile = profileFormProvider.profile!;

    return WhiteCardColor(
        width: 500,
        title: 'General Information',
        child: Form(
            key: profileFormProvider.formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: profile.idfiscal,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'TAX ID',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    labelText: 'TAX ID',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    prefixIcon:
                        Icon(Icons.info_sharp, color: Colors.white, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final uppercaseValue = value.toUpperCase();
                    profileFormProvider.copyProfileWith(
                        idfiscal: uppercaseValue);
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
                  onSaved: (value) {},
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: profile.nombre,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Bussines Name',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    labelText: 'Bussines Name',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    prefixIcon: Icon(Icons.burst_mode_sharp,
                        color: Colors.white, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final uppercaseValue = value.toUpperCase();
                    profileFormProvider.copyProfileWith(nombre: uppercaseValue);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bussiness Name is Required';
                    }
                    if (value.length < 2) {
                      return 'The Bussiness required minimum 3 characters';
                    }
                    if (value.length > 51) {
                      return 'Max 50 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: profile.razons,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Legal Name',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    labelText: 'Legal Name',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    prefixIcon: Icon(Icons.business_outlined,
                        color: Colors.white, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final uppercaseValue = value.toUpperCase();
                    profileFormProvider.copyProfileWith(razons: uppercaseValue);
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
                  onSaved: (value) {},
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: profile.direccion,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    labelText: 'Address',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    prefixIcon: Icon(Icons.location_city_rounded,
                        color: Colors.white, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    final uppercaseValue = value.toUpperCase();
                    profileFormProvider.copyProfileWith(
                        direccion: uppercaseValue);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is Required';
                    }
                    if (value.length < 2) {
                      return 'The Address required minimum 3 characters';
                    }
                    if (value.length > 83) {
                      return 'Max 82 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: profile.telefono,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    labelText: 'Phone',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    prefixIcon: Icon(Icons.phone_iphone_rounded,
                        color: Colors.white, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    profileFormProvider.copyProfileWith(telefono: value);
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
                  },
                  onSaved: (value) {},
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: profile.web,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Web',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    labelText: 'Web',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    prefixIcon:
                        Icon(Icons.web_asset, color: Colors.white, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 58, 60, 65),
                    )),
                  ),
                  onChanged: (value) {
                    profileFormProvider.copyProfileWith(web: value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'WebSite is Required';
                    }
                    if (value.length > 41) {
                      return 'Max 40 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(177, 255, 46, 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    child: Text(
                      'Save',
                      style: GoogleFonts.plusJakartaSans(color: Colors.black),
                    ),
                    onPressed: () async {
                      final saved = await profileFormProvider.updateProfile();
                      if (saved) {
                        NotificationService.showSnackBa('Profile Update');
                        if (context.mounted) {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .getProfile();
                          NavigationService.replaceTo(
                              'dashboard/settings/profile');
                        }
                      } else {
                        NotificationService.showSnackBarError(
                            'The Profile not be Updated');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            )));
  }
}
