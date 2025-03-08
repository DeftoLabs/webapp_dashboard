
import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

import 'package:web_dashboard/ui/labels/custom_labels.dart';


class MarketingView extends StatelessWidget {
  const MarketingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Marketing', style: CustomLabels.h1,),

          const SizedBox(height: 10),

         const Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          direction:Axis.horizontal,
          children: [
            WhiteCard(
              title: 'Promociones',
              width: 170,
              child: Center(child: Icon(Icons.local_offer)),
              ),

              WhiteCard(
              title: 'Eventos',
              width: 170,
              child: Center(child: Icon(Icons.event_rounded)),
              ),
          ],
         )
        ],
      )
    );
  }
}