import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/models/usuario.dart';
import 'package:web_dashboard/providers/payment_form_provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class PaymentNewSalesRepresentativeView extends StatefulWidget {
  const PaymentNewSalesRepresentativeView({super.key});

  @override
  State<PaymentNewSalesRepresentativeView> createState() => _PaymentNewSalesRepresentativeViewState();
}

class _PaymentNewSalesRepresentativeViewState extends State<PaymentNewSalesRepresentativeView> {
  String? cliente;
  String? selectedUsuarioZona;
  String? type;
  String? currencySymbol;
  double? monto = 0.0;
  String? bancoreceptor;
  String? numeroref;
  String? bancoemisor;
  String? comentarios;
  DateTime? fechapago;
  bool isSaveButtonVisible = false;

  final List<String> types = ['CASH', 'TRANSFER', 'CHECK'];

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      label: Center(
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
    );
  }

  Future<void> _selectDate (BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      );
      if(picked != null && picked != fechapago) {
        setState(() {
          fechapago = picked;
        });
      }
  }

  @override
  void initState() {
    final paymentFormProvider = Provider.of<PaymentFormProvider>(context, listen: false);
    paymentFormProvider.formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<PaymentFormProvider>(context, listen: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final paymentFormProvider = Provider.of<PaymentFormProvider>(context);

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty
        ? profileProvider.profiles[0]
        : null;

    if (profile == null) {
      return const Center(child: Text(''));
    }

    final image = (profile.img == null)
        ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35)
        : FadeInImage.assetNetwork(
            placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

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
                  NavigationService.navigateTo('/dashboard/paymentsbyrepresentative');
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'CREATE PAYMENT',
                      style: GoogleFonts.plusJakartaSans(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (isSaveButtonVisible)
                 Container(
                      height: 50,
                      width: 170,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(177, 255, 46, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        ),
                      ),
                      child: TextButton(
                        child: Text(
                          'SAVE',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        onPressed: () async {
                          if (paymentFormProvider.formKey.currentState!.validate()) {
                            try {
                              if (bancoemisor != null && bancoreceptor != null) {
                                // Captura el ID del nuevo Payment
                                final newPaymentId = await paymentFormProvider.newCreatePayment(
                                  bancoemisor: bancoemisor!,
                                  bancoreceptor: bancoreceptor!,
                                  numeroref: numeroref!,
                                  monto: monto!,
                                  currencySymbol: currencySymbol!,
                                  cliente: cliente!,
                                  type: type!,
                                  fechapago: fechapago!,
                                  comentarios: comentarios!,
                                );
                    
                                if (!context.mounted) return;
                                NotificationService.showSnackBa('PAYMENT REGISTERED');
                                Provider.of<PaymentsProvider>(context, listen: false).getPaginetedPayments();
                                showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            backgroundColor: Colors.white, // Fondo blanco
                            child: Container(
                              width: 300, // Ancho del Dialog
                              height: 280, // Alto del Dialog
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20),
                                  Center(
                                    child: Text(
                                      'DO YOU WANT TO ATTACH A FILE?',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold)
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                   Center(
                                     child: Text(
                                      'ALLOWED FORMATS: .jpg .jpeg .png',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 12)
                                                                       ),
                                   ),
                                  const SizedBox(height: 30),
                                  TextButton.icon(
                                    onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'jpeg', 'png'],
                                allowMultiple: false,
                              );
                              if (result != null) {
                                        if (!context.mounted) return;
                                        NotificationService.showBusyIndicator(context);
                                        final  uploadSuccess = await paymentFormProvider.uploadImage('/uploads/payment/$newPaymentId',result.files.first.bytes!) ?? false;
                                        if (!context.mounted) return;
                                         Navigator.of(context).pop();
                                        if(uploadSuccess != null ) {
                                        NavigationService.replaceTo('/dashboard/payments');
                                        }
                                      } else { 
                                        NotificationService.showSnackBarError('Failed to Upload Image');
                                      }
                                        },
                                        icon: const Icon(Icons.attach_file, color: Colors.white), // Ícono
                                        label: Text(
                                          'Attach File',
                                          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.white)
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.black,// Color de fondo del botón
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Espaciado interno
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20), // Borde redondeado
                                          ),
                                        ),
                                      ),
                                              const SizedBox(height: 30),
                                              TextButton(
                                                onPressed: () => NavigationService.replaceTo('/dashboard/paymentsbyrepresentative'),
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white, backgroundColor: Colors.black, // Color del texto
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Espaciado interno
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20), // Borde redondeado
                                                  ),
                                                ),
                                                child: const Text('NO'),
                                              ),
                                            ],
                                              ),
                                            ),
                                          ),
                                        );
                                         }
                                       } catch (e) {
                                         NotificationService.showSnackBarError(
                                           'Could not save the Payment: $e',
                                         );
                                       }
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 30),
              SizedBox(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: image,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Form(
            key: paymentFormProvider.formKey, 
            child: WhiteCard(
              child: Column(
              children: [
                _buildUsuarioZonaDropdown(context),
                const SizedBox(height: 20),
                _buildClientesDropdown(context),
                if (cliente != null) const SizedBox(height: 20),
                if (cliente != null) _buildTypeDropdown(),
                if (type != null) const SizedBox(height: 20),
                if (type != null) _buildCurrencyDropdown(context),
                if (currencySymbol != null) const SizedBox(height: 20),
                if (currencySymbol != null) _buildAmountInput(),
                if (monto != null) const SizedBox(height: 20),
                if (monto != null && currencySymbol != null)
                  Column(
                    children: [
                      _buildDateSelector(context),
                      const SizedBox(height: 20),
                      _buildBancoReceptorDropdown(context),
                      const SizedBox(height: 20),
                      _buildReferenciaInput(),
                      const SizedBox(height: 20),
                      _buildBancoEmisorInput(),
                      const SizedBox(height: 20),
                      _buildComentariosInput(),
                    ],
                  ),
              ],
        ),
          ),
      )],
      ),
    );
  }

