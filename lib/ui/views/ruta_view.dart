import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class RutaView extends StatefulWidget {
  final String id;

  const RutaView({super.key, required this.id});

  @override
  State<RutaView> createState() => _RutaViewState();
}

class _RutaViewState extends State<RutaView> {
  Ruta? ruta;

  @override
  void initState() {
    super.initState();
    final rutaProvider = Provider.of<RutaProvider>(context, listen: false);
    final rutaFormProvider = Provider.of<RutaFormProvider>(context, listen: false);
    Provider.of<UsersProvider>(context, listen: false).loadUsersNoEnRutas();
    Provider.of<CustomersProvider>(context, listen: false).loadCustomerNoEnRutas();

    rutaProvider.getRouteById(widget.id).then((rutaDB) {
      rutaFormProvider.ruta = rutaDB;
      setState(() {
        ruta = rutaDB;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final localization = AppLocalizations.of(context)!;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                    color: Colors.black,
                    onPressed: () {
                      NavigationService.navigateTo('/dashboard/routes');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    localization.routedetail,
                    style: CustomLabels.h1,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            if (ruta == null)
              WhiteCard(
                  child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(
                    color: Color.fromRGBO(255, 0, 200, 0.612),
                    strokeWidth: 4.0),
              )),
            if (ruta != null) _RutaViewBody()
          ],
        ));
  }
}

class _RutaViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rutaFormProvider = Provider.of<RutaFormProvider>(context);
    final ruta = rutaFormProvider.ruta!;

    return Column(
      children: [
        SizedBox(
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(350),
              1: FixedColumnWidth(350),
            },
            children: [
              TableRow(children: [
                _RutaViewGeneralInfo(ruta: ruta),
                _RouteView(),
                const WhiteCardColor(
                  child: 
                  SizedBox (height: 265,))
              ])
            ],
          ),
        ),
Column(
  children: [
    Builder(
      builder: (context) {
        // Obtener el ancho de la pantalla usando MediaQuery
        final screenWidth = MediaQuery.of(context).size.width;

        // Verificar si el ancho de la pantalla es menor a 1180
        if (screenWidth < 1180) {
          // Si es menor a 1180, los widgets se organizan verticalmente
          return const Column(
            children: [
              _AddRouteCustomerView(),
              SizedBox(height: 10), // Espacio entre los widgets
              _DeleteRouteCustomerView(),
            ],
          );
        } else {
          // Si es mayor o igual a 1180, los widgets se organizan en una fila
          return Table(
            columnWidths: const {
              0: FixedColumnWidth(500),
              1: FixedColumnWidth(500),
            },
            children: const [
              TableRow(
                children: [
                  _AddRouteCustomerView(),
                  _DeleteRouteCustomerView(),
                ],
              ),
            ],
          );
        }
      },
    )
  ],
),
        const SizedBox(height: 10),
        _RutaPerDayView(id: ruta.id! ),
        const SizedBox(height: 30)
      ],
    );
  }
}

class _DeleteRouteCustomerView extends StatefulWidget {
  const _DeleteRouteCustomerView();

  @override
  State<_DeleteRouteCustomerView> createState() => _DeleteRouteCustomerViewState();
}

class _DeleteRouteCustomerViewState extends State<_DeleteRouteCustomerView> {

  String? selectedCustomerId;
  String? selectedDiaSemana;
  List<Customer> clientesEnRuta = [];
  

