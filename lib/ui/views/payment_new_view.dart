import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
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
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          WhiteCard(
            child: Column(
              children: [
                _buildUsuarioZonaDropdown(context),
                const SizedBox(height: 20),
                _buildClientesDropdown(context),
                if (cliente != null) ...[
                  const SizedBox(height: 20),
                  _buildTypeDropdown(),
                  if (type != null) const SizedBox(height: 20),
                  if (type != null) _buildCurrencyDropdown(context),
                  if (currencySymbol != null) const SizedBox(height: 20),
                  if (currencySymbol != null) _buildAmountInput(),
                
                ],
              ],
            ),
          ),
        ],
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
              print('Cliente ID: ${value}');
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
          print('TYPE: ${value}');
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
            print('Currency Symbol: $value');
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
      decoration: InputDecoration(
        labelText: 'AMOUNT',
        hintText: 'Enter the amount',
        prefixText: currencySymbol != null ? '$currencySymbol ' : null,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.plusJakartaSans(color: Colors.black),
      onChanged: (value) {
        setState(() {
          monto = double.tryParse(value);
          print('monto: ${value}');
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'PLEASE ENTER AN AMOUNT';
        }
        if (double.tryParse(value) == null) {
          return 'PLEASE ENTER A VALID NUMBER';
        }
        return null;
      },
    );
  }
}

