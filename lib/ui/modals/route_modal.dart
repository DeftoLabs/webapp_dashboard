import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/zona.dart';
import 'package:web_dashboard/providers/route_form_provider.dart';
import 'package:web_dashboard/providers/routes_providers.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class RouteModal extends StatefulWidget {
  final Zona? zona;
  final formKey = GlobalKey<FormState>();

  RouteModal({super.key, this.zona});

  @override
  State<RouteModal> createState() => _RouteModalState();
}

class _RouteModalState extends State<RouteModal> {
  String? id;
  String codigo = '';
  String nombrezona = '';
  String descripcion = '';
  

  @override
  void initState() {
    super.initState();

    id = widget.zona?.id;
    codigo = widget.zona?.codigo ?? '';
    nombrezona = widget.zona?.nombrezona ?? '';
    descripcion = widget.zona?.descripcion ?? '';
    
  
  }

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RoutesProviders>(context, listen: false);
    final routeFormProvider = Provider.of<RouteFormProvider>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 540,
        width: 600, 
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:  const Color.fromARGB(255, 58, 60, 65),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: routeFormProvider.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Route',
                    style: CustomLabels.h1.copyWith(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(color: Colors.white70),
          
              const SizedBox(height: 40),
          
               TextFormField(
                initialValue: widget.zona?.codigo ?? '',
                onChanged: (value) => codigo = value,
                decoration: InputDecoration(
                  hintText: 'Internal Route Code',
                  labelText: 'Route Code',
                  labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                  hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white.withOpacity(0.7)),
                  focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                    errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  errorStyle: GoogleFonts.plusJakartaSans(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                style: GoogleFonts.plusJakartaSans(color: Colors.white),
                validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Code is required';
                    }else if (value.length >10){
                      return 'The code cannot exceed 10 characters';
                    }
                    return null;
                  },
              ),
              const SizedBox(height: 10),
                           TextFormField(
                initialValue: widget.zona?.nombrezona ?? '',
                onChanged: (value) => nombrezona = value,
                decoration: InputDecoration(
                  hintText: 'Route Name',
                  labelText: 'Route Name',
                  labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                  hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white.withOpacity(0.7)),
                  focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  errorStyle: GoogleFonts.plusJakartaSans(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                style: GoogleFonts.plusJakartaSans(color: Colors.white),
                 validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Code Name is required';
                        }else if (value.length >20){
                          return 'The description cannot exceed 20 characters';
                        }
                        return null;
                      },
              ),
              
                const SizedBox(height: 10),
                           TextFormField(
                initialValue: widget.zona?.descripcion ?? '',
                onChanged: (value) => descripcion = value,
                decoration: InputDecoration(
                  hintText: 'Description',
                  labelText: 'Description',
                  labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                  hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white.withOpacity(0.7)),
                  focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                   errorStyle: GoogleFonts.plusJakartaSans(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                maxLines: null,
                minLines: 2,
                expands: false,
                style: GoogleFonts.plusJakartaSans(color: Colors.white),
                    validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is required';
                          } else if (value.length >60){
                            return 'The description cannot exceed 60 characters';
                          }
                          return null;
                        },
              ),
              const SizedBox(height: 20),
              RichText
              ( textAlign: TextAlign.center,
                text: TextSpan(text:'Important: The Code and Name must be unique, cannot be repeated.', 
                style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16))),
              const SizedBox(height: 20),
              Container(
  alignment: Alignment.center,
  child: CustomOutlineButtomColor(
    onPressed: () async {
      if (routeFormProvider.formKey.currentState!.validate()) {
        try {
          if (id == null) {
            await routeProvider.newRoute(codigo, nombrezona, descripcion);
            NotificationService.showSnackBa('Created');
          }
          if(!context.mounted) return;
          Navigator.of(context).pop();
        } catch (e) {
          if (mounted) NotificationService.showSnackBarError('Could not save the Route');
          if (mounted) Navigator.of(context).pop();
        }
      }
    },
    text: 'Save',
    color: const Color.fromRGBO(177, 255, 46, 1),
    isFilled: true,
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}
