import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/http/customers_response.dart';

class CustomersProvider extends ChangeNotifier {


List <Customer>customers = [];
bool isLoading = true;

bool ascending = true;
int? sortColumnIndex;


Future<void> getPaginatedCustomers()async { 
  final resp = await CafeApi.httpGet('/clientes');
  final customerResponse = CustomerResponse.fromMap(resp);
  customers = [ ... customerResponse.customers];
  isLoading = false;
  notifyListeners();
}


 Future<Customer?> getCustomerById (String id) async { 
  try {
      final resp = await CafeApi.httpGet('/clientes/$id');
  final customer = Customer.fromMap(resp);
  return customer;
  } catch (e) {
    return null;
  }
}

void sort<T>( Comparable<T> Function( Customer customer) getField) {
  
  customers.sort((a,b) {

    final aValue = getField( a );
    final bValue = getField( b );

    return ascending 
    ? Comparable.compare(aValue, bValue) 
    : Comparable.compare(bValue, aValue);
    
    

  });

  ascending = !ascending;

  notifyListeners();
}

void refreshCustomer (Customer newCustomer) {

  customers = customers.map(
    (customer){
      if (customer.id == newCustomer.id) {
        customer = newCustomer;
      }
      return customer;
    }
  ).toList();

  notifyListeners();
}

}