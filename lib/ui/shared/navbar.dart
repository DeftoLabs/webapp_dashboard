import 'package:flutter/material.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/providers/sidemenu_provider.dart';
import 'package:web_dashboard/ui/shared/widget/navbar_avatar.dart';
import 'package:web_dashboard/ui/shared/widget/notifications_indicator.dart';
import 'package:web_dashboard/ui/shared/widget/search_text.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 60,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [

          if(size.width <= 700)
          IconButton(icon: const Icon(Icons.menu_outlined),
          onPressed: ()=> SideMenuProvider.openMenu() ),
          const SizedBox(width: 5),

          // Search Input
          if(size.width >390)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: const SearchText(),
            ),

            const Spacer(),

            const NotificationsIndicator(),

            const SizedBox(width: 10),

            const NavbarAvatar(),

            const SizedBox(width: 10),

        ],
      )
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    color:  Color.fromRGBO(235, 237, 233, 0.612),
     boxShadow: [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 5,
      )
    ]
  );
}

