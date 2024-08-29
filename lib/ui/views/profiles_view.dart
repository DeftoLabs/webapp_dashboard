import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class ProfilesView extends StatelessWidget {
  const ProfilesView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
      return const Center(child: Text('No profile data available'));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Profile View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset('noimage.jpeg', fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 10),
                                Text('Bussines:', style: GoogleFonts.plusJakartaSans (fontSize: 16)),
                                const SizedBox(height: 10),
                                Text('Legal Name:', style: GoogleFonts.plusJakartaSans (fontSize: 16)),
                                const SizedBox(height: 10),
                                Text('TAX ID:', style: GoogleFonts.plusJakartaSans (fontSize: 16)),
                                const SizedBox(height: 10),
                                Text('Address:', style: GoogleFonts.plusJakartaSans (fontSize: 16)),
                                const SizedBox(height: 10),
                                Text('Phone:', style: GoogleFonts.plusJakartaSans (fontSize: 16)),
                                const SizedBox(height: 10),
                                Text('Web:', style: GoogleFonts.plusJakartaSans (fontSize: 16))
              
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(profile.nombre, style: GoogleFonts.plusJakartaSans( fontSize: 16, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10),
                                Text(profile.razons, style: GoogleFonts.plusJakartaSans( fontSize: 16, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10),
                                Text(profile.idfiscal, style: GoogleFonts.plusJakartaSans( fontSize: 16, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10),
                                Text(profile.direccion, style: GoogleFonts.plusJakartaSans( fontSize: 16, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10),
                                Text(profile.telefono, style: GoogleFonts.plusJakartaSans( fontSize: 16, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10),
                                Text(profile.web, style: GoogleFonts.plusJakartaSans( fontSize: 16, fontWeight: FontWeight.bold),),
                              ],),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text('Email Account', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: profile.correos.length,
                                    itemBuilder: (contex, index) {
                                      final correo = profile.correos[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: 
                                              Text(correo.email, style: GoogleFonts.plusJakartaSans(fontSize: 16)),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child:
                                                Text(correo.departamento, style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)))
                                          ],
                                        ),);
                                    }))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child:      
                      Container(
              height: 50,
              width: 150,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:  const Color.fromARGB(255, 58, 60, 65),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                child: Text(
                  'Edit Profile',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white),
                ),
                onPressed: () {
                  NavigationService.replaceTo('/dashboard/settings/profile/${profile.id}');
                },
              ),
            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
