
import 'package:flutter/material.dart'
;
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

          const SizedBox(height: 10),

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

      Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          direction:Axis.horizontal,
          children: [
            RectangularCard(
              title: 'Inactive Users',
              width: 200,
              child: const Center(child: Icon(Icons.supervised_user_circle_outlined),),
              onTap: (){
                NavigationService.replaceTo('/dashboard/settings/inactiveuser');
              },
              ),

        ],
      ),
      ]
    )
  ); 
  }
}