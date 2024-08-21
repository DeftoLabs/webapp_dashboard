import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/zona.dart';
import 'package:web_dashboard/providers/route_form_provider.dart';
import 'package:web_dashboard/providers/routes_providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class NewRouteView extends StatefulWidget {


  const NewRouteView({super.key,});

  @override
  State<NewRouteView> createState() => _NewRouteViewState();
}

class _NewRouteViewState extends State<NewRouteView> {
  Zona? zona;
  late GoogleMapController _mapController;


  @override
  Widget build(BuildContext context) {

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
                    NavigationService.replaceTo('/dashboard/routes');
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              Expanded(
                  child: Center(
                child: Text('Create a New Route', style: CustomLabels.h1),
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
              const SizedBox(
                height: 10,
              )
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

    final routeFormProvider = Provider.of<RouteFormProvider>(context);
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
                        labelText: 'Internal Route Code',
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 12),
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
                      onChanged: (value)=> routeFormProvider.copyRouteWith (codigo: value)),
                  const SizedBox(height: 10),
                  TextFormField(
                      initialValue: zona.nombrezona,
                      style: const TextStyle(color: Colors.white), // Añade esta línea
                      decoration: InputDecoration(
                        hintText: 'Route Name',
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.7)),
                        labelText: 'Route Name',
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 12),
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
                          return 'Code Name is required';
                        }else if (value.length >20){
                          return 'The description cannot exceed 20 characters';
                        }
                        return null;
                      },
                      onChanged: (value)=> routeFormProvider.copyRouteWith (nombrezona: value)),
                  const SizedBox(height: 10),
                  TextFormField(
                      initialValue: zona.descripcion,
                      style: const TextStyle(color: Colors.white), // Añade esta línea
                      decoration: InputDecoration(
                        hintText: 'Route Descripcion',
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.7)),
                        labelText: 'Description',
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 12),
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
                      minLines: 3,
                      expands: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is required';
                        } else if (value.length >60){
                          return 'The description cannot exceed 60 characters';
                        }
                        return null;
                      },
                      onChanged: (value) => routeFormProvider.copyRouteWith (descripcion: value)),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.center,
                    child: CustomOutlineButtom(
                      onPressed: () async {
                        final saved = await routeFormProvider.updateRoute();
                        if(saved) {
                          NotificationService.showSnackBa('Route Updated');
                          if (!context.mounted) return;
                          Provider.of<RoutesProviders>(context, listen: false).refreshRoute(zona);
                          
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
           WhiteCardColor(
            child: 
            Center(
              child: SizedBox(
                height: 80,
                child: Text('With version 2.0, you will be able to select areas (Routes) on the map.',   style:GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      )
              ),
            )
            )
      ],
    );

  }
}
