
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_salesrepresentative_datasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';



class OrdersSaleRepresentativeView extends StatefulWidget {
  const OrdersSaleRepresentativeView({super.key});

  @override
  State<OrdersSaleRepresentativeView> createState() => _OrdersSaleRepresentativeViewState();
}

class _OrdersSaleRepresentativeViewState extends State<OrdersSaleRepresentativeView> {

@override
void initState() {
  super.initState();
  final ordenDateProvider = Provider.of<OrdenDateProvider>(context, listen: false);
  final currentUser = Provider.of<AuthProvider>(context, listen: false).user;

  if (currentUser != null) {
    ordenDateProvider.getOrdenByRepresentative(currentUser.uid).catchError((error) {
      debugPrint('Error fetching orders for representative: $error');
    });
  }
}



  @override
  Widget build(BuildContext context) {

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    final currentUser = Provider.of<AuthProvider>(context).user;
    

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
    final ordenDateProvider = Provider.of<OrdenDateProvider>(context);
    // final ordenProvider = Provider.of<OrdenesProvider>(context);

      if (ordenDateProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ordersDataSource = OrdersSalesRepresentativeDataSource( ordenDateProvider.ordenes );

     final double screenWidth = MediaQuery.of(context).size.width;

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
                child: Text('Welcome ${currentUser!.nombre}', style: GoogleFonts.plusJakartaSans(fontSize: 22))),
                Container(
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
                          'Create Order',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () {
                         NavigationService.replaceTo('/dashboard/orders/neworder');
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

          const SizedBox(height: 10),
Column(
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // Mostrar la tabla o el mensaje condicionalmente
        ordersDataSource.rowCount == 0
            ? Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 200),
        child: RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        color: Colors.black,
      ),
      children: [
        const TextSpan(
          text: 'NO ORDERS FOUND FOR: ', // Texto sin negritas
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        TextSpan(
          text: currentUser.nombre, // Nombre en negritas
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
        ),
      ),
    )
    
            : PaginatedDataTable(
                columns:[
                  DataColumn(label: Text('# ORDER',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('DATE',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('CUSTOMER',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('BRANCH',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('STATUS',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('EDIT',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                ],
                source: ordersDataSource,
              ),
      ],
    ),
  ],
)


        ],
      )
    );
  }
}
