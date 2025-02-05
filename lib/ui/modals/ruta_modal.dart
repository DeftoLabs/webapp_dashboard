import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/providers/ruta_form_provider.dart';
import 'package:web_dashboard/providers/ruta_provider.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class RutaModal extends StatefulWidget {
  final Ruta? ruta;
  final formKey = GlobalKey<FormState>();

  RutaModal({super.key, this.ruta});

  @override
  State<RutaModal> createState() => _RutaModalState();
}

class _RutaModalState extends State<RutaModal> {
  String? id;
  String codigoRuta = '';
  String nombreRuta = '';
  
  

  @override
  void initState() {
    super.initState();

    id = widget.ruta?.id;
    codigoRuta = widget.ruta?.codigoRuta ?? '';
    nombreRuta = widget.ruta?.nombreRuta ?? '';
 
    
  
  }

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RutaProvider>(context, listen: false);
    final routeFormProvider = Provider.of<RutaFormProvider>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 400,
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
                initialValue: widget.ruta?.codigoRuta ?? '',
                onChanged: (value) {
                  codigoRuta = value;
                  },
                decoration: InputDecoration(
                  hintText: 'Route Code',
                  labelText: 'Route Code',
                  labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                  hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white.withValues(alpha: 0.7)),
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
                initialValue: widget.ruta?.nombreRuta ?? '',
                  onChanged: (value) {
                  final uppercaseValue = value.toUpperCase();
                  nombreRuta = uppercaseValue;
                  },
                decoration: InputDecoration(
                  hintText: 'Route Name',
                  labelText: 'Route Name',
                  labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                  hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white.withValues(alpha: 0.7)),
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
                          return 'Route Name is required';
                        }else if (value.length >20){
                          return 'The description cannot exceed 20 characters';
                        }
                        return null;
                      },
              ),
              const SizedBox(height: 30),
              Container(
  alignment: Alignment.center,
  child: CustomOutlineButtomColor(
    onPressed: () async {
      if (routeFormProvider.formKey.currentState!.validate()) {
        try {
          if (id == null) {
            await routeProvider.newRoute(codigoRuta, nombreRuta);
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
