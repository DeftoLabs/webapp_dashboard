import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/shared/widget/search_text.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [

          //TODO: Icono del Menu
          IconButton(icon: const Icon(Icons.menu_outlined) ,onPressed: (){}, ),
          const SizedBox(width: 5),

          // Search Input
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
            child: SearchText(),
            )
        ],
      )
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    color: Color.fromARGB(255, 164, 255, 253),
     boxShadow: [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 5,
      )
    ]
  );
}