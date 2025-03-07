
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/providers/profile_provider.dart';


class ShipmentView extends StatelessWidget {
  const ShipmentView({super.key});

  @override
  Widget build(BuildContext context) {


    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    final localization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded
              (
                child: Text(localization.shipment, style: GoogleFonts.plusJakartaSans(fontSize: 22),)),
                    const SizedBox(width: 50),
              SizedBox(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: image,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10),
        Center(
          child: 
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 300),
          Text(localization.shipmentstatus,
          style: GoogleFonts.plusJakartaSans (
            fontSize: 50,
            fontWeight: FontWeight.bold,
          )),
        ],
      )
        )

          

        ],
      )
    );
  }
}