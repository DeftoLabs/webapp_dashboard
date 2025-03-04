import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';

import '../../../../providers/providers.dart';

class DashboardThreeRowUserRole extends StatelessWidget {
  const DashboardThreeRowUserRole({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; 
    final isSmallScreen = screenWidth < 930; 
    final isPhoneScreen = screenWidth < 600;


    final orderStatusCount = Provider.of<OrdenesProvider>(context).getOrderStatusByUserCountForToday(context);
    final approvedOrders = orderStatusCount['APPROVED'] ?? 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              if (!isSmallScreen) 
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.approved,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11, // Tamaño de texto normal
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                  '$approvedOrders',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isSmallScreen ? 16 : 20, // Tamaño de texto adaptativo
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                                ),
                ),
              ],
            ),
          ),
            if (!isPhoneScreen) 
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
               Icons.check, 
              color: Colors.black, // Puedes cambiar el color si prefieres
              size: 20,
            ),
          )
      ],
    );
  }
}
