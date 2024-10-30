import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class FinanceView extends StatefulWidget {
  final String id;

  const FinanceView({super.key, required this.id});

  @override
  State<FinanceView> createState() => _FinanceViewState();
}

class _FinanceViewState extends State<FinanceView> {
  Finance? finance;

  @override
  void initState() {
    super.initState();
    final financeProvider = Provider.of<FinanceProvider>(context, listen: false);
    final financeFormProvider = Provider.of<FinanceFormProvider>(context, listen: false);

    financeProvider.getFinanceById(widget.id).then((financeDB) {
      financeFormProvider.finance = financeDB;
      setState(() {
        finance = financeDB;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      NavigationService.navigateTo(
                          '/dashboard/settings/finance');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'Finance Settings',
                    style: GoogleFonts.plusJakartaSans(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            if (finance == null)
              WhiteCard(
                  child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(
                    color: Color.fromRGBO(255, 0, 200, 0.612),
                    strokeWidth: 4.0),
              )),
            if (finance != null) ...[
              const SizedBox(height: 20),
              const FinanceViewBody(),
            ]
          ],
        ));
  }
}

class FinanceViewBody extends StatefulWidget {
  const FinanceViewBody({super.key});

  @override
  State<FinanceViewBody> createState() => _FinanceViewBodyState();
}

class _FinanceViewBodyState extends State<FinanceViewBody> {
  String? mainCurrencyname;
  String? mainCurrencysymbol;
  String? secondCurrencyname;
  String? secondCurrencysymbol;

  @override
  Widget build(BuildContext context) {
    final financeFormProvider = Provider.of<FinanceFormProvider>(context);
    final finance = financeFormProvider.finance!;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isSmallScreen = constraints.maxWidth < 720;

        if (isSmallScreen) {
          // Si el ancho es menor a 720, apilamos los contenedores uno encima de otro con Column
          return Column(
            children: [
              _buildCurrencyContainer(context),
              _buildInfoContainer(finance),
            ],
          );
        } else {
          // Si el ancho es mayor o igual a 720, mostramos los contenedores lado a lado en una fila
          return Row(
            children: [
              Expanded(child: _buildCurrencyContainer(context)),
              Expanded(child: _buildInfoContainer(finance)),
            ],
          );
        }
      },
    );
  }

  // Construye el contenedor para la selección de divisas
  Widget _buildCurrencyContainer(BuildContext context) {
    final financeFormProvider = Provider.of<FinanceFormProvider>(context);

    return Container(
      width: 400,
      height: 400,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: financeFormProvider.formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'SELECT THE CURRENCY',
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
            Text(
              'MAIN CURRENCY:',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Color de fondo
                  foregroundColor: Colors.white, // Color del texto
                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 16), // Estilo de texto
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0), // Padding interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    side: const BorderSide(
                      color: Color.fromRGBO(0, 200, 83, 1),
                    ),
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
                child: Text(mainCurrencyname != null
                    ? '$mainCurrencyname ($mainCurrencysymbol)'
                    : 'Select Currency'),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'SECONDARY CURRENCY:',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Color de fondo
                  foregroundColor: Colors.white, // Color del texto
                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 16), // Estilo de texto
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0), // Padding interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    side: const BorderSide(
                      color: Color.fromRGBO(0, 200, 83, 1),
                    ),
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
                child: Text(secondCurrencyname != null
                    ? '$secondCurrencyname ($secondCurrencysymbol)'
                    : 'Select Currency'),
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
                ),
              ),
              child: TextButton(
                child: Text(
                  'SAVE',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                    onPressed: () async {
                      final financeFormProvider = Provider.of<FinanceFormProvider>(context, listen: false);
                      if (mainCurrencyname == null || mainCurrencysymbol == null) {
                        NotificationService.showSnackBarError('Please select a main currency');
                        return;
                      }
                      if (secondCurrencyname == null || secondCurrencysymbol == null) {
                        NotificationService.showSnackBarError('Please select a secondary currency');
                        return;
                      }
                      if (financeFormProvider.validForm()) {
                        financeFormProvider.setMainCurrency(
                          name: mainCurrencyname!,
                          symbol: mainCurrencysymbol!,
                        );
                        financeFormProvider.setSecondaryCurrency(
                          name: secondCurrencyname!,
                          symbol: secondCurrencysymbol!,
                        );
                        final saved = await financeFormProvider.updateCurrency();
                        if (saved) {
                          NotificationService.showSnackBa('Currency Updated');
                          if (!context.mounted) return;
                          Provider.of<FinanceProvider>(context, listen: false).getFinance();
                          NavigationService.replaceTo('/dashboard/settings/finance');
                        } else {
                          NotificationService.showSnackBarError('Error: The Currencies were not Updated');
                        }
                      } else {
                        NotificationService.showSnackBarError('Please fill all fields correctly');
                      }
                    }
        
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construye el contenedor para la información general
  Widget _buildInfoContainer(Finance finance) {
    return Container(
      width: 400,
      height: 400,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'GENERAL INFO',
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
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                'MAIN CURRENCY:',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(finance.mainCurrencyname),
              const SizedBox(width: 10),
              Text(
                finance.mainCurrencysymbol,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                'SECONDARY CURRENCY:',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(finance.secondCurrencyname),
              const SizedBox(width: 10),
              Text(
                finance.secondCurrencysymbol,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}