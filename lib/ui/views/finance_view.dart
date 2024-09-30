
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_dashboard/services/navigation_service.dart';


class FinanceView extends StatefulWidget {
  const FinanceView({super.key});

  @override
  State<FinanceView> createState() => _FinanceViewState();
}

class _FinanceViewState extends State<FinanceView> {

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
                      NavigationService.navigateTo('/dashboard/settings');
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
          const SizedBox(height: 20),
          const FinanceViewBody(),
          const SizedBox(height: 20),
          const TaxesViewBody()
        ],
      )
    );
  }
}

class TaxesViewBody extends StatelessWidget {
  const TaxesViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: Column(
        children: [
            const SizedBox(height: 20),
                Text(
                  'TAXES',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: 200,
                         child: 
                         Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              const Text('TAX 01'),

    // TextFormField para TAX 01
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.2, // Ajusta el tamaño de forma responsive
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter TAX 01',
        ),
      ),
    ),

    // Espacio entre los campos
    const SizedBox(width: 20),

    // TAX 01 Name Label
    const Text('TAX 01 Name'),

    // TextFormField para TAX 01 Name
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.2, // Ajusta el tamaño de forma responsive
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter TAX 01 Name',
        ),
      ),
    ),
                              ],),


                            Row(children: [Text('TAX 02'), Text('TAX 02 Name')],),
                            Row(children: [Text('TAX 03'), Text('TAX 03 Name')],),
                            Row(children: [Text('TAX 04'), Text('TAX 04 Name')],),
                          ],
                         ),
                        ),
                      ),
                        Flexible(
                          flex: 2,
                          child: Container(
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
                                                child:  Text(
                                                  'SAVE',
                                                  style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontWeight: FontWeight.bold),
                                                ),  
                                               onPressed: () {
                          
                                               }),
                            ),
                        ),
                    ],
                  )
        ],
      ),
    );
  }
}

class FinanceViewBody extends StatefulWidget {
  const FinanceViewBody({super.key});

  @override
  State<FinanceViewBody> createState() => _FinanceViewBodyState();
}

class _FinanceViewBodyState extends State<FinanceViewBody> {
  Currency? mainCurrency;
  Currency? secondaryCurrency;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(500),
      },
      children: [
        TableRow(
          children: [
            Container(
              width: 250,
              height: 400,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)
                  )
                ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Select the Currency',
                    style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  const Divider(
                  indent: 40,
                  endIndent: 40,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  Text('Main Currency:', style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250, 
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,// Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        textStyle: GoogleFonts.plusJakartaSans(fontSize: 12), // Estilo de texto
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Padding interno
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bordes redondeados
                          side: const BorderSide(color:  Color.fromRGBO(0, 200, 83, 1),), // Color del borde (opcional)
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
                              mainCurrency = currency;
                            });
                          },
                        );
                      },
                      child: Text(mainCurrency != null
                          ? 'Main: ${mainCurrency!.name} (${mainCurrency!.symbol})'
                          : 'Select Main Currency'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Secondary Currency:', style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250, 
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,// Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        textStyle: GoogleFonts.plusJakartaSans(fontSize: 12), // Estilo de texto
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Padding interno
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bordes redondeados
                          side: const BorderSide(color:  Color.fromRGBO(0, 200, 83, 1),), // Color del borde (opcional)
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
                              secondaryCurrency = currency;
                            });
                          },
                        );
                      },
                      child: Text(secondaryCurrency != null
                          ? 'Secondary: ${secondaryCurrency!.name} (${secondaryCurrency!.symbol})'
                          : 'Select Secondary Currency'),
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
                      child:  Text(
                        'SAVE',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),  
                     onPressed: () {

                     }),
                            ),
                ],
              ),
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)
                  ),
                ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'General Info',
                    style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  const Divider(
                  indent: 40,
                  endIndent: 40,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                    mainCurrency != null && secondaryCurrency != null
                      ? Text(
                          'Main Currency: ${mainCurrency!.name} (${mainCurrency!.symbol})\n'
                          'Secondary Currency: ${secondaryCurrency!.name} (${secondaryCurrency!.symbol})',
                          style: GoogleFonts.plusJakartaSans(fontSize: 14),
                        ) : Container(),
                  ]
                  )
            )
          ],
        ),
      ],
    );
  }
}
