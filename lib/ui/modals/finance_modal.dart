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
  String tax1name = '';
  double tax1number = 0.0;
  String tax2name = '';
  double tax2number = 0.0;
  String tax3name = '';
  double tax3number = 0.0;
  String tax4name = '';
  double tax4number = 0.0;

  String taxa1name = '';
  double taxa1number = 0.0;
  String taxa2name = '';
  double taxa2number = 0.0;

  late TextEditingController tax1Controller;
  late TextEditingController tax2Controller;
  late TextEditingController tax3Controller;
  late TextEditingController tax1NameController;
  late TextEditingController tax2NameController;
  late TextEditingController tax3NameController;

  late TextEditingController taxa1Controller;
  late TextEditingController taxa2Controller;
  late TextEditingController taxa1NameController;
  late TextEditingController taxa2NameController;

  @override
  void initState() {
    super.initState();
    tax1Controller = TextEditingController(text: widget.finance?.tax1number.toString() ?? '0.0');
    tax2Controller = TextEditingController(text: widget.finance?.tax2number.toString() ?? '0.0');
    tax3Controller = TextEditingController(text: widget.finance?.tax3number.toString() ?? '0.0');

    taxa1Controller = TextEditingController(text: widget.finance?.taxa1number.toString() ?? '0.0');
    taxa2Controller = TextEditingController(text: widget.finance?.taxa2number.toString() ?? '0.0');

    tax1NameController = TextEditingController(text: widget.finance?.tax1name ?? '');
    tax2NameController = TextEditingController(text: widget.finance?.tax2name ?? '');
    tax3NameController = TextEditingController(text: widget.finance?.tax3name ?? '');

    taxa1NameController = TextEditingController(text: widget.finance?.taxa1name ?? '');
    taxa2NameController = TextEditingController(text: widget.finance?.taxa2name ?? '');
  }

  @override
  void dispose() {
    tax1Controller.dispose();
    tax2Controller.dispose();
    tax3Controller.dispose();
    tax1NameController.dispose();
    tax2NameController.dispose();
    tax3NameController.dispose();

    taxa1Controller.dispose();
    taxa2Controller.dispose();
    taxa1NameController.dispose();
    taxa2NameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final financeFormProvider = Provider.of<FinanceFormProvider>(context, listen: false);
   //final finance = financeFormProvider.finance!;


    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 850,
        width: 700, 
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
                Text('Add Finances Setup',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Column(
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
              Container(
                    width: 320,
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
                   Column(
                  children: [
                    Form(
                      key: financeFormProvider.formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text('SALES TAXES',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          const Divider(
                              indent: 40, endIndent: 40, color: Colors.black),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TAX %',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                     controller: tax1Controller,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TAX %';
                                        }
                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Only numbers';
                                        }
                                        if (parsedValue > 99) {
                                          return 'TAX cannot exceed 99%';
                                        }
                                        if (value.contains('.') &&
                                            value.split('.').last.length > 2) {
                                          return 'Max 2 decimal places';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                           final doubleValue = double.tryParse(value);
                                        if (doubleValue != null) {
                                          widget.finance?.tax1number = doubleValue;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('TYPE',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                    controller: tax1NameController,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TYPE';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                       widget.finance?.tax1name = value.toUpperCase();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TAX %',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                    controller: tax2Controller,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TAX %';
                                        }

                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Only numbers';
                                        }

                                        if (parsedValue > 99) {
                                          return 'TAX cannot exceed 99%';
                                        }

                                        if (value.contains('.') &&
                                            value.split('.').last.length > 2) {
                                          return 'Max 2 decimal places';
                                        }

                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }

                                        return null;
                                      },
                                      onChanged: (value) {
                                        final doubleValue = double.tryParse(value);
                                        if (doubleValue != null) {
                                          widget.finance?.tax2number = doubleValue;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('TYPE',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                     controller: tax2NameController,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TYPE';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                      widget.finance?.tax2name = value.toUpperCase();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TAX %',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                     controller: tax3Controller,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TAX %';
                                        }

                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Only numbers';
                                        }

                                        if (parsedValue > 99) {
                                          return 'TAX cannot exceed 99%';
                                        }

                                        if (value.contains('.') &&
                                            value.split('.').last.length > 2) {
                                          return 'Max 2 decimal places';
                                        }

                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }

                                        return null;
                                      },
                                      onChanged: (value) {
                                           final doubleValue = double.tryParse(value);
                                        if (doubleValue != null) {
                                          widget.finance?.tax3number = doubleValue;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('TYPE',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90, // Estableces el ancho
                                height: 80, // Estableces el alto
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      controller: tax3NameController,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TYPE';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                      widget.finance?.tax3name = value.toUpperCase();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
                  )
                ]
              ),
            ),
             Container(
                    width: 650,
                    height: 270,
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
                  Column(
                    children: [
                      Form(
                        key: financeFormProvider.form2Key,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text('ADDITIONAL TAXES', 
                            style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            const Divider(
                              indent: 40, endIndent: 40, color: Colors.black
                            ),
                               Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TAX %',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                     controller: taxa1Controller,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TAX %';
                                        }
                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Only numbers';
                                        }
                                        if (parsedValue > 99) {
                                          return 'TAX cannot exceed 99%';
                                        }
                                        if (value.contains('.') &&
                                            value.split('.').last.length > 2) {
                                          return 'Max 2 decimal places';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                           final doubleValue = double.tryParse(value);
                                        if (doubleValue != null) {
                                          widget.finance?.taxa1number = doubleValue;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('TYPE',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                    controller: taxa1NameController,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TYPE';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                       widget.finance?.taxa1name = value.toUpperCase();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                             Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TAX %',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                     controller: taxa2Controller,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TAX %';
                                        }
                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Only numbers';
                                        }
                                        if (parsedValue > 99) {
                                          return 'TAX cannot exceed 99%';
                                        }
                                        if (value.contains('.') &&
                                            value.split('.').last.length > 2) {
                                          return 'Max 2 decimal places';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                           final doubleValue = double.tryParse(value);
                                        if (doubleValue != null) {
                                          widget.finance?.tax2number = doubleValue;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('TYPE',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                    controller: taxa2NameController,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TYPE';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                       widget.finance?.taxa2name = value.toUpperCase();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ],
                        ))
                      
                    ],
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
                                if (financeFormProvider.validForm()) {
                                    try {
                                 if (id == null) {
                                   await financeFormProvider.newFinance(
                                    mainCurrencyname, 
                                    mainCurrencysymbol, 
                                    secondCurrencyname, 
                                    secondCurrencysymbol, 
                                    tax1name = tax1NameController.text, 
                                    tax1number = double.tryParse(tax1Controller.text) ?? 0.0,
                                    tax2name = tax2NameController.text, 
                                    tax2number = double.tryParse(tax2Controller.text) ?? 0.0, 
                                    tax3name = tax3NameController.text, 
                                    tax3number = double.tryParse(tax3Controller.text) ?? 0.0,
                                    taxa1name = taxa1NameController.text, 
                                    taxa1number = double.tryParse(taxa1Controller.text) ?? 0.0,
                                    taxa2name = taxa2NameController.text, 
                                    taxa2number = double.tryParse(taxa2Controller.text) ?? 0.0, 
                                    );
                                   NotificationService.showSnackBa('Finance Profile Created');
                                 }
                                  if (!context.mounted) return;
                                    Provider.of<FinanceProvider>(context,listen: false).getFinance();
                                    NavigationService.replaceTo('/dashboard/settings/finance');
                               } catch (e) {
                                if (mounted) NotificationService.showSnackBarError('Could not create the Finance Profile');
                                 if (mounted) Navigator.of(context).pop();
                               }
                                }
                              },
                        ),
                  ),
          ],
        ),
      ),
    );
  }
}
