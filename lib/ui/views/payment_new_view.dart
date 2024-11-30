import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/payment_form_provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class PaymentNewView extends StatefulWidget {
  const PaymentNewView({super.key});

  @override
  State<PaymentNewView> createState() => _PaymentNewViewState();
}

class _PaymentNewViewState extends State<PaymentNewView> {
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
      lastDate: DateTime(2101),
      );
      if(picked != null && picked != fechapago) {
        setState(() {
          fechapago = picked;
        });
      }
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
                  NavigationService.navigateTo('/dashboard/payments');
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'CREATE A PAYMENT',
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
                        color: const Color.fromRGBO(177, 255, 46, 100),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        )),
                      child: TextButton(
                        child: Text(
                          'SAVE',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () async {
                          if (paymentFormProvider.formKey.currentState!.validate()) {
                            try {
                              if (bancoemisor != null && bancoreceptor != null) {
                                await paymentFormProvider.newCreatePayment(
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
                              }
                              if (!context.mounted) return;
                              NotificationService.showSnackBa('Payment Register on System');
                              NavigationService.navigateTo('dashboard/payment/create');
                            } catch (e) {
                              NotificationService.showSnackBarError('Could not save the Product');
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
                if (selectedUsuarioZona != null) const SizedBox(height: 20),
                if (selectedUsuarioZona != null) _buildClientesDropdown(context),
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
        if (rutaProvider.rutas.isEmpty ||
            !rutaProvider.rutas.any(
                (ruta) => ruta.usuarioZona.uid == selectedUsuarioZona)) {
          selectedUsuarioZona = null;
        }

        return DropdownButtonFormField<String>(
          value: selectedUsuarioZona,
          decoration: _buildInputDecoration('REPRESENTATIVE'),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          style: GoogleFonts.plusJakartaSans(color: Colors.black),
          dropdownColor: Colors.white,
          items: rutaProvider.rutas.map((rutas) {
            return DropdownMenuItem<String>(
              value: rutas.usuarioZona.uid,
              child: Text(
                rutas.usuarioZona.nombre,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedUsuarioZona = value;
              cliente = null;
              type = null;
            });
            if (value != null) {
              rutaProvider.actualizarClientesRuta(value);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'PLEASE SELECT A REPRESENTATIVE';
            }
            return null;
          },
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
  return FormField<DateTime>(
    initialValue: fechapago,
    validator: (value) {
      if (value == null) {
        return 'PLEASE SELECT A DATE';
      }
      return null;
    },
    builder: (field) {
      return Row(
        children: [
          Text(
            'DATE PAYMENT:',
            style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.calendar_month_rounded),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () => _selectDate(context),
             child: Text(
              fechapago != null
                  ? DateFormat('dd/MM/yyyy').format(fechapago!)
                  : 'SELECT A DATE',
              style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          const SizedBox(width: 30),
            if(fechapago == null)
            Text('PLEASE SELECT A DATE', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)),
        ],
      );
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
        numeroref = value;
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
        bancoemisor = value;
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
        comentarios = value;
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


