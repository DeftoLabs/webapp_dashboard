
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';


class OrdenView extends StatefulWidget {

  final String id;

  const OrdenView({super.key, required this.id});

  @override
  State<OrdenView> createState() => _OrdenViewState();
}

class _OrdenViewState extends State<OrdenView> {

  Ordenes? orden;

  @override
  void initState() {
    super.initState();
    final ordenesProvider = Provider.of<OrdenesProvider>(context, listen: false);
    final ordenFormProvider = Provider.of<OrdenFormProvider>(context, listen: false);

    ordenesProvider.getOrdenById(widget.id)
    .then((ordenDB) {
        ordenFormProvider.orden = ordenDB;
        setState(() { orden = ordenDB;});
      }
    );   
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
                      NavigationService.navigateTo('/dashboard/orders/records');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'Orden View',
                    style: GoogleFonts.plusJakartaSans(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
        const SizedBox(height: 20),
           if(orden == null) WhiteCard(
                  child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(
                    color: Color.fromRGBO(255, 0, 200, 0.612),
                    strokeWidth: 4.0),
              )),
              
              if(orden !=null)
              _OrdenViewBody()
        ],
      )
    );
  }
}

class _OrdenViewBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty
        ? profileProvider.profiles[0]
        : null;

    if (profile == null) {
      return const Center(child: Text(''));
    }

    final ordenFormProvider = Provider.of<OrdenFormProvider>(context);
    final orden = ordenFormProvider.orden!;
    

    final image = (profile.img == null)
        ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35)
        : FadeInImage.assetNetwork(
            placeholder: 'load.gif',
            image: profile.img!,
            width: 35,
            height: 35);

    return Container(
        width: 250,
        height: 700,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)
                  )
                ]
              ),
          child: Column(
            children: [
             const SizedBox(height: 20),
              Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( profile.razons,
                        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text( profile.direccion,
                        style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                        const SizedBox(height: 2),
                        Text( 'Phone: ${profile.telefono}',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                        const SizedBox(height: 2),
                        Text( 'email: ${profile.email1}',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                      ],
                    )),

                Container(
                  height: 100,
                  width: 200,
                   margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                Text('Create:', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(width: 5),
                Text(
                 DateFormat('dd/MM/yy - HH:mm').format(orden.fechacreado),
                 style: GoogleFonts.plusJakartaSans(
                   fontSize: 14,
                   fontWeight: FontWeight.normal,
                 ),
                 ),
              ],
            ),
                  Row(
              children: [
                Text('Modify:', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(width: 5),
                Text(
                 DateFormat('dd/MM/yy - HH:mm').format(orden.updatedAt),
                 style: GoogleFonts.plusJakartaSans(
                   fontSize: 14,
                   fontWeight: FontWeight.normal,
                 ),
                 ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text('# CONTROL', style: GoogleFonts.plusJakartaSans(fontSize: 16)),
                const SizedBox(width: 5),
                Text(orden.control, style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            )
                 ],
        ),
                ),
                const SizedBox(width: 80),

                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipOval(
                    child: image,
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
             Row(
  children: [
    const SizedBox(width: 10),
    // Primer cuadro responsivo
    Flexible(
      flex: 2,
      child: Container(
        height: 220,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text('CUSTOMER INFO', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('CODE:', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(orden.clientes.first.codigo, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(orden.clientes.first.nombre, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                    Text(orden.clientes.first.sucursal, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('ADDRESS:', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25, 
                    child: Text(
                      orden.clientes.first.direccion,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: null,
                      softWrap: true, 
                    ),
                  ),
                  ],
                ),
                const SizedBox(height: 5),
                 Row(
                  children: [
                    Text('PHONE:', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(orden.clientes.first.telefono, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                 Row(
                  children: [
                    Text('email:', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(orden.clientes.first.correo, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),
    
    const SizedBox(width: 10),

    // Segundo cuadro responsivo
    Flexible(
      flex: 2,
      child: Container(
        height: 220,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text('CREDIT:', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(orden.clientes.first.credito.toString(), style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Text('DAYS', style: GoogleFonts.plusJakartaSans(fontSize: 14,fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(orden.ruta.first.usuarioZona.nombre, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                    Text(orden.ruta.first.usuarioZona.zone, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                    Text('ROUTE:', style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                    const SizedBox(width: 5),
                    Text(orden.ruta.first.nombreRuta, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('DELIVERY:', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                    const SizedBox(width: 5),
                        SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25, 
                    child: Text(
                      orden.clientes.first.direccion,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: null,
                      softWrap: true, 
                    ),
                  ),
                  ],
                ),
                const SizedBox(height: 10),
                 Row(
                  children: [
                    Text('TYPE:', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(orden.tipo, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                 Row(
                  children: [
                    Text('STATUS:', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(orden.status, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                     Row(
                  children: [
                    Text('DELIVERY DATE:', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                    const SizedBox(width: 5),
                     Text(
                    DateFormat('dd/MM/yy').format(orden.fechaentrega),
                    style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                 ),
                 ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),

    const SizedBox(width: 10),
  ],
),
          const Divider(
          indent: 30,
          endIndent: 30,
          color: Colors.black
        ),
              Text('Datos del producto + Cuadro'),
              Divider(),
              Text('Observaciones'),
              Text('Boton de Safe')
            ],
          ),
    );
  }
}