  @override
  Widget build(BuildContext context) {

    final rutaFormProvider = Provider.of<RutaFormProvider>(context);
    final ruta = rutaFormProvider.ruta!;

    clientesEnRuta = ruta.clientes;

    final localization = AppLocalizations.of(context)!;

    final diasSemana = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    final Map<String, String> traduccionDias = {
      'Monday': 'Lunes',
      'Tuesday': 'Martes',
      'Wednesday': 'Miércoles',
      'Thursday': 'Jueves',
      'Friday': 'Viernes',
      'Saturday': 'Sábado',
      'Sunday': 'Domingo'
    };

    return WhiteCardColor(
      child: SizedBox(
        width: 420,
        height: 260,
        child: Column(
          children: [
            Text(
              localization.removeoreditcustomerfromroute,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              indent: 30,
              endIndent: 30,
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            clientesEnRuta.isEmpty
              ? const CircularProgressIndicator(color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 2)
                  : SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                        value: selectedCustomerId,
                        decoration: InputDecoration(
                          //hintText: localization.selectcustomerroute,
                          labelText: localization.selectcustomerroute,
                          labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, 
                            fontSize: 12,
                          ),
                          hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        style: GoogleFonts.plusJakartaSans(color: Colors.white),
                        dropdownColor: Colors.grey[800],
                        items: ruta.clientes.map((customer) {
                            return DropdownMenuItem<String>(
                              value: customer.id,
                              child: Row(
                              children: [
                                Text(customer.nombre,
                                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 12)),
                                const SizedBox(width: 5),    
                                Text(customer.sucursal,
                                    style: GoogleFonts.plusJakartaSans(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)), 
                              ],
                            ));
                          }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCustomerId = value;
                          });
                        },
                      ),
                  ),
                  const SizedBox(height: 15),
                        SizedBox(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          value: selectedDiaSemana,
                          decoration: InputDecoration(
                            //hintText: 'Select Day of the Week',
                            labelText: localization.selectdayoftheweek,
                            labelStyle: GoogleFonts.plusJakartaSans(
                              color: Colors.white, 
                              fontSize: 12,
                            ),
                            hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          style: GoogleFonts.plusJakartaSans(color: Colors.black),
                          dropdownColor: Colors.grey[800],
                          items: diasSemana.map((dia) {
                            return DropdownMenuItem<String>(
                              value: dia,
                             child: Text(
                              traduccionDias[dia] ?? dia, // Traduce el día si existe en el mapa
                              style: const TextStyle(color: Colors.white),
                                  ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDiaSemana = value;
                            });
                          },
                        ),
                      ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 152, 0, 1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:const Color.fromARGB(255, 255, 194, 102),
                              width: 2,
                            )),
                        child: TextButton.icon(
                          icon:   const Icon(Icons.remove_circle_outline, color: Colors.black),
                          label:  Text(
                            localization.remove,
                            style: GoogleFonts.plusJakartaSans(
                                color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                          ),  
                          onPressed: () {

                              if (selectedCustomerId == null) {
                              NotificationService.showSnackBarError(localization.routeremovemessage01);
                              return;
                            }
                            final selectedCustomer = clientesEnRuta.firstWhere((customer) => customer.id == selectedCustomerId );

                          final customer = ruta.clientes.firstWhere(
                            (c) => c.id == selectedCustomerId,
                          );
                          

                            final dialog = AlertDialog(
                              backgroundColor: const Color.fromARGB(255, 98, 99, 103),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                  color:   Color.fromRGBO(255, 152, 0, 1),
                                  width: 2
                                )
                              ),
                              title: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: localization.routeremovemessage02,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: localization.removem,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: const Color.fromRGBO(255, 152, 0, 1), // Cambia el color aquí
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: localization.routeremovemessage03,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              content: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    const Divider(
                                        indent: 30,
                                        endIndent: 30,
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                    const SizedBox(height: 10),
                                    Text(selectedCustomer.nombre,
                                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                                    ),
                                   const SizedBox(height: 10),
                                   customer.sucursal.isNotEmpty 
                                      ? Text(
                                          '${localization.branchm} ${customer.sucursal}',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                    const SizedBox(height: 10),
                                       const Divider(
                                        indent: 70,
                                        endIndent: 70,
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                       const SizedBox(height: 10),
                                       
                                  ],
                                )),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  }, 
                                  child: Text('NO', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white))),
                                TextButton(
                                  onPressed: () async {
                                    
                                   final rutaId = ruta.id;

                                   if(selectedCustomerId != null && rutaId !=null) {
                                    try {
                                    await Provider.of<RutaProvider>(context, listen: false).deleteCustomerRuta(rutaId, selectedCustomerId!);
                                    NotificationService.showSnackBa(localization.routeremovemessage04);
                                     if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                    Provider.of<RutaProvider>(context, listen: false).getPaginatedRoutes();
                                       
                                    } catch (e) {
                                      NotificationService.showSnackBarError(localization.routeremovemessage05);
                                       if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                    }
                                   } else {
                                    NotificationService.showSnackBarError(localization.routeremovemessage06);
                                     if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                   }
                                  },
                                  child: Text(localization.yes, style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white)))  
                              ],
                            );

                            showDialog(context: context, builder: ( _ ) => dialog);
                          
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                       Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 52, 149, 251),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:  const Color.fromARGB(255, 88, 164, 246),
                              width: 2,
                            )),
                        child: TextButton.icon(
                          icon:   const Icon(Icons.edit, color: Colors.black),
                          label:  Text(
                            localization.savem,
                            style: GoogleFonts.plusJakartaSans(
                                color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                          ),  
                          onPressed: () async {

                             if (selectedCustomerId == null || selectedDiaSemana == null) {
                              NotificationService.showSnackBarError(localization.routeremovemessage07);
                              return;
  }
                            final selectedCustomer = clientesEnRuta.firstWhere((customer) => customer.id == selectedCustomerId );

                          final customer = ruta.clientes.firstWhere(
                            (c) => c.id == selectedCustomerId,
                          );
                          

                            final dialog = AlertDialog(
                              backgroundColor: const Color.fromARGB(255, 98, 99, 103),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                  color:   Color.fromARGB(255, 88, 164, 246),
                                  width: 2
                                )
                              ),
                              title: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:localization.routeremovemessage08,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: localization.modifym,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: const Color.fromARGB(255, 88, 164, 246), // Cambia el color aquí
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: localization.routeremovemessage09,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              content: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    const Divider(
                                        indent: 30,
                                        endIndent: 30,
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                    const SizedBox(height: 10),
                                    Text(selectedCustomer.nombre,
                                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                                    ),
                                   const SizedBox(height: 10),
                                    customer.sucursal.isNotEmpty 
                                      ? Text(
                                          '${localization.branchm} ${customer.sucursal}',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                    const SizedBox(height: 10),
                                       const Divider(
                                        indent: 70,
                                        endIndent: 70,
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                       const SizedBox(height: 10),
                                       Text.rich(
                                  TextSpan(
                                    text: localization.dayoftheweek, // Texto normal
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: selectedDiaSemana!, // Texto en negritas
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold, // Aplica solo negritas aquí
                                          color: const Color.fromARGB(255, 88, 164, 246), 
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ) 
                                       
                                  ],
                                )),
                              actions: [
                                 TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  }, 
                                  child: Text('NO', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white))),
                                
                              TextButton(
                                onPressed: () async {
                                  if (selectedCustomerId != null && selectedDiaSemana != null) {
                                    final rutaId = ruta.id;
                              
                                    final isUpdated = await Provider.of<RutaFormProvider>(context, listen: false)
                                        .updateDayOfWeekForCustomer(rutaId!, selectedCustomerId!, selectedDiaSemana!);
                              
                                    if (isUpdated) {
                                      NotificationService.showSnackBa(localization.routeremovemessage10);
                                      if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                      Provider.of<RutaProvider>(context, listen: false).getPaginatedRoutes(); // Recarga las rutas actualizadas
                                    } else {
                                      NotificationService.showSnackBarError(localization.routeremovemessage11);
                                      if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                    }
                                  } else {
                                    // Mostrar el mensaje si no se selecciona un cliente o día
                                    NotificationService.showSnackBarError(localization.routeremovemessage12);
                                    if (!context.mounted) return;
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  localization.yes,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white),
                                ),
                              )
                              ],
                            );
                            showDialog(context: context, builder: ( _ ) => dialog);
                          
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
      
    );
  }
}

