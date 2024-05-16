

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_dashboard/ui/shared/widget/logo.dart';
import 'package:web_dashboard/ui/shared/widget/menu_item.dart';
import 'package:web_dashboard/ui/shared/widget/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [

        const Logo(),

         const SizedBox(height: 50),

         const TextSeparator (text:'main'),

         MenuItem(
          text: 'Dashboard', icon: Icons.compass_calibration_outlined, onPressed: (){}),

        MenuItem(text: 'Orders', icon: Icons.shopping_bag,            onPressed: (){}),
        MenuItem(text: 'Analityc', icon: Icons.analytics,             onPressed: (){}),
        MenuItem(text: 'GPS', icon: Icons.gps_fixed,                  onPressed: (){}),
        MenuItem(text: 'Products', icon: Icons.dashboard_outlined,    onPressed: (){}),
        MenuItem(text: 'Customers', icon: Icons.people_alt_outlined,  onPressed: (){}),
        MenuItem(text: 'Sales', icon: Icons.people_alt_outlined,      onPressed: (){}),

        const SizedBox(height: 30),

        const TextSeparator(text: 'Elements'),
        MenuItem(text: 'Marketing', icon: Icons.mark_email_read_outlined,       onPressed: (){}),
        MenuItem(text: 'Message', icon: Icons.message_outlined,                 onPressed: (){}),
        MenuItem(text: 'Update', icon: Icons.update_outlined,                   onPressed: (){}),

        const SizedBox(height: 30),

        const TextSeparator(text: 'Configuration'),
        MenuItem(text: 'Settings', icon: Icons.settings_applications_outlined,  onPressed: (){}),
        MenuItem(text: 'Logout', icon: Icons.logout_outlined,                   onPressed: (){}),

        const SizedBox(height: 30),


        ]
      )
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 137, 173, 255),
        Color.fromARGB(255, 98, 129, 201),
      ]
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
        )
      ]
  );
}