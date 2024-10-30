import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

class FinanceModal extends StatefulWidget {
  final Finance? finance;

  const FinanceModal({super.key, this.finance});

  @override
  State<FinanceModal> createState() => _FinanceModalState();
}

class _FinanceModalState extends State<FinanceModal> {
  String? id;
  String mainCurrencyname     = '';
  String mainCurrencysymbol   = '';
  String secondCurrencyname   = '';
  String secondCurrencysymbol = '';

  @override
  void initState() {
    super.initState();
    if( widget.finance !=null) {
      id = widget.finance!.id;
      mainCurrencyname = widget.finance!.mainCurrencyname;
      mainCurrencysymbol = widget.finance!.mainCurrencysymbol;
      secondCurrencyname = widget.finance!.secondCurrencyname;
      secondCurrencysymbol = widget.finance!.secondCurrencysymbol;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final financeFormProvider = Provider.of<FinanceFormProvider>(context, listen: false);
    financeFormProvider.finance = widget.finance;


    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 600,
        width: 500, 
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
                Text('ADD CURRENCY SETUP',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white)
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: Colors.white70),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 350,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]),
                  child: 
                  Form(
                    key:financeFormProvider.formKey,
                    child: Column(
                    children: [
                    const SizedBox(height: 20),
                    Text(
                      'Select the Currency',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      indent: 40,
                      endIndent: 40,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    Text('Main Currency:',
                        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey, // Color de fondo
                          foregroundColor: Colors.white, // Color del texto
                          textStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 16), // Estilo de texto
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 20.0), // Padding interno
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Bordes redondeados
                            side: const BorderSide(
                              color: Color.fromRGBO(0, 200, 83, 1),
                            ), // Color del borde (opcional)
                          ),
                        ),
                        onPressed: () {
                          showCurrencyPicker(
                            context: context,
                            showFlag: true,
                            showCurrencyName: true,
                            showCurrencyCode: true,
                            onSelect: (Currency currency) {
                              setState(() {
                                mainCurrencyname = currency.name;
                                mainCurrencysymbol = currency.symbol;
                              });
                            },
                          );
                        },
                       child: Text(mainCurrencyname.isNotEmpty
                              ? '$mainCurrencyname ($mainCurrencysymbol)'
                              : 'Select Currency',),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Secondary Currency:',
                        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey, // Color de fondo
                          foregroundColor: Colors.white, // Color del texto
                          textStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 16), // Estilo de texto
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 20.0), // Padding interno
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Bordes redondeados
                            side: const BorderSide(
                              color: Color.fromRGBO(0, 200, 83, 1),
                            ), // Color del borde (opcional)
                          ),
                        ),
                        onPressed: () {
                          showCurrencyPicker(
                            context: context,
                            showFlag: true,
                            showCurrencyName: true,
                            showCurrencyCode: true,
                            onSelect: (Currency currency) {
                              setState(() {
                                secondCurrencyname = currency.name;
                                secondCurrencysymbol = currency.symbol;
                              });
                            },
                          );
                        },
                        child: Text(secondCurrencyname.isNotEmpty
                              ? '$secondCurrencyname ($secondCurrencysymbol)'
                              : 'Select Currency',),
                      ),
                    ), 
                                    ],
                                  ),
                  ),

                  ),
           
            const SizedBox(height: 40),
              Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 200, 83, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(177, 255, 46, 100),
                          width: 2,
                        )),
                    child: TextButton(
                        child: Text(
                          'SAVE',
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          // Verificar que ambos nombres y símbolos estén seleccionados
                          if (mainCurrencyname.isEmpty || secondCurrencyname.isEmpty) {
                            NotificationService.showSnackBarError('Please select both currencies');
                            return;
                          }
                          if (financeFormProvider.validForm()) {
                            try {
                              if (id == null) {
                                // Crear una nueva configuración de finanzas
                                await financeFormProvider.newFinance(
                                  mainCurrencyname,
                                  mainCurrencysymbol,
                                  secondCurrencyname,
                                  secondCurrencysymbol,
                                );
                                NotificationService.showSnackBa('Finance Profile Created');
                              } else {
                                await financeFormProvider.updateCurrency();
                                NotificationService.showSnackBa('Finance Profile Updated');
                              }
                              if (!context.mounted) return;
                              Provider.of<FinanceProvider>(context, listen: false).getFinance();
                              NavigationService.replaceTo('/dashboard/settings/finance');

                            } catch (e) {
                              if (mounted) NotificationService.showSnackBarError('Could not save the Finance Profile');
                            } finally {
                              if (mounted) Navigator.of(context).pop();
                            }
                          }
                        },

                        ),
                  ),
          ],
        ),
      ),
   ])));
  }
}
