import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/taxsales.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

class TaxSaleView extends StatefulWidget {

  final String id;

  const TaxSaleView({super.key, required this.id});

  @override
  State<TaxSaleView> createState() => _TaxSaleViewState();
}

class _TaxSaleViewState extends State<TaxSaleView> {

  TaxSales? taxsale;

  @override
  void initState() {
    super.initState();
    final taxsalesProvider = Provider.of<TaxSalesProvider>(context, listen: false);
    final taxsalesFormProvider = Provider.of<TaxSalesFormProvider>(context, listen: false);

    taxsalesProvider.getTaxSaleById(widget.id)
    
    .then((taxsaleDB) {
      if( taxsaleDB !=null ) {
      taxsalesFormProvider.taxsale = taxsaleDB; 
      taxsalesFormProvider.formKey = GlobalKey<FormState>();
      setState(() {
      taxsale = taxsaleDB;});
      } else {
        NavigationService.replaceTo('/dashboard/settings/finance');
      }
    
    } 
    );
  }

  @override
  void dispose() {
    Provider.of<TaxSalesFormProvider>(context, listen: false).taxsale = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    if(taxsale == null) {
      return const SizedBox(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(  color: Color.fromRGBO(255, 0, 200, 0.612),
          strokeWidth: 4.0),
        ),
      );
    }

    final taxsalesFormProvider = Provider.of<TaxSalesFormProvider>(context);
    final taxsales = taxsalesFormProvider.taxsale!;

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
                Text( 'EDIT SALES TAX',
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
              key: taxsalesFormProvider.formKey,
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
                            initialValue: taxsales.taxname,
                            onChanged: (value) {
                              taxsalesFormProvider.copyTaxSalesWith(taxname: value);
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
                                    initialValue: taxsales.taxnumber.toString(),
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
                                      onChanged: (value) {
                                         double? parsedValue = double.tryParse(value);
                                         if (parsedValue != null) {
                                          taxsalesFormProvider.copyTaxSalesWith(taxnumber: parsedValue);
                                         }
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
                                   final saved = await taxsalesFormProvider.updateTaxSales();
                                   if(saved) {
                                    NotificationService.showSnackBa('Sales Tax Updated');
                                      if (!context.mounted) return;
                                      Provider.of<TaxSalesProvider>(context, listen: false).refreshTaxSales(taxsales);
                                      NavigationService.replaceTo('/dashboard/settings/finance');
                                   } else {
                                    NotificationService.showSnackBarError('Error: The Sales Taxes were not updated');
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
