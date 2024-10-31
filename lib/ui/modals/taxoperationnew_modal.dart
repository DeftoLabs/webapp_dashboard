import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/taxoperation.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

class TaxOperationNewModal extends StatefulWidget {
final TaxOperation? taxoperations;

  const TaxOperationNewModal({super.key, this.taxoperations});

  @override
  State<TaxOperationNewModal> createState() => _TaxOperationNewModalState();
}

class _TaxOperationNewModalState extends State<TaxOperationNewModal> {
String? id;
String taxname = '';
double taxnumber = 0.0;

@override
  void initState() {
    super.initState();
    final taxoperationsFormProvider = Provider.of<TaxOperationFormProvider>(context, listen: false);
     taxoperationsFormProvider.formKey = GlobalKey<FormState>();
    if(widget.taxoperations !=null) {
      id = widget.taxoperations!.id;
      taxname = widget.taxoperations!.taxname;
      taxnumber = widget.taxoperations!.taxnumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taxoperationsFormProvider = Provider.of<TaxOperationFormProvider>(context, listen: false);
    taxoperationsFormProvider.taxoperation = widget.taxoperations;


    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 300,
        width: 400, 
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:  const Color.fromARGB(255, 58, 60, 65),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( 'ADD BUSINESS TAX',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => NavigationService.replaceTo('/dashboard/settings/finance'),
                ),
              ],
            ),
            const Divider(color: Colors.white70),

            const SizedBox(height: 20),
            Form(
             key: taxoperationsFormProvider.formKey,
              child: 
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min, 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Column(
                      children: [
                         Text('TAX NAME',
                          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                        SizedBox(
                          width: 150,
                          height: 60,
                          child:              
                         TextFormField(
                           initialValue: taxname,
                            onChanged: (value) {
                              taxname = value;
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                              ),
                            ),
                            style: GoogleFonts.plusJakartaSans(color: Colors.white),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6), // Limit to 6 characters
                            ],
                          ),
                                  ),
                      ],
                    ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  Text('TAX %',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: 
                                  TextFormField(
                                   initialValue: taxnumber.toString(),
                                    onChanged: (value) {
                                         double? parsedValue = double.tryParse(value);
                                         if (parsedValue != null) {
                                          taxnumber = parsedValue;
                                         }
                                       },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'This field is required';
                                      final regex = RegExp(r'^\d{1,2}(\.\d{1,2})?$');
                                      if (!regex.hasMatch(value)) {
                                        return 'Please enter a valid number (up to 2 decimals)';
                                      }
                                  
                                      final number = double.tryParse(value);
                                      if (number == null || number > 99.99) {
                                        return 'The value must not exceed 99.99';
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    decoration:InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: const BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                                      ),
                                      enabledBorder:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                    style: GoogleFonts.plusJakartaSans(color: Colors.white),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,2})?$')),
                                    ],
                                  ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                        ),
                             const SizedBox(height: 30),
                             Container(
                               alignment: Alignment.center,
                               child: Container(
                       height: 50,
                       width: 170,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        )),
                      child: TextButton(
                        child: Text(
                          'SAVE',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                           onPressed: () async {
                          if (taxoperationsFormProvider.validForm()) {
                            try {
                              if (id == null) {
                                await taxoperationsFormProvider.newTaxOperation(
                                 taxname,
                                 taxnumber
                                );
                                NotificationService.showSnackBa('New Business Tax Created');
                              }
                              if (!context.mounted) return;
                              Provider.of<TaxOperationProvider>(context, listen: false).getPaginatedTaxOperation();
                              NavigationService.replaceTo('/dashboard/settings/finance');

                            } catch (e) {
                              if (mounted) NotificationService.showSnackBarError('Could not save the Business Tax Profile');
                            } finally {
                              if (mounted) Navigator.of(context).pop();
                            }
                          }
                        },
                      ),
                    ),                              
                             ),
          ],
        ),
      ),
    );
  }
}
