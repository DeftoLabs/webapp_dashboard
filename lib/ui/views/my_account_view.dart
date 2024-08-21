
import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class MyAccountView extends StatelessWidget {
  const MyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('My Account View', style: CustomLabels.h1,),

          const SizedBox(height: 10),
        ],
      )
    );
  }
}