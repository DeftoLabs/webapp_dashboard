
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/customers_datasource.dart';
import 'package:web_dashboard/providers/customers_provider.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';



class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {

  @override
  void initState() {
    super.initState();
    final customerProvider = Provider.of<CustomersProvider>(context, listen: false);
    customerProvider.getPaginatedCustomers();
  }


  @override
  Widget build(BuildContext context) {

    final customerProvider = Provider.of<CustomersProvider>(context);
    final customersDataSource = CustomersDatasource( customerProvider.customers );

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
            const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded
              (
                child: Text('CUSTOMERS VIEW', style: GoogleFonts.plusJakartaSans(fontSize: 22),)),
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
                      child: TextButton.icon(
                        onPressed: () {
                         NavigationService.replaceTo('/dashboard/newcustomer');
                        }, 
                        icon: const Icon(Icons.add, color: Colors.black),
                        label: Text(
                          'Customer',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
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
          sortAscending: customerProvider.ascending,
          sortColumnIndex: customerProvider.sortColumnIndex,
          columns: [
            DataColumn(label: const Text('Code'), onSort: (colIndex, _) {
              customerProvider.sortColumnIndex = colIndex;
              customerProvider.sort((customer)=> customer.codigo);
            }),
            DataColumn(label: const Text('Legal Name'), onSort: (colIndex, _) {
              customerProvider.sortColumnIndex = colIndex;
              customerProvider.sort((customer)=> customer.razons);
            }),
            const DataColumn(label: Text('Branch')),
            const DataColumn(label: Text('Zone')),
            const DataColumn(label: Text('Edit')),

          ], 
          source: customersDataSource,
            onPageChanged: ( page ) {

            },
          )
        ],
      )
    );
  }
}