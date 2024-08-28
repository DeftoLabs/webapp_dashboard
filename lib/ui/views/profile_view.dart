
import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class ProfileView extends StatelessWidget {

  final String id;

  const ProfileView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('My Profile View', style: CustomLabels.h1,),

          const SizedBox(height: 10),
          Text(id),

        ],
      )
    );
  }
}