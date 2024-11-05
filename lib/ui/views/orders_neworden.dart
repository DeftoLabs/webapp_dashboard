
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/providers.dart';


class OrdersNewOrdern extends StatelessWidget {
  const OrdersNewOrdern({super.key});

  @override
  Widget build(BuildContext context) {
        final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty
        ? profileProvider.profiles[0]
        : null;

    if (profile == null) {
      return const Center(child: Text(''));
    }

     final image = (profile.img == null)
        ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35)
        : FadeInImage.assetNetwork(
            placeholder: 'load.gif',
            image: profile.img!,
            width: 35,
            height: 35);            

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
                    Navigator.pushReplacementNamed(context, '/dashboard/orders');
                  },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'CREATE A ORDER',
                    style: GoogleFonts.plusJakartaSans(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                  SizedBox(
                width: 50,
                height: 50,
                child: ClipOval(
                  child: image,
                ),
              ),
              ],
            ),
            const SizedBox(height: 20),
            const OrdenBody()
          ],
        ));
  }
}

class OrdenBody extends StatefulWidget {
  const OrdenBody({super.key});

  @override
  State<OrdenBody> createState() => _OrdenBodyState();
}

class _OrdenBodyState extends State<OrdenBody> {

  
  @override
  Widget build(BuildContext context) {

    String? selectedUsuarioZona;
    String? selectedCliente;
    DateTime? fechaEntrega;

    return Container(
      height: 700,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]),
          child: Column(
            children: [
              Form(
                // key:
                child:
                Column(
                  children: [
                    SizedBox( 
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: 
                      Column(
                        children: [
                          const SizedBox(height: 20),
              Row(
              children: [
                const SizedBox(width: 20),
                Text('DELIVERY DATE:',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                const SizedBox(width: 5),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: fechaEntrega ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Colors.black,
                            hintColor: Colors.black,
                            colorScheme: const ColorScheme.light(primary: Colors.black),
                            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      setState(() {
                        fechaEntrega = pickedDate; // Actualiza el estado con la fecha seleccionada
                        print(pickedDate);
                      });
                    }
                  },
                ),
              ],
            ),
              const SizedBox(height: 10),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20),
                                // Dropdown para seleccionar usuarioZona
                                Consumer<RutaProvider>(
                                  builder: (context, rutaProvider, child) {
                                    if (rutaProvider.rutas.isEmpty) {
                                      return const Text('No Routes Available');
                                    }
                            
                                    return SizedBox(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedUsuarioZona,
                                        decoration: InputDecoration(
                                          hintText: 'SELECT USER',
                                          hintStyle: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        style: GoogleFonts.plusJakartaSans(color: Colors.black),
                                        dropdownColor: Colors.white,
                                        items: rutaProvider.rutas.map((ruta) {
                                          return DropdownMenuItem<String>(
                                            value: ruta.usuarioZona.uid,
                                            child: Text(
                                              ruta.usuarioZona.nombre,
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedUsuarioZona = value;
                                          });
                            
                                          // Actualiza la lista de clientes en el RutaProvider
                                          if (value != null) {
                                            rutaProvider.actualizarClientesRuta(value);
                                            // Reinicia el cliente seleccionado al cambiar de usuarioZona
                                            selectedCliente = null;
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'PLEASE SELECT A USER';
                                          }
                                          return null;
                                        },
                                      ),
                                    );
                                  },
                                ),
                            
                                const SizedBox(width: 20),
                            
                                // Dropdown para seleccionar cliente
                                Consumer<RutaProvider>(
                                  builder: (context, rutaProvider, child) {
                                    // Si no hay clientes, mostramos un mensaje o un dropdown vacío
                                    if (rutaProvider.clientesRutaSeleccionada.isEmpty) {
                                      return const Text('');
                                    }
                            
                                    return SizedBox(
                                      width: 400,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedCliente,
                                        decoration: InputDecoration(
                                          hintText: 'SELECT A CUSTOMER',
                                          hintStyle: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        style: GoogleFonts.plusJakartaSans(color: Colors.black),
                                        dropdownColor: Colors.white,
                                        items: rutaProvider.clientesRutaSeleccionada.map((cliente) {
                                          return DropdownMenuItem<String>(
                                            value: cliente.id, // usa el ID o algún identificador del cliente
                                            child: Text(
                                              cliente.nombre,
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCliente = value;
                                            print(selectedCliente);
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'PLEASE SELECT A CLIENT';
                                          }
                                          return null;
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )

                          ],
                        ),
                      ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.green,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.blueAccent
                    )
                  ],
                ))

              

            ],
          )
          );
  }
}