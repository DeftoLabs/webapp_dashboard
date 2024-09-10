import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/providers/customers_provider.dart';
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
    final rutaFormProvider =
        Provider.of<RutaFormProvider>(context, listen: false);

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
                      NavigationService.replaceTo('/dashboard/routes');
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
          height: 350,
          child: Table(
            columnWidths: const {0: FixedColumnWidth(300)},
            children: [
              TableRow(children: [
                WhiteCardColor(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                        Text(
                          'General Information',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          indent: 30,
                          endIndent: 30,
                          color: Colors.white,
                          thickness: 2,
                        ),
                        const SizedBox(height: 15),
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
                                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 15),
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
                                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 15),
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
                                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 15),
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
                                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                _RouteView()
              ])
            ],
          ),
        ),
        const SizedBox(height: 10),
        _RutaPerDayView(clientes: ruta.clientes),
      ],
    );
  }
}

class _RouteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rutaFormProvider = Provider.of<RutaFormProvider>(context);
    final ruta = rutaFormProvider.ruta!;

    return Column(
      children: [
        SizedBox(
          height: 355,
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
                      rutaFormProvider.copyRutaWith( nombreRuta: uppercaseValue);

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
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(177, 255, 46, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(177, 255, 46, 1),
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
                        if(saved) {
                           if (!context.mounted) return;
                            NotificationService.showSnackBa('Route Updated');
                            Navigator.of(context).popAndPushNamed('/dashboard/routes');
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
  final List<Customer> clientes;

  const _RutaPerDayView({required this.clientes});

  @override
  State<_RutaPerDayView> createState() => _RutaPerDayViewState();
}

class _RutaPerDayViewState extends State<_RutaPerDayView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final customerProvider =
        Provider.of<CustomersProvider>(context, listen: false);
    customerProvider.getPaginatedCustomers();
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
    final rutaProvider = Provider.of<RutaProvider>(context);
    final ruta = rutaProvider.rutas;

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
          height: 350,
          child: Stack(
            children: [
              ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: diasSemana.length,
                itemBuilder: (context, index) {
                  String dia = diasSemana[index];

                  List<Customer> clientesDelDia = widget.clientes
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
                              dia,
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
                            child: ListView.builder(
                                itemCount: clientesDelDia.length,
                                itemBuilder: (context, index) {
                                  final cliente = clientesDelDia[index];
                                  return Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    child: ListTile(
                                        title: Text(
                                          cliente.nombre,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                          ),
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
