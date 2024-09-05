import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/zona.dart';
import 'package:web_dashboard/providers/zone_form_provider.dart';
import 'package:web_dashboard/providers/zones_providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class ZoneView extends StatefulWidget {
  final String id;

  const ZoneView({super.key, required this.id});

  @override
  State<ZoneView> createState() => _ZoneViewState();
}

class _ZoneViewState extends State<ZoneView> {
  Zona? zona;
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    
    final routesProvider = Provider.of<ZonesProviders>(context, listen: false);
    final routeFormProvider =
        Provider.of<ZoneFormProvider>(context, listen: false);

    routesProvider.getZonasById(widget.id)
    .then((zonaDB) {
      if( zonaDB != null) {
      routeFormProvider.zona = zonaDB;
      routeFormProvider.formKey = GlobalKey<FormState>();
      setState(() { zona = zonaDB;});     
      } else {
        NavigationService.replaceTo('/dashboard/zones');
      }
    }
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    if (zona == null) {
      return const Center(
        child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 4.0),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Row(
            children: [
              IconButton(
                  color: Colors.black,
                  onPressed: () {
                    NavigationService.replaceTo('/dashboard/zones');
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              Expanded(
                  child: Center(
                child: Text('Zone View', style: CustomLabels.h1),
              )),
            ],
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const {
              0: FixedColumnWidth(350),
            },
            children: [
              TableRow(children: 
              [
                _RouteViewForm(), 
                _RouteMapView()
                ])
            ],
          )
        ],
      ),
    );
  }
}

class _RouteMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhiteCardColor(
      title: 'Map',
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 25),
              CustomIconButtonClear(
                  onPressed: () {},
                  text: 'Create a Zone on the Map',
                  icon: Icons.add_outlined),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Container(
                width: 600,
                height: 500,
                color: Colors.white,
                child: GoogleMap(
                  initialCameraPosition:
                  const CameraPosition(
                    target: LatLng(10.48801, -66.87919),
                    zoom: 10),
                    onMapCreated: (GoogleMapController controller) {

                    },
                    ),
              ),
              const SizedBox(height: 10),
              Center(
              child: SizedBox(
                child: Text('With version 2.0, you will be able to select areas on the map.',   style:GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      )
              ),
            ),
            const SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}

class _RouteViewForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final routeFormProvider = Provider.of<ZoneFormProvider>(context);
    final zona = routeFormProvider.zona!;

    return Column(
      children: [
        WhiteCardColor(
            title: 'Genereal Information',
            child: Form(
              key: routeFormProvider.formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      initialValue: zona.codigo,
                      style: const TextStyle(color: Colors.white), // Añade esta línea
                      decoration: InputDecoration(
                        hintText: 'Code',
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.7)),
                        labelText: 'Internal Zone Code',
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 16),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Code is required';
                        }else if (value.length >10){
                          return 'The code cannot exceed 10 characters';
                        }
                        return null;
                      },
                      onChanged: (value) {
                      final uppercaseValue = value.toUpperCase();
                      routeFormProvider.copyRouteWith (codigo: uppercaseValue);
                      } 
                      ),
                  const SizedBox(height: 10),
                  TextFormField(
                      initialValue: zona.nombrezona,
                      style: const TextStyle(color: Colors.white), // Añade esta línea
                      decoration: InputDecoration(
                        hintText: 'Zone Name',
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.7)),
                        labelText: 'Zone Name',
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 16),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Zone Name is required';
                        }else if (value.length >20){
                          return 'The description cannot exceed 20 characters';
                        }
                        return null;
                      },
                      onChanged: (value) {
                         final uppercaseValue = value.toUpperCase();
                      routeFormProvider.copyRouteWith (nombrezona: uppercaseValue);
                      } 
                      ),
                  const SizedBox(height: 10),
           
                  TextFormField(
                      initialValue: zona.descripcion,
                      style: const TextStyle(color: Colors.white), // Añade esta línea
                      decoration: InputDecoration(
                        hintText: 'Zone Descripcion',
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.7)),
                        labelText: 'Description',
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 16),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: null,
                      minLines: 2,
                      expands: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is required';
                        } else if (value.length >60){
                          return 'The description cannot exceed 60 characters';
                        }
                        return null;
                      },
                      onChanged: (value) {
                      final uppercaseValue = value.toUpperCase();
                      routeFormProvider.copyRouteWith (descripcion: uppercaseValue);
                      } 
                      
                      ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    child: CustomOutlineButtom(
                      onPressed: () async {
                        final saved = await routeFormProvider.updateRoute();
                        if(saved) {
                          NotificationService.showSnackBa('Zone Updated');
                          if (!context.mounted) return;
                          Provider.of<ZonesProviders>(context, listen: false).refreshRoute(zona);
                          NavigationService.replaceTo('/dashboard/zones');
                        } else {
                          NotificationService.showSnackBarError('Could not save the Route');
                        }
                      },
                      text: 'Save',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            )
            ),
            const SizedBox(height: 20),
      ],
    );

  }
}
