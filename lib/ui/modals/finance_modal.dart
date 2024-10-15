import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';

class FinanceModal extends StatefulWidget {
  final Finance? finance;

  const FinanceModal({super.key, this.finance});

  @override
  State<FinanceModal> createState() => _FinanceModalState();
}

class _FinanceModalState extends State<FinanceModal> {
  String? mainCurrencyname;
  String? mainCurrencysymbol;
  String? secondCurrencyname;
  String? secondCurrencysymbol;


  @override
  Widget build(BuildContext context) {
    final financeFormProvider = Provider.of<FinanceFormProvider>(context, listen: false);
  

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 600,
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
            const SizedBox(height: 40),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 350,
                    width: 350,
                    color: Colors.amber
                  ),
                  Container(
                    height: 350,
                    width: 350,
                    color: Colors.amber
                  ),
                  
                ]
              )
            ),
       
           
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              child: CustomOutlineButtom(
                onPressed: () async {
                
                },
                text: 'Save',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
