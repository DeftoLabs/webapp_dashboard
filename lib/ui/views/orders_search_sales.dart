
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_searchdatedatasource.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';


class OrdersSearchSales extends StatefulWidget {
  const OrdersSearchSales({super.key});

  @override
  State<OrdersSearchSales> createState() => _OrdersSearchSalesState();
}

class _OrdersSearchSalesState extends State<OrdersSearchSales> {

  String? usuarioZona;

    @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
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

    final ordenDateProvider = Provider.of<OrdenDateProvider>(context);

      if (ordenDateProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ordersDataSource = OrdersSearchDateDataSource(ordenDateProvider.ordenes);

    final localizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                    color: Colors.black,
                    onPressed: () {
                      NavigationService.replaceTo('/dashboard/orders');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  localizations.seachbysalesrepresentative,
                  style: GoogleFonts.plusJakartaSans(fontSize: 22),
                )),
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
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                     color: const Color.fromARGB(255, 58, 60, 65),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                  children: [
                    Text(
                      localizations.salesrepresentative,
                      style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Consumer<UsersProvider>(
                      builder: (context, usersProvider, child) {
                        if (usersProvider.isLoading) {
                          return const CircularProgressIndicator(); // Mostrar indicador de carga
                        }
                        
                        return DropdownButton<String>(
                          value: usuarioZona,
                          hint: Text(localizations.select, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white)),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          dropdownColor: const Color.fromARGB(255, 145, 148, 154).withValues(alpha: 0.9),
                          items: usersProvider.users.map((user) {
                            return DropdownMenuItem<String>(
                              value: user.uid,
                              child: Text(user.nombre, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              usuarioZona = newValue;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                       TextButton(
                onPressed: () async {
  try {
    if (usuarioZona == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withValues(alpha: (0.9)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(localizations.warning, style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            content: Text(
              localizations.selectasalesrepresentative,
              style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
            ),
          );
        },
      );
    } else {
      await context.read<OrdenDateProvider>().getOrdenByRepresentative(usuarioZona!);
    }
  } catch (e) {
    if (e.toString().contains(localizations.noordernysalesrepresentative)) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withValues(alpha: (0.9)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.noorder,
                    style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              content: Text(
                localizations.noordercurrentlysalesrepresentative,
                style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),
              ),
            );
          },
        );
      }
    } else {
      NotificationService.showSnackBarError('Error with the Sales Representative Order');
    }
  }
},

                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                     backgroundColor: const Color.fromRGBO(177, 255, 46, 1),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  
                  child: Text(
                    localizations.search,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    
                  ),
                )
                  ],
                ),
          const SizedBox(height: 20),
          // Mostrar la tabla o el mensaje condicionalmente
          ordersDataSource.rowCount == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 150),
                    child: Text(
                      localizations.noroderfoundsales,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : PaginatedDataTable(
                  columns:[
                    DataColumn(label: Text(localizations.order        ,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localizations.create       ,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localizations.deliverydate ,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localizations.customer     ,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localizations.branch       ,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('STATUS',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localizations.representative  ,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localizations.edit         ,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                  source: ordersDataSource,
                  //columnSpacing: screenWidth * 0.019,
                ),
        ],
      ),
    ),
  ],
)


        ],
      )
    );
  }
}
  
  