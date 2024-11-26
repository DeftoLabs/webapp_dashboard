
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/payment.dart';
import 'package:web_dashboard/providers/payment_form_provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';


class PaymentNewView extends StatefulWidget {

  const PaymentNewView({super.key});

  @override
  State<PaymentNewView> createState() => _PaymentNewViewState();
}

class _PaymentNewViewState extends State<PaymentNewView> {

  Payment? payment;

  @override
  void initState() {
    super.initState();
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
                        NavigationService.navigateTo('/dashboard/payments');
                      },
                      icon: const Icon(Icons.arrow_back_rounded)),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'CREATE A PAYMENT',
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
              if (payment != null) ...[
              const SizedBox(height: 10),
              const PaymentViewBody(),
              const SizedBox(height: 10),
            
            ]

            
    ]
    )
    );
  }
}

class PaymentViewBody extends StatelessWidget {
  const PaymentViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return const Column(
      children: [
        PaymentViewForm(),
        AttachViewBody()
      ],
    );
  }
}

class PaymentViewForm extends StatelessWidget {

  
  const PaymentViewForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final paymentFormProvider = Provider.of<PaymentFormProvider>(context);
    final payment = paymentFormProvider.payment!;

    return WhiteCard(
      width: MediaQuery.of(context).size.width,
      child: 
      Form(
        // key: 
        child:
        Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 300,
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(payment.numerocontrol, style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 40),
                            Text(DateFormat('dd/MM/yy').format(payment.fechacreacion), style: GoogleFonts.plusJakartaSans(fontSize: 14))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('CUSTOMER', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                        Text('CONSUMER WIDGET CUSTOMER', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text('DETAIL / COMMENTS', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                        TextFormField(

                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('METHOD: ', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text('3 Metodos')
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                     ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('AMOUNT ', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text('SELECT CURRENCY'),
                            const SizedBox(width: 5),
                            TextFormField(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('BANK ', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            TextFormField()
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('PAYMENT DATE', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                          Text('SELECT DATE')
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                             Text('REF', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            TextFormField()
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('RECEIVING BANK', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text('CONSUMER BANK')
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
                 Container(
                    height: 50,
                    width: 130,
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
                        'SAVE',
                        style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: () {
                      
                      },
                    ),
                  ),
                    const SizedBox(height: 20),
                         ],
                       )
      ),

    );
  }
}

class AttachViewBody extends StatelessWidget {
  const AttachViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ATTACHED FILE', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold), ),
                const SizedBox(width: 30),
                  // Container(
                  //     height: 50,
                  //     width: 130,
                  //    padding: const EdgeInsets.all(10),
                  //    decoration: BoxDecoration(
                  //      color: const Color.fromRGBO(177, 255, 46, 100),
                  //      borderRadius: BorderRadius.circular(20),
                  //      border: Border.all(
                  //        color: const Color.fromARGB(255, 0, 0, 0),
                  //        width: 0.6,
                  //      )),
                  //    child: TextButton(
                  //      child: Text(
                  //        'ATTACHE FILE',
                  //        style: GoogleFonts.plusJakartaSans(
                  //            color: const Color.fromARGB(255, 0, 0, 0)),
                  //      ),
                  //      onPressed: () {
                  //      
                  //      },
                  //    ),
                  //  ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: const Image(image: AssetImage('noimage.jpeg'))
            ),
             const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
  