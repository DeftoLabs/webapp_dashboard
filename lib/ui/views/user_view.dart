
import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

import 'package:web_dashboard/ui/labels/custom_labels.dart';


class UserView extends StatelessWidget {

  final String uid;

  const UserView({
   required this.uid,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('User View', style: CustomLabels.h1,),

          const SizedBox(height: 10),

          WhiteCard(
            title: 'Prueba de Pagina',
            child: Text( uid ))

        ],
      )
    );
  }
}