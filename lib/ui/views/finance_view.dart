
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_dashboard/services/navigation_service.dart';


class FinanceView extends StatelessWidget {

  final String id; 

  const FinanceView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
              Row(
              children: [
                IconButton(
                    color: Colors.black,
                    onPressed: () {
                      NavigationService.navigateTo('/dashboard/settings');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'Finance Settings',
                    style: GoogleFonts.plusJakartaSans(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),

        ],
      )
    );
  }
}