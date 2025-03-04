
import 'package:flutter/material.dart'
;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/cards/rectangular_card.dart';




class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.settings, 
          style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.bold)),

        const SizedBox(height: 40),
        Text(AppLocalizations.of(context)!.bussinesssettings, 
        style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction:Axis.horizontal,
              children: [
                RectangularCard(
                  title: AppLocalizations.of(context)!.profile,
                  width: 200,
                  heigth: 150,
                  child: const Center(child: Icon(Icons.supervised_user_circle_outlined),),
                  onTap: (){
                    NavigationService.replaceTo('/dashboard/settings/profile');
                  },
                  ),
            
            ],
                  ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Text(AppLocalizations.of(context)!.accountsettings, 
        style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
              Row(            
                children: [
                  Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction:Axis.horizontal,
                  children: [
                    RectangularCard(
                  title: AppLocalizations.of(context)!.financesettings,
                  width: 200,
                  heigth: 150,
                  child: const Center(child: Icon(Icons.monetization_on_outlined),),
                  onTap: (){
                    NavigationService.replaceTo('/dashboard/settings/finance');
                  },
                  ),
                  ],
                  ),
                  const SizedBox(width: 10),
                  Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction:Axis.horizontal,
                  children: [
                    RectangularCard(
                  title: AppLocalizations.of(context)!.banksaccount,
                  width: 200,
                  heigth: 150,
                  child: const Center(child: Icon(Icons.account_balance_outlined),),
                  onTap: (){
                    NavigationService.replaceTo('/dashboard/settings/bankaccount');
                  },
                  ),
                          ],
                        ),
                ],
              ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Text(AppLocalizations.of(context)!.generalsettings, 
        style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),

      Row(
        children: [
          Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction:Axis.horizontal,
              children: [
                RectangularCard(
                  title: AppLocalizations.of(context)!.inactiveusers,
                  width: 200,
                  heigth: 150,
                  child: const Center(child: Icon(Icons.verified_user_outlined),),
                  onTap: (){
                    NavigationService.replaceTo('/dashboard/settings/inactiveuser');
                  },
                  ),
          
            ],
          ),
          const SizedBox(width: 10),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction:Axis.horizontal,
              children: [
                RectangularCard(
                  title: AppLocalizations.of(context)!.language,
                  width: 200,
                  heigth: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.translate, size: 20),
                      const SizedBox(width: 10),
                      Transform.scale(
                        scale: 0.9,
                        child: Switch(
                          value: languageProvider.locale.languageCode == 'en', 
                          onChanged:(value) {
                            languageProvider.toggleLanguage();
                          },
                          activeColor: Colors.green, 
                          inactiveThumbColor: const Color.fromRGBO(177, 255, 46, 1),
                          inactiveTrackColor:  Colors.green, 
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                      )
                    ],
                  )
                 
                  ),
          
            ],
          ),
        ],
      ),
      ]
    )
  ); 
  }
}