import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/providers.dart';

class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({super.key});

  @override
  Widget build(BuildContext context) {

    
    final currentUser = Provider.of<AuthProvider>(context).user;

    return ClipOval(
      child: SizedBox(
        width: 40,
        height: 40,
        child: currentUser!.img != null && currentUser.img !=null 
        ? Image.network(currentUser.img!, fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        ) 
        : const Icon(Icons.account_circle),
        )
      );
  }
}