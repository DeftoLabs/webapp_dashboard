
import 'package:flutter/material.dart';

import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Message', style: CustomLabels.h1,),

          const SizedBox(height: 10),

          const WhiteCard(
            title: 'Department',
            child:  Text('Sale')
          )
        ],
      )
    );
  }
}