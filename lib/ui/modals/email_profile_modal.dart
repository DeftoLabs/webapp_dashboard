import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/profile.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class EmailProfileModal extends StatefulWidget {
  final List<Correo>? correos;
  final formKey = GlobalKey<FormState>();

  EmailProfileModal({super.key, this.correos});

  @override
  State<EmailProfileModal> createState() => _EmailProfileModalState();
}

class _EmailProfileModalState extends State<EmailProfileModal> {
  late List<String> emails = [];
  late List<String> departamentos = [];

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.getProfile().then((profile) {
        if (profile != null) {
          setState(() {
            emails = profile.correos.map((c) => c.email).toList();
            departamentos = profile.correos.map((c) => c.departamento).toList();
          });
        } else {
          setState(() {
            emails = [];
            departamentos = [];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 600,
        width: 700,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 60, 65),
          borderRadius: BorderRadius.circular(20),
        ),
        child: FutureBuilder<Profile?>(
          future: profileProvider.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No data found'));
            } else {
              final profile = snapshot.data!;
              emails = profile.correos.map((c) => c.email).toList();
              departamentos =
                  profile.correos.map((c) => c.departamento).toList();

              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Update Emails',
                          style: CustomLabels.h1.copyWith(color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white70),
                    const SizedBox(height: 20),
                    Flexible(
                      child: ListView.builder(
                        itemCount: emails.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20.0), // Agrega espacio entre filas
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: TextFormField(
                                      initialValue: emails[index],
                                      onChanged: (value) {
                                        setState(() {
                                          emails[index] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Email ${index + 1}',
                                        labelText: 'Email ${index + 1}',
                                        labelStyle: GoogleFonts.plusJakartaSans(
                                            color: Colors.white),
                                        hintStyle: GoogleFonts.plusJakartaSans(
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  177, 255, 46, 100),
                                              width: 2.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0),
                                        ),
                                      ),
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      initialValue: departamentos[index],
                                      onChanged: (value) {
                                        setState(() {
                                          departamentos[index] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Department ${index + 1}',
                                        labelText: 'Department ${index + 1}',
                                        labelStyle: GoogleFonts.plusJakartaSans(
                                            color: Colors.white),
                                        hintStyle: GoogleFonts.plusJakartaSans(
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  177, 255, 46, 100),
                                              width: 2.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0),
                                        ),
                                      ),
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Department is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomOutlineButtomColor(
                      onPressed: () async {
                        if (widget.formKey.currentState != null && widget.formKey.currentState!.validate()){
                        }
                      },
                      text: 'Save',
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
