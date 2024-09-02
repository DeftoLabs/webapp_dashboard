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

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Center(child: Text('Profile View', style: CustomLabels.h1)),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 700,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: ClipOval(
                          child: image,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 300,
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
                                const SizedBox(height: 33),
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
                            height: 300,
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
                            height: 300,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text('Email Account', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const SizedBox(height: 10),
                                     Text(profile.email1, style: GoogleFonts.plusJakartaSans( fontSize: 16),),
                                     const SizedBox(height: 10),
                                     Text(profile.email2, style: GoogleFonts.plusJakartaSans( fontSize: 16),),
                                     const SizedBox(height: 10),
                                     Text(profile.email3, style: GoogleFonts.plusJakartaSans( fontSize: 16)),
                                     const SizedBox(height: 10),
                                     Text(profile.email4, style: GoogleFonts.plusJakartaSans( fontSize: 16)),
                                     const SizedBox(height: 10),
                                     Text(profile.email5, style: GoogleFonts.plusJakartaSans( fontSize: 16)),
                                     const SizedBox(height: 10),
                                  
                                   ],),
                                   ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
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
