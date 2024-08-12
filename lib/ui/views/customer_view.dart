
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/providers/customers_provider.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

import 'package:web_dashboard/ui/labels/custom_labels.dart';


class CustomerView extends StatefulWidget {

  final String id;

  const CustomerView({
    super.key, 
    required this.id
    });

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {

  Customer? customer;

  @override
  void initState() {
    super.initState();
    final customerProvider = Provider.of<CustomersProvider>(context, listen: false);

    customerProvider.getCustomerById(widget.id)
    .then((customerDB) => setState(() {
      customer = customerDB;}));
  }

  @override
  Widget build(BuildContext context) {

    if(customer == null){
        return const Center(
        child: CircularProgressIndicator(
        color: Color.fromRGBO(255, 0, 200, 0.612),
        strokeWidth: 4.0),
        );
    }

    Text('${customer?.nombre}');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Customer View', style: CustomLabels.h1,),

          const SizedBox(height: 10),

        WhiteCard(child: Text(widget.id))
        ],
      )
    );
  }
}