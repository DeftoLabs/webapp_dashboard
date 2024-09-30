
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    ordenesProvider.getOrdenById(widget.id)
    .then((ordenDB) => setState(() { orden = ordenDB;}));
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
    return Container(
      child: Table(

      )
    );
  }
}