class _AddRouteCustomerView extends StatefulWidget {
  const _AddRouteCustomerView();

  @override
  State<_AddRouteCustomerView> createState() => _AddRouteCustomerViewState();
}

class _AddRouteCustomerViewState extends State<_AddRouteCustomerView> {
  String? selectedCustomerId;
  String? selectedDiaSemana;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final customerProvider = Provider.of<CustomersProvider>(context, listen: false);
      customerProvider.loadCustomerNoEnRutas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomersProvider>(context);
    final customersNoEnRutas = customerProvider.customerNoEnRutas;

    final rutaFormProvider = Provider.of<RutaFormProvider>(context);


    final localization = AppLocalizations.of(context)!;

    final diasSemana = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    final Map<String, String> traduccionDias = {
        'Monday': 'Lunes',
        'Tuesday': 'Martes',
        'Wednesday': 'Miércoles',
        'Thursday': 'Jueves',
        'Friday': 'Viernes',
        'Saturday': 'Sábado',
        'Sunday': 'Domingo'
      };

    return WhiteCardColor(
      child: SizedBox(
        width: 420,
        height: 260,
        child: Column(
          children: [
            Text(
              localization.addcustomerroute,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              indent: 30,
              endIndent: 30,
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            customerProvider.isLoading
              ? const CircularProgressIndicator(color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 2)
              : customersNoEnRutas.isEmpty
                  ? Text(localization.nocustomeravailable, style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16))
                  : SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                        value: selectedCustomerId,
                        decoration: InputDecoration(
                          //hintText: 'Select Customer',
                          labelText: localization.selectcustomerroute,
                          labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, 
                            fontSize: 12,
                          ),
                          hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        style: GoogleFonts.plusJakartaSans(color: Colors.black),
                        dropdownColor: Colors.grey[800],
                        items: customersNoEnRutas.map((customer) {
                          return DropdownMenuItem<String>(
                            value: customer.id,
                            child: Row(
                              children: [
                                Text(customer.nombre,
                                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 12)),
                                const SizedBox(width: 5),    
                                Text(customer.sucursal,
                                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), 
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCustomerId = value;
                          });
                        },
                      ),
                  ),
                  const SizedBox(height: 15),
                        SizedBox(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          value: selectedDiaSemana,
                          decoration: InputDecoration(
                            //hintText: 'Select Day of the Week',
                            labelText: localization.dayoftheweek,
                            labelStyle: GoogleFonts.plusJakartaSans(
                              color: Colors.white, 
                              fontSize: 12,
                            ),
                            hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          style: GoogleFonts.plusJakartaSans(color: Colors.black),
                          dropdownColor: Colors.grey[800],
                          items: diasSemana.map((dia) {
                            return DropdownMenuItem<String>(
                              value: dia,
                              child: Text(
                              traduccionDias[dia] ?? dia, // Traduce el día si existe en el mapa
                              style: const TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDiaSemana = value;
                            });
                          },
                        ),
                      ),
                  const SizedBox(height: 25),
                  Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 200, 83, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(177, 255, 46, 100),
                          width: 2,
                        )),
                    child: TextButton.icon(
                      icon:   const Icon(Icons.add_circle_outline_outlined, color: Colors.black),
                      label:  Text(
                        localization.add,
                        style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                      ),  
                     onPressed: () async {
                        if (selectedCustomerId == null || selectedDiaSemana == null) {
                          NotificationService.showSnackBarError(localization.routeremovemessage01);
                          return;
                        }
                          if (selectedCustomerId != null && selectedDiaSemana != null) {

                             final customer = customersNoEnRutas.firstWhere(
                            (c) => c.id == selectedCustomerId,
                          );
                          
                          final dialog = AlertDialog(
                              backgroundColor: const Color.fromARGB(255, 98, 99, 103),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                  color:  Color.fromRGBO(177, 255, 46, 100),
                                  width: 2
                                )
                              ),
                              title: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: localization.routeremovemessage02,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: localization.addm,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: const Color.fromRGBO(177, 255, 46, 100),// Cambia el color aquí
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: localization.routeremovemessage03,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),              
                              content: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    const Divider(
                                        indent: 30,
                                        endIndent: 30,
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                    const SizedBox(height: 10),
                                    Text(customer.nombre,
                                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                                    ),
                                    const SizedBox(height: 10),
                                    customer.sucursal.isNotEmpty 
                                      ? Text(
                                          '${localization.branch} ${customer.sucursal}',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.amber,
                                            fontSize: 16,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                    const SizedBox(height: 10),
                                       const Divider(
                                        indent: 70,
                                        endIndent: 70,
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                       const SizedBox(height: 10),
                                            Text.rich(
                                  TextSpan(
                                    text: localization.dayoftheweek, // Texto normal
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: selectedDiaSemana!, // Texto en negritas
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold, // Aplica solo negritas aquí
                                          color: const Color.fromRGBO(177, 255, 46, 100),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ) 
                                
                                ],
                                )),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  }, 
                                  child: Text('NO', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white))),
                                TextButton(
                                  onPressed: () async {                              
                                     if (selectedCustomerId != null && selectedDiaSemana != null) {
                                    try {
                                    await rutaFormProvider.updateRutaWithCustomer(selectedCustomerId!, selectedDiaSemana!);  
                                    NotificationService.showSnackBa(localization.routeremovemessage13);
                                    if(!context.mounted) return;
                                    Navigator.of(context).pop();        
                                    } catch (e) {
                                      NotificationService.showSnackBarError(localization.routeremovemessage15);
                                    }
                                   } else {
                                    NotificationService.showSnackBarError(localization.routeremovemessage14);
                                   }
                                  },
                                  child: Text(localization.yes, style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white)))  
                              ],
                            );

                            showDialog(context: context, builder: ( _ ) => dialog);
                     }},
                              ),
                            ),
          ],
        ),
      ),
      
    );
  }
}


