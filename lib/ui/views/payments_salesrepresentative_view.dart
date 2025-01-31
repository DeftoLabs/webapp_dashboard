import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/payments_salesrepresentative_datasource.dart';
import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/payments_provider.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';



class PaymentsSalesRepresentativeView extends StatefulWidget {
  const PaymentsSalesRepresentativeView({super.key});

  @override
  State<PaymentsSalesRepresentativeView> createState() => _PaymentsSalesRepresentativeViewState();
}

class _PaymentsSalesRepresentativeViewState extends State<PaymentsSalesRepresentativeView> {

  @override
  void initState() {
    super.initState();
   final paymentProvider = Provider.of<PaymentsProvider>(context, listen: false);
   final currectUser = Provider.of<AuthProvider>(context, listen: false).user;

   if(currectUser != null) {
    paymentProvider.getPaymentByRepresentative(currectUser.uid).catchError((error) {
      debugPrint('');
    });
   }
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

    final paymentProvider = Provider.of<PaymentsProvider>(context);

    if (paymentProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final paymentsDataSource = PaymentsSalesRepresentativeDataSource( paymentProvider.payments );
    
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
                child: Text('Payment View', style: GoogleFonts.plusJakartaSans(fontSize: 22),)),
                      const SizedBox(width: 20),
                    Container(
                       height: 50,
                       width: 170,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(177, 255, 46, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        )),
                      child: TextButton(
                        child: Text(
                          'Create Payment',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () {
                          NavigationService.replaceTo('/dashboard/paymentsbyrepresentative/create');
                        },
                      ),
                    ),
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
          PaginatedDataTable(

            columns: const [
              DataColumn(label: Text('DATE')),
              DataColumn(label: Text('CONTROL')),
              DataColumn(label: Text('TYPE')),
              DataColumn(label: Text('CUSTOMER')),
              DataColumn(label: Text('')),
              DataColumn(label: Text('AMOUNT')),
              DataColumn(label: Text('EDIT')),
            ],
            source: paymentsDataSource)
        ],
      )
    );
  }
}