Widget _buildUsuarioZonaDropdown(BuildContext context) {
  return Consumer<RutaProvider>(
    builder: (context, rutaProvider, child) {
      // Encontrar el representante activo automáticamente
    final activeUser = Provider.of<AuthProvider>(context, listen: false).user!;
    if (selectedUsuarioZona == null) {
      final Ruta? usuarioActivo = rutaProvider.rutas.cast<Ruta?>().firstWhere(
        (ruta) => ruta?.usuarioZona.uid == activeUser.uid,
        orElse: () => null, // Aquí null es permitido porque usuarioActivo es Ruta?
      );
      if (usuarioActivo != null) {
        selectedUsuarioZona = usuarioActivo.usuarioZona.uid;
          rutaProvider.actualizarClientesRuta(selectedUsuarioZona!);
      }
    }
      // Mostrar el nombre del usuarioZona activo (solo para mostrar)
Ruta activeZona = rutaProvider.rutas.firstWhere(
  (ruta) => ruta.usuarioZona.uid == selectedUsuarioZona,
  orElse: () => Ruta(
    usuarioZona: 
    Usuario(uid: '', nombre: '', rol: '', estado: true, google: true, correo: '', phone: '', zone: ''),
    estado: true,
    codigoRuta: '',
    nombreRuta: '',
    zona: '',
    diasemana: '',
    clientes: [],
  ), // Devolvemos un objeto Ruta vacío
);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Representative: ${activeZona.usuarioZona.nombre}',
            style: GoogleFonts.plusJakartaSans(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 10),
        ],
      );
    },
  );
}


Widget _buildClientesDropdown(BuildContext context) {
  return Consumer<RutaProvider>(
    builder: (context, rutaProvider, child) {
      if (rutaProvider.clientesRutaSeleccionada.isEmpty) {
        return const Text('');
      }

      return DropdownButtonFormField<String>(
        value: cliente,
        decoration: _buildInputDecoration('CUSTOMER'),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        style: GoogleFonts.plusJakartaSans(color: Colors.black),
        dropdownColor: Colors.white,
        items: rutaProvider.clientesRutaSeleccionada.map((cliente) {
          return DropdownMenuItem<String>(
            value: cliente.id,
            child: Text(
              cliente.nombre,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            cliente = value;
            type = null;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'PLEASE SELECT A CUSTOMER';
          }
          return null;
        },
      );
    },
  );
}

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: type,
      decoration: _buildInputDecoration('PAYMENT TYPE'),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      style: GoogleFonts.plusJakartaSans(color: Colors.black),
      dropdownColor: Colors.white,
      items: types.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(
            type,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          type = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'PLEASE SELECT A PAYMENT TYPE';
        }
        return null;
      },
    );
  }

