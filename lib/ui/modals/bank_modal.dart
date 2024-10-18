import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/bank.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

class BankModal extends StatefulWidget {
  final Bank? bank;

  const BankModal({super.key, this.bank});

  @override
  State<BankModal> createState() => _BankModalState();
}

class _BankModalState extends State<BankModal> {
  String? id;
  String nombre = '';
  String numero = '';
  String? tipo;
  String currencySymbol = '';
  String titular = '';
  String idtitular = '';
  String comentarios = '';

  late TextEditingController nombreController;
  late TextEditingController numeroController;
  late TextEditingController currencySymbolController;
  late TextEditingController titularController;
  late TextEditingController idtitularController;
  late TextEditingController comentariosController;

  @override
  void initState() {
    super.initState();
    nombreController =         TextEditingController(text: widget.bank?.nombre ?? '');
    numeroController =         TextEditingController(text: widget.bank?.numero ?? '');
    currencySymbolController = TextEditingController(text: widget.bank?.currencySymbol?? '');
    titularController =        TextEditingController(text: widget.bank?.titular ?? '');
    idtitularController =      TextEditingController(text: widget.bank?.idtitular ?? '');
    comentariosController =    TextEditingController(text: widget.bank?.comentarios ?? '');
     tipo = widget.bank?.tipo;
  }

