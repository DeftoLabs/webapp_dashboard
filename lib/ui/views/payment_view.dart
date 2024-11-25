
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/payment.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class PaymentView extends StatefulWidget {

  final String id;

  const PaymentView({super.key, required this.id});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  Payment? payment;

  @override
  void initState() {
    super.initState();
    final paymentsProvider = Provider.of<PaymentsProvider>(context, listen: false);

    paymentsProvider.getPaymentsByID(widget.id)
    .then((paymentDB)=> setState(() { payment = paymentDB;  })
    );
  }


  @override
  Widget build(BuildContext context) {

    if(payment == null) {
      return const SizedBox(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(  color: Color.fromRGBO(255, 0, 200, 0.612),
          strokeWidth: 4.0),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Payment View ${widget.id}', style: CustomLabels.h1,),

          const SizedBox(height: 10),

        ],
      )
    );
  }
}