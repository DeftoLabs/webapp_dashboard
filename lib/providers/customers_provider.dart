import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/http/customers_response.dart';

class CustomersProvider extends ChangeNotifier {


List <Customer>customers = [];
bool isLoading = true;

CustomersProvider () {
  getPaginatedCustomers();
}


Future<void> getPaginatedCustomers()async { 
  final resp = await CafeApi.httpGet('/clientes');
  final customerResponse = CustomerResponse.fromMap(resp);
  customers = [ ... customerResponse.customers];
  isLoading = false;
  notifyListeners();
}
}