class _RutaViewGeneralInfo extends StatelessWidget {
  const _RutaViewGeneralInfo({
    required this.ruta,
  });

  final Ruta ruta;

  @override
  Widget build(BuildContext context) {

    final localization = AppLocalizations.of(context)!;

    return WhiteCardColor(
      child: SizedBox(
        height: 260,
        child: Column(
          children: [
            Text(
              localization.generalinformation,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Divider(
              indent: 30,
              endIndent: 30,
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                localization.routecode,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ruta.codigoRuta,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                localization.route,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ruta.nombreRuta,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                localization.salesrepresentativemap,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ruta.usuarioZona.nombre,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                localization.totalcustomers,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ruta.clientes.length.toString(),
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _RouteView extends StatefulWidget {
  @override
  State<_RouteView> createState() => _RouteViewState();
}

class _RouteViewState extends State<_RouteView> {
  @override
  Widget build(BuildContext context) {
    final rutaFormProvider = Provider.of<RutaFormProvider>(context);
    final ruta = rutaFormProvider.ruta!;

    final localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(
          height: 320,
          child: WhiteCard(
            child: Form(
              key: rutaFormProvider.formKey,
              child: Column(
                children: [
                  Text(
                    localization.editrouteinformation,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Colors.black,
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: ruta.nombreRuta,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      //hintText: 'Route Name',
                      hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
                      labelText: localization.routename,
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 58, 60, 65)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 58, 60, 65)),
                      ),
                    ),
                    onChanged: (value) {
                      final uppercaseValue = value.toUpperCase();
                      rutaFormProvider.copyRutaWith(nombreRuta: uppercaseValue);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization.routerequired;
                      }
                      if (value.length > 20) {
                        return localization.maxlegth20;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<UsersProvider>(
                    builder: (context, userProvider, child) {
                       if (userProvider.usersNoEnRutas.isEmpty) {
                      return const CircularProgressIndicator(color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 2); 
                    }
                    final currentUid = ruta.usuarioZona.uid;
                    final isValidUid = userProvider.usersNoEnRutas.any((user) => user.uid == currentUid);
                      return DropdownButtonFormField<String>(
                        value: isValidUid ? currentUid : null, 
                        decoration: InputDecoration(
                          hintText: localization.salesrepresentativemap,
                          labelText: ruta.usuarioZona.nombre,
                          labelStyle: GoogleFonts.plusJakartaSans(
                              color: Colors.black, fontSize: 16),
                          hintStyle:
                              GoogleFonts.plusJakartaSans(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        style: GoogleFonts.plusJakartaSans(color: Colors.black),
                        dropdownColor: Colors.white,
                        items: userProvider.usersNoEnRutas.map((user) {
                          return DropdownMenuItem<String>(
                            value: user.uid,
                            child: Text(user.nombre,
                                style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            ruta.usuarioZona.uid = value!;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 58, 60, 65),
                          width: 2,
                        )),
                    child: TextButton(
                      child: Text(
                        localization.save,
                        style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: () async {
                        final saved = await rutaFormProvider.updateRuta();
                        if (saved) {
                          if (!context.mounted) return;
                          NotificationService.showSnackBa(localization.routeuodate);
                          Navigator.of(context).popAndPushNamed('/dashboard/routes');
                          Provider.of<RutaProvider>(context, listen: false).getPaginatedRoutes();
                        } else {
                          NotificationService.showSnackBarError(localization.routeremovemessage15);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _RutaPerDayView extends StatefulWidget {
  final String id;

  const _RutaPerDayView({required this.id});

  @override
  State<_RutaPerDayView> createState() => _RutaPerDayViewState();
}

class _RutaPerDayViewState extends State<_RutaPerDayView> {
  final ScrollController _scrollController = ScrollController();
  late RutaProvider rutaProvider;
   Ruta? ruta;
   

@override
  void initState() {
    super.initState();
    final rutaProvider = Provider.of<RutaProvider>(context, listen: false);
    rutaProvider.getRouteById(widget.id).then((rutaDB) {
      setState(() {
        ruta = rutaDB;
      });
    });
  }

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset - 300, // Left
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 300, // Rigth
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    if(ruta == null) {
      return const Center(
        child: CircularProgressIndicator(color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 2),
      );
    }

     final List<Customer> clientes = ruta!.clientes;

    final diasSemana = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    final Map<String, String> traduccionDias = {
        'Monday': 'Lunes',
        'Tuesday': 'Martes',
        'Wednesday': 'Miércoles',
        'Thursday': 'Jueves',
        'Friday': 'Viernes',
        'Saturday': 'Sábado',
        'Sunday': 'Domingo'
      };

    final localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: diasSemana.length,
                itemBuilder: (context, index) {
                  String dia = diasSemana[index];

                  List<Customer> clientesDelDia = clientes
                      .where((cliente) => cliente.diasemana == dia)
                      .toList();

                  return Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 58, 60, 65),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${traduccionDias[dia] ?? dia} - ${localization.customers}: (${clientesDelDia.length})',
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          indent: 30,
                          endIndent: 30,
                          color: Color.fromRGBO(177, 255, 46, 1),
                          thickness: 2,
                        ),
                        Expanded(
                            child: clientesDelDia.isEmpty ? 
                            Center(
                              child: Text(localization.nocustomerthisday, 
                              style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold))
                            ) : 
                            ListView.builder(
                                itemCount: clientesDelDia.length,
                                itemBuilder: (context, index) {
                                  final cliente = clientesDelDia[index];
                                  return Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    child: ListTile(
                                        title: Text( cliente.nombre,
                                          style: GoogleFonts.plusJakartaSans( fontSize: 12, color: Colors.white)),
                                          subtitle: Text(cliente.sucursal,
                                          style: GoogleFonts.plusJakartaSans( fontSize: 10,color: Colors.amber ,fontWeight: FontWeight.bold)
                                          ),
                                        visualDensity: const VisualDensity(
                                            horizontal: -4, vertical: -4)),
                                  );
                                }))
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: _scrollLeft,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: _scrollRight,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
