
import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Customers View', style: CustomLabels.h1,),

          const SizedBox(height: 10),

          const WhiteCard(
            title: 'Sales Stadistics',
            child:  Text('Astro Wave')
          )
        ],
      )
    );
  }
}