import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/providers/customers_provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/providers/ruta_form_provider.dart';
import 'package:web_dashboard/providers/ruta_provider.dart';
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
                    'Route View',
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

  final List<String> diasSemana = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  @override
  Widget build(BuildContext context) {

    final rutaFormProvider = Provider.of<RutaFormProvider>(context);
    final ruta = rutaFormProvider.ruta!;

    clientesEnRuta = ruta.clientes;


    return WhiteCardColor(
      child: SizedBox(
        width: 420,
        height: 260,
        child: Column(
          children: [
            Text(
              'Remove or Edit a Customer from Route',
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
                          hintText: 'Select Customer',
                          labelText: 'Select Customer',
                          labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, 
                            fontSize: 16,
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
                        items: ruta.clientes.map((customer) {
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
                            hintText: 'Select Day of the Week',
                            labelText: 'Day of the Week',
                            labelStyle: GoogleFonts.plusJakartaSans(
                              color: Colors.white, 
                              fontSize: 16,
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
                              child: Text(dia,
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
                            'Remove',
                            style: GoogleFonts.plusJakartaSans(
                                color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                          ),  
                          onPressed: () {

                              if (selectedCustomerId == null) {
                              NotificationService.showSnackBarError('Select a valid Customer and Day of the week');
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
                                          text: 'Are you sure to ',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'REMOVE',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: const Color.fromRGBO(255, 152, 0, 1), // Cambia el color aquí
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' this customer from the route?',
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
                                          'Branch: ${customer.sucursal}',
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
                                  child: Text('No', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white))),
                                TextButton(
                                  onPressed: () async {
                                   final rutaId = ruta.id;
                                   if(selectedCustomerId != null && rutaId !=null) {
                                    try {
                                    await Provider.of<RutaProvider>(context, listen: false).deleteCustomerRuta(rutaId, selectedCustomerId!);
                                    NotificationService.showSnackBa('The customer has been removed from the route.');
                                    if(!context.mounted) return;
                                    Provider.of<RutaProvider>(context, listen: false).getPaginatedRoutes();
                                    Navigator.of(context).pop();        
                                    } catch (e) {
                                      NotificationService.showSnackBarError('Failed to remove the customer. Please try again.');
                                    }
                                   } else {
                                    NotificationService.showSnackBarError('Please select a customer and a route.');
                                   }
                                  },
                                  child: Text('Yes', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white)))  
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
                            'Save',
                            style: GoogleFonts.plusJakartaSans(
                                color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                          ),  
                          onPressed: () async {

                             if (selectedCustomerId == null || selectedDiaSemana == null) {
                              NotificationService.showSnackBarError('Select a valid Customer and Day of the week');
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
                                          text: 'Are you sure you want to ',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'MODIFY',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: const Color.fromARGB(255, 88, 164, 246), // Cambia el color aquí
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' this customer from the route?',
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
                                          'Branch: ${customer.sucursal}',
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
                                    text: 'Day of the Week: ', // Texto normal
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
                                  child: Text('No', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white))),
                                
                              TextButton(
                                onPressed: () async {
                                  if (selectedCustomerId != null && selectedDiaSemana != null) {
                                    final rutaId = ruta.id;
                              
                                    final isUpdated = await Provider.of<RutaFormProvider>(context, listen: false)
                                        .updateDayOfWeekForCustomer(rutaId!, selectedCustomerId!, selectedDiaSemana!);
                              
                                    if (isUpdated) {
                                      NotificationService.showSnackBa('Day of the week successfully updated');
                                      if (!context.mounted) return;
                                      Provider.of<RutaProvider>(context, listen: false).getPaginatedRoutes(); // Recarga las rutas actualizadas
                                    } else {
                                      NotificationService.showSnackBarError('Error updating the day of the week. Please try again.');
                                    }
                                  } else {
                                    // Mostrar el mensaje si no se selecciona un cliente o día
                                    NotificationService.showSnackBarError('Please select a client and a day of the week.');
                                  }
                                },
                                child: Text(
                                  'Yes',
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



  final List<String> diasSemana = [
    'Monday', 
    'Tuesday', 
    'Wednesday', 
    'Thursday', 
    'Friday', 
    'Saturday', 
    'Sunday'
  ];

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

    return WhiteCardColor(
      child: SizedBox(
        width: 420,
        height: 260,
        child: Column(
          children: [
            Text(
              'Add a Customer Route',
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
                  ? Text('No Customers Available', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16))
                  : SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                        value: selectedCustomerId,
                        decoration: InputDecoration(
                          hintText: 'Select Customer',
                          labelText: 'Select Customer',
                          labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, 
                            fontSize: 16,
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
                            hintText: 'Select Day of the Week',
                            labelText: 'Day of the Week',
                            labelStyle: GoogleFonts.plusJakartaSans(
                              color: Colors.white, 
                              fontSize: 16,
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
                              child: Text(dia,
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
                        'Add',
                        style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                      ),  
                     onPressed: () async {
                        if (selectedCustomerId == null || selectedDiaSemana == null) {
                          NotificationService.showSnackBarError('Select a valid Customer and Day of the week');
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
                                          text: 'Are you sure you want to ',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'ADD',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            color: const Color.fromRGBO(177, 255, 46, 100),// Cambia el color aquí
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' this customer from the route?',
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
                                          'Branch: ${customer.sucursal}',
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
                                    text: 'Day of the Week: ', // Texto normal
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
                                  child: Text('No', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white))),
                                TextButton(
                                  onPressed: () async {                              
                                     if (selectedCustomerId != null && selectedDiaSemana != null) {
                                    try {
                                    await rutaFormProvider.updateRutaWithCustomer(selectedCustomerId!, selectedDiaSemana!);  
                                    NotificationService.showSnackBa('The customer has been Added from the route.');
                                    if(!context.mounted) return;
                                    Navigator.of(context).pop();        
                                    } catch (e) {
                                      NotificationService.showSnackBarError('Error to Update the Route');
                                    }
                                   } else {
                                    NotificationService.showSnackBarError('Please select a customer and a route.');
                                   }
                                  },
                                  child: Text('Yes', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white)))  
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
    return WhiteCardColor(
      child: SizedBox(
        height: 260,
        child: Column(
          children: [
            Text(
              'General Information',
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
                'Route Code',
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
                'Route Name:',
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
                'Sale Representative:',
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
                'Total Customer',
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
                    'Edit Route Information',
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
                    decoration: const InputDecoration(
                      hintText: 'Route Name',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                      labelText: 'Route Name',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 58, 60, 65)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
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
                        return 'Route Name is Required';
                      }
                      if (value.length > 20) {
                        return 'Max 20 characters';
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
                          hintText: 'Sales Representative',
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
                        'Save',
                        style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: () async {
                        final saved = await rutaFormProvider.updateRuta();
                        if (saved) {
                          if (!context.mounted) return;
                          NotificationService.showSnackBa('Route Updated');
                          Navigator.of(context).popAndPushNamed('/dashboard/routes');
                          Provider.of<RutaProvider>(context, listen: false).getPaginatedRoutes();
                        } else {
                          NotificationService.showSnackBarError(
                              'Error to Update the Route');
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
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$dia - Customers: (${clientesDelDia.length})',
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          indent: 30,
                          endIndent: 30,
                          color: Colors.black,
                          thickness: 2,
                        ),
                        Expanded(
                            child: clientesDelDia.isEmpty ? 
                            Center(
                              child: Text('No Customer for this day', 
                              style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold))
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
                                          style: GoogleFonts.plusJakartaSans( fontSize: 12)),
                                          subtitle: Text(cliente.sucursal,
                                          style: GoogleFonts.plusJakartaSans( fontSize: 10, fontWeight: FontWeight.bold)
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
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: _scrollLeft,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
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
