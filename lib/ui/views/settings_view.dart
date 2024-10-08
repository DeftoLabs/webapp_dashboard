
import 'package:flutter/material.dart'
;
import 'package:google_fonts/google_fonts.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/cards/rectangular_card.dart';

import 'package:web_dashboard/ui/labels/custom_labels.dart';



class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {

    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Settings', style: CustomLabels.h1,),

        const SizedBox(height: 40),
        Text('Business Settings', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction:Axis.horizontal,
              children: [
                RectangularCard(
                  title: 'Profile',
                  width: 200,
                  child: const Center(child: Icon(Icons.supervised_user_circle_outlined),),
                  onTap: (){
                    NavigationService.replaceTo('/dashboard/settings/profile');
                  },
                  ),
            
            ],
                  ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Text('Account Settings', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
              Row(            
                children: [
                  Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction:Axis.horizontal,
                  children: [
                    RectangularCard(
                  title: 'Finance Settings',
                  width: 200,
                  child: const Center(child: Icon(Icons.monetization_on_outlined),),
                  onTap: (){
                    NavigationService.replaceTo('/dashboard/settings/finance');
                  },
                  ),
                  
                          ],
                        ),
                ],
              ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Text('General Settings', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),

      Row(
        children: [
          Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction:Axis.horizontal,
              children: [
                RectangularCard(
                  title: 'Inactive Users',
                  width: 200,
                  child: const Center(child: Icon(Icons.verified_user_outlined),),
                  onTap: (){
                    NavigationService.replaceTo('/dashboard/settings/inactiveuser');
                  },
                  ),
          
            ],
          ),
        ],
      ),
      ]
    )
  ); 
  }
}