  @override
  void dispose() {
    nombreController.dispose();
    numeroController.dispose();
    currencySymbolController.dispose();
    titularController.dispose();
    idtitularController.dispose();
    comentariosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bankFormProvider = Provider.of<BankFormProvider>(context, listen: false);
   


    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 750,
        width: 900, 
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
                Text('Add Bank Account',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white)
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: Colors.white70),
            Center(
              child: Column(
        children: [
          Table(
            columnWidths: const {
              0: FixedColumnWidth(200),
              1: FixedColumnWidth(20),
            },
            children: [
              TableRow(
                children: [
                  SizedBox(
                    height: 550,
                    child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 40),
                        Text('BANK',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, color: Colors.white)),
                        const SizedBox(height: 50),
                        Text('ACCOUNT NUMBER',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, color: Colors.white)),
                        const SizedBox(height: 50),
                        Text('TYPE',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,color: Colors.white)),
                        const SizedBox(height: 50),
                        Text('CURRENCY',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, color: Colors.white)),
                        const SizedBox(height: 50),
                        Text('BENEFICIARY',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, color: Colors.white)),
                        const SizedBox(height: 50),
                        Text('BENEFICIARY ID',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, color: Colors.white)),
                        const SizedBox(height: 50),
                        Text('COMMENTS',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 550,
                    child:Form(
                      key: bankFormProvider.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 60,
                            width: 320,
                            child: TextFormField(
                           controller: nombreController,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                          hintText: 'Bank Name',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(8.0),),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0), // Color del borde enfocado
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold // Ajusta el tamaño del texto del error
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                          onChanged: (value) {
                           widget.bank?.nombre = value.toUpperCase();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bank name cannot be empty.';
                            } else if (value.length > 25) {
                              return 'Name cannot exceed 25 characters.';
                            }
                            return null; // Validation successful
                          },
                            )
                          ),
                          const SizedBox(height: 10),
                            SizedBox(
                            height: 60,
                            width: 320,
                            child: TextFormField(
                           controller: numeroController,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                          hintText: 'Account Number',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(8.0),),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0), // Color del borde enfocado
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold // Ajusta el tamaño del texto del error
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                              onChanged: (value) {
                           widget.bank?.numero = value.toUpperCase();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'The number Account cannot be empty.';
                            } else if (value.length > 25) {
                              return 'The Number Account cannot exceed 25 characters.';
                            }
                            return null; // Validation successful
                          },
                            )
                              ),
                          const SizedBox(height: 10),
                          SizedBox(
                          height: 60,
                          width: 320,
                          child: Consumer<BankProvider>(
                            builder: (context, bankProvider, child) {
                              return DropdownButtonFormField<String>(
                                value: tipo, 
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white, // Color de la flecha
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(177, 255, 46, 100),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 12.0,
                                  ),
                                ),
                                dropdownColor: Colors.black, 
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                items: bankProvider.tipo.map((tipo) {
                                  return DropdownMenuItem<String>(
                                    value: tipo,
                                    child: Text(
                                      tipo,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                    onChanged: (value) {
                                  setState(() {
                                    tipo = value;
                                    widget.bank?.tipo = value.toString();
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Account Type is required';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            width: 320,
                            child: TextFormField(
                           controller: currencySymbolController,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromRGBO(177, 255, 46, 100),
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                            ),
                          decoration: InputDecoration(
                          hintText: 'Euro, USD, BTC',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(8.0),),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0), // Color del borde enfocado
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold // Ajusta el tamaño del texto del error
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                              onChanged: (value) {
                           widget.bank?.currencySymbol = value.toUpperCase();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'The Currency cannot be empty.';
                            } else if (value.length > 10) {
                              return 'Currency cannot exceed 10 characters.';
                            }
                            return null; // Validation successful
                          },
                          )
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            width: 320,
                            child: TextFormField(
                           controller: titularController,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14),
                          decoration: InputDecoration(
                          hintText: 'Beneficiary',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(8.0),),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0), // Color del borde enfocado
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold // Ajusta el tamaño del texto del error
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                               onChanged: (value) {
                           widget.bank?.titular = value.toUpperCase();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Beneficiary cannot be empty.';
                            } else if (value.length > 35) {
                              return 'Beneficiary Name cannot exceed 35 characters.';
                            }
                            return null; // Validation successful
                          },
                          )
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            width: 320,
                            child: TextFormField(
                           controller: idtitularController,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14),
                          decoration: InputDecoration(
                          hintText: 'Beneficiary ID',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(8.0),),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0), // Color del borde enfocado
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold // Ajusta el tamaño del texto del error
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                              onChanged: (value) {
                           widget.bank?.idtitular = value.toUpperCase();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Beneficiary ID cannot be empty.';
                            } else if (value.length > 20) {
                              return 'Beneficiary ID cannot exceed 20 characters.';
                            }
                            return null; // Validation successful
                          },
                          )
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            width: 320,
                            child: TextFormField(
                           controller: comentariosController,  
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14),
                          decoration: InputDecoration(
                          hintText: '',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(8.0),),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0), // Color del borde enfocado
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold // Ajusta el tamaño del texto del error
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                              onChanged: (value) {
                           widget.bank?.comentarios = value.toUpperCase();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Comments cannot be empty.';
                            } else if (value.length > 40) {
                              return 'Comments cannot exceed 40 characters.';
                            }
                            return null; // Validation successful
                          },
                          )
                          ),
                        ],
                      ),
                    ),
                   
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
            ),
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
                                if (bankFormProvider.validForm()) {
                                    try {
                                 if (id == null) {
                                   await bankFormProvider.newBank(

                                   nombre         = nombreController.text.toUpperCase(),
                                   numero         = numeroController.text.toUpperCase(),
                                   tipo           = tipo.toString(),
                                   currencySymbol = currencySymbolController.text.toUpperCase(),
                                   titular        = titularController.text.toUpperCase(),
                                   idtitular      = idtitularController.text.toUpperCase(),
                                   comentarios    = comentariosController.text.toUpperCase()
                                    );
                                   NotificationService.showSnackBa('Bank Account Created');
                                 }
                                  if (!context.mounted) return;
                                    Provider.of<BankProvider>(context,listen: false).getPaginatedBank();
                                    NavigationService.replaceTo('/dashboard/settings/bankaccount');
                               } catch (e) {
                                if (mounted) NotificationService.showSnackBarError('Could not create the Bank Account');
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