Widget _buildCurrencyDropdown(BuildContext context) {
  return Consumer<FinanceProvider>(
    builder: (context, financeProvider, child) {
      if (financeProvider.finances.isEmpty) {
        return const Text('No currencies available');
      }
      // Crear una lista con las dos monedas de cada objeto Finance
      final currencies = <Map<String, String>>[];
      for (var finance in financeProvider.finances) {
        currencies.add({
          'name': finance.mainCurrencyname,
          'symbol': finance.mainCurrencysymbol,
        });
        currencies.add({
          'name': finance.secondCurrencyname,
          'symbol': finance.secondCurrencysymbol,
        });
      }

      return DropdownButtonFormField<String>(
        value: currencySymbol,
        decoration: _buildInputDecoration('CURRENCY'),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        style: GoogleFonts.plusJakartaSans(color: Colors.black),
        dropdownColor: Colors.white,
        items: currencies.map((currency) {
          return DropdownMenuItem<String>(
            value: currency['symbol'],
            child: Text(
              currency['name']!,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            currencySymbol = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'PLEASE SELECT A CURRENCY';
          }
          return null;
        },
      );
    },
  );
}

Widget _buildAmountInput() {
  return TextFormField(
    decoration: _buildInputDecoration('AMOUNT').copyWith(
      prefixText: currencySymbol != null ? '$currencySymbol ' : null,
    ),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
    ],
    style: GoogleFonts.plusJakartaSans(color: Colors.black),
    onChanged: (value) {
      setState(() {
        monto = double.tryParse(value);
      });
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'PLEASE ENTER AN AMOUNT';
      }
      if (double.tryParse(value) == null) {
        return 'PLEASE ENTER A VALID NUMBER';
      }
      if (value.length >12) {
        return 'COMMENTS MUST NOT EXCEED 12 CHARACTERS';
      }
      return null;
    },
  );
}

Widget _buildBancoReceptorDropdown(BuildContext context) {
  return Consumer<BankProvider>(
    builder: (context, bankProvider, child) {
      if (bankProvider.banks.isEmpty) {
        return const Text('No banks available');
      }

      return DropdownButtonFormField<String>(
        value: bancoreceptor,
        decoration: _buildInputDecoration('BANK ACCOUNT'),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        style: GoogleFonts.plusJakartaSans(color: Colors.black),
        dropdownColor: Colors.white,
        items: bankProvider.banks.map((bank) {
          return DropdownMenuItem<String>(
            value: bank.id,
            child: Text(
              bank.nombre,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            bancoreceptor = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'PLEASE SELECT A BANK RECEIVER';
          }
          return null;
        },
      );
    },
  );
}

Widget _buildDateSelector(BuildContext context) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: 'DATE PAYMENT',
      labelStyle: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold),
      prefixIcon: const Icon(Icons.calendar_month_rounded),
    ),
    readOnly: true, // Hace que el campo no sea editable manualmente
    controller: TextEditingController(
      text: fechapago != null ? DateFormat('dd/MM/yyyy').format(fechapago!) : '',
    ),
    style: GoogleFonts.plusJakartaSans(color: Colors.black),
    onTap: () async {
      await _selectDate(context); // Abre el selector de fecha
    },
    validator: (value) {
      if (fechapago == null) {
        return 'PLEASE SELECT A DATE';
      }
      return null;
    },
  );
}


Widget _buildReferenciaInput() {
  return TextFormField(
    decoration: _buildInputDecoration('# REFERENCE'),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    style: GoogleFonts.plusJakartaSans(color: Colors.black),
    onChanged: (value) {
      setState(() {
        numeroref = value.toUpperCase();
      });
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'PLEASE ENTER A REFERENCE';
      }
      if (value.length > 30) {
        return 'COMMENTS MUST NOT EXCEED 30 CHARACTERS';
      }
      return null;
    },
  );
}

Widget _buildBancoEmisorInput() {
  return TextFormField(
    decoration: _buildInputDecoration('BANK'),
    style: GoogleFonts.plusJakartaSans(color: Colors.black),
    onChanged: (value) {
      setState(() {
        bancoemisor = value.toUpperCase();
      });
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'PLEASE ENTER A BANK NAME';
      }
      if (value.length > 30) {
        return 'COMMENTS MUST NOT EXCEED 30 CHARACTERS';
      }
      return null;
    },
  );
}
Widget _buildComentariosInput() {
  return TextFormField(
    decoration: _buildInputDecoration('DETAILS AND COMMENTS'),
    style: GoogleFonts.plusJakartaSans(color: Colors.black),
    onChanged: (value) {
      setState(() {
        comentarios = value.toUpperCase();
        isSaveButtonVisible = value.isNotEmpty;
      });
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'PLEASE ENTER A COMMENTS OR DETAILS';
      }
      if (value.length > 50) {
        return 'COMMENTS MUST NOT EXCEED 50 CHARACTERS';
      }
      return null;
    },
  );
}

}


