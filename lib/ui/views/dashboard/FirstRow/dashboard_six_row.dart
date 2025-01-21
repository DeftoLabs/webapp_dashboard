import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/providers.dart';

class DashboardSixRow extends StatelessWidget {
  const DashboardSixRow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; 
    final isSmallScreen = screenWidth < 930; 


    final orderStatusCount = Provider.of<OrdenesProvider>(context).getOrderStatusCountForToday();
    final otherOrders = orderStatusCount['OTHER'] ?? 0;

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
                    "OTHER",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11, // Tamaño de texto normal
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                  '$otherOrders',
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
      ],
    );
  }
}
