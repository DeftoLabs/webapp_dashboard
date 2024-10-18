import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/bank_datasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/modals/bank_modal.dart';


class BanksView extends StatelessWidget {
  const BanksView({super.key});

  @override
  Widget build(BuildContext context) {

    final bankProvider = Provider.of<BankProvider>(context);

    final bankDataSource = BankDataSource(bankProvider.banks);
   
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);


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
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Bank Account Settings',
                          style: GoogleFonts.plusJakartaSans(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
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
              const SizedBox(height: 20),
                 Padding(
                  padding: const EdgeInsets.all(20),
                   child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                       height: 50,
                       width: 170,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(177, 255, 46, 100),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        )),
                      child: TextButton(
                        child: Text(
                          'Add Account',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const BankModal();
                              },
                            );
                        },
                      ),
                    ),
                                   ),
                 ),
              const SizedBox(height: 20),
            PaginatedDataTable(
              columns:[
                DataColumn(label: Text('Bank', style: GoogleFonts.plusJakartaSans( fontSize: 14, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Account Holder', style: GoogleFonts.plusJakartaSans( fontSize: 14, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('# Account', style: GoogleFonts.plusJakartaSans( fontSize: 14, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Currency', style: GoogleFonts.plusJakartaSans( fontSize: 14, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Edit', style: GoogleFonts.plusJakartaSans( fontSize: 14, fontWeight: FontWeight.bold))),
              ], 
              source: bankDataSource)
              
            ],
          ),
        );
      }
}
