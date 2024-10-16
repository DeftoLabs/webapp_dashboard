
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/bank.dart';
import 'package:web_dashboard/providers/providers.dart';

import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';



class BankView extends StatefulWidget {
  final String id;

  const BankView({super.key, required this.id, });

  @override
  State<BankView> createState() => _BankViewState();
}

class _BankViewState extends State<BankView> {
  Bank? bank;

  @override
  void initState() {
    super.initState();
    final bankProvider = Provider.of<BankProvider>(context, listen: false);
    
    bankProvider.getBankById(widget.id)
    .then((bankDB) => setState(() { bank = bankDB; })); 
  }
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
                        NavigationService.navigateTo('/dashboard/settings/bankaccount');
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

          const SizedBox(height: 10),
        ],
      ), 
      const SizedBox(height: 10),
      const Divider(),
      const SizedBox(height: 10),
         if (bank == null)
              WhiteCard(
                child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(
                color: Color.fromRGBO(255, 0, 200, 0.612),
                strokeWidth: 4.0),
              )
              ),
              if (bank != null) ...[
              const SizedBox(height: 20),
              const BankViewBody(),
              const SizedBox(height: 20),
            
            ]

            
    ]
    )
    );
  }
}

class BankViewBody extends StatelessWidget {
  const BankViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Table(
            columnWidths: const {
              0: FixedColumnWidth(200),
              1: FixedColumnWidth(20),

            },
            children: [
              TableRow(
                children: [
                  SizedBox(
                    height: 500,
                    child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 40),
                        Text('BANK',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,)),
                        const SizedBox(height: 35),
                        Text('ACCOUNT NUMBER',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,)),
                        const SizedBox(height: 35),
                        Text('TYPE',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,)),
                        const SizedBox(height: 35),
                        Text('CURRENCY',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,)),
                        const SizedBox(height: 35),
                        Text('HOST',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,)),
                        const SizedBox(height: 35),
                        Text('HOST ID',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16)),
                        const SizedBox(height: 35),
                        Text('COMMENTS',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 500,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                        decoration: InputDecoration(
                        hintText: 'Bank Name',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                        )
                          )
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                              decoration: InputDecoration(
                        hintText: 'Account Number',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                        )
                          )
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                              decoration: InputDecoration(
                        hintText: 'TYPE',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                        )
                          )
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                              decoration: InputDecoration(
                        hintText: 'Currency',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                        )
                          )
                        ),
                          const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                              decoration: InputDecoration(
                        hintText: 'Host Name / Legal Name',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                        )
                          )
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                              decoration: InputDecoration(
                        hintText: 'Host ID',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                        )
                          )
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                              decoration: InputDecoration(
                        hintText: 'Comments',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                        )
                          )
                        ),
                      ],
                    ),
                   
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 50,
                width: 150,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 200, 83, 1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          const Color.fromRGBO(177, 255, 46, 100),
                      width: 2,
                    )),
                child: TextButton(
                  child: Text(
                    'SAVE',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                   
                  },
                ),
              ),
          ),
        ],
      ),
    );
  }
}
