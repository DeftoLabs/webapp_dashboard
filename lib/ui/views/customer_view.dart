import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/providers/customer_form_provider.dart';
import 'package:web_dashboard/providers/customers_provider.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class CustomerView extends StatefulWidget {
  final String id;

  const CustomerView({super.key, required this.id});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  Customer? customer;

  @override
  void initState() {
    super.initState();

    final customerProvider =
        Provider.of<CustomersProvider>(context, listen: false);
    final customerFormProvider =
        Provider.of<CustomerFormProvider>(context, listen: false);

    customerProvider.getCustomerById(widget.id).then((customerDB) {
      if (customerDB != null) {
        customerFormProvider.customer = customerDB;
        customerFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
          customer = customerDB;
        });
      } else {
        NavigationService.navigateTo('/dashboard/customers');
      }
    });
  }

  @override
  void dispose() {
    customer = null;
    Provider.of<CustomerFormProvider>(context, listen: false).customer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customerFormProvider = Provider.of<CustomerFormProvider>(context);
    final customer = customerFormProvider.customer;

    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.getPaginatedUsers();

    if (customer == null) {
      return const Center(
        child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 4.0),
      );
    }

    return WhiteCardCustomer(
      title: 'Customer View',
      child: Form(
        key: customerFormProvider.formKey,
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FixedColumnWidth(350),
              },
              children: [
                TableRow(children: [
                  Column(
                    children: [
                      WhiteCard(
                          child: Column(
                        children: [
                          Text('Credit & Sales Data',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Color.fromARGB(255, 58, 60, 65),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: customer.codigo,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Customer Code',
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Code',
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                prefixIcon: customer.codigo.isEmpty
                                    ? const Icon(Icons.code,
                                        color: Colors.black, size: 20)
                                    : null,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                              onChanged: (value) => customerFormProvider
                                  .copyCustomerWith(codigo: value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Code is Required';
                                }
                                if (value.length < 2) {
                                  return 'The Code is required minimum 3 characters';
                                }
                                if (value.length > 25) {
                                  return 'Max 25 characters';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                    initialValue: customer.credito.toString(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    decoration: const InputDecoration(
                                      hintText: 'Condition Sale',
                                      hintStyle: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      labelText: 'Credit (Days) & Cash',
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      prefixIcon: Icon(Icons.monetization_on,
                                          color: Colors.black, size: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color.fromARGB(255, 58, 60, 65),
                                      )),
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color.fromARGB(255, 58, 60, 65),
                                      )),
                                    ),
                                    onChanged: (value) =>
                                        customerFormProvider.copyCustomerWith(
                                            credito: value as int),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Credit is Required';
                                      }
                                      if (value.length > 4) {
                                        return 'Max 3 characters';
                                      }
                                      return null;
                                    }),
                              ),
                              const SizedBox(width: 10),
                              Text('days',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 120)
                            ],
                          ),
                          const SizedBox(height: 10),
                           TextFormField(
                              initialValue: customer.zona.nombrezona,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: const InputDecoration(
                                hintText: 'Zone',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Zone',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.person_rounded,
                                    color: Colors.black, size: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                             // onChanged: (value) {
                             // 
                             // },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Zone is Required';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                        ],
                      )),
                      const SizedBox(height: 54),
                      WhiteCard(
                          child: Column(
                        children: [
                          Text('Contact Info',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Color.fromARGB(255, 58, 60, 65),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: customer.contacto,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: const InputDecoration(
                                hintText: 'Manager',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Manager',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.person_rounded,
                                    color: Colors.black, size: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                              onChanged: (value) => customerFormProvider
                                  .copyCustomerWith(contacto: value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Manager is Required';
                                }
                                if (value.length > 16) {
                                  return 'Max 15 characters';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: customer.telefono,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: const InputDecoration(
                                hintText: 'Phone',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Phone',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.phone_iphone_rounded,
                                    color: Colors.black, size: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                              onChanged: (value) => customerFormProvider
                                  .copyCustomerWith(telefono: value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone is Required';
                                }
                                if (value.length > 15) {
                                  return 'Max 14 characters';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: customer.correo,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'email',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              labelText: 'email',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.email_rounded,
                                  color: Colors.black, size: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 58, 60, 65),
                              )),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 58, 60, 65),
                              )),
                            ),
                            onChanged: (value) => customerFormProvider
                                .copyCustomerWith(correo: value),
                            validator: (value) {
                              if (!EmailValidator.validate(value ?? '')) {
                                return 'Email not Valid';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: customer.web,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'WebSite',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              labelText: 'WebSite',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.web_asset,
                                  color: Colors.black, size: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 58, 60, 65),
                              )),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 58, 60, 65),
                              )),
                            ),
                            onChanged: (value) => customerFormProvider
                                .copyCustomerWith(web: value),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              customer.web = (value == null || value.isEmpty)
                                  ? 'N/A'
                                  : value;
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ))
                    ],
                  ),
                  Column(
                    children: [
                      WhiteCard(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Text('CODE: ${customer.codigo}',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Color.fromARGB(255, 58, 60, 65),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: customer.idfiscal,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Tax ID',
                              hintStyle: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              labelText: 'Tax ID',
                              labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: customer.idfiscal.isEmpty
                                  ? const Icon(Icons.info_sharp,
                                      color: Colors.black, size: 20)
                                  : null,
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 58, 60, 65),
                              )),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 58, 60, 65),
                              )),
                            ),
                            onChanged: (value) => customerFormProvider
                                .copyCustomerWith(idfiscal: value),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'TAX is Required';
                              }
                              if (value.length < 2) {
                                return 'The TAX required minimum 3 characters';
                              }
                              if (value.length > 16) return 'Max 15 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: customer.razons,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Legal Name',
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Legal Name',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: customer.razons.isEmpty
                                    ? const Icon(Icons.business_outlined,
                                        color: Colors.black, size: 20)
                                    : null,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                              onChanged: (value) => customerFormProvider
                                  .copyCustomerWith(razons: value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Legal is Required';
                                }
                                if (value.length < 2) {
                                  return 'The Legal required minimum 3 characters';
                                }
                                if (value.length > 25) {
                                  return 'Mac 25 characters';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: customer.nombre,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Bussiness Name',
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Bussiness Name',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: customer.nombre.isEmpty
                                    ? const Icon(Icons.burst_mode_sharp,
                                        color: Colors.black, size: 20)
                                    : null,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                              onChanged: (value) => customerFormProvider
                                  .copyCustomerWith(nombre: value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Bussiness is Required';
                                }
                                if (value.length < 2) {
                                  return 'The Bussiness required minimum 3 characters';
                                }
                                if (value.length > 25) {
                                  return 'Max 25 characters';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: customer.sucursal,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Sucursal',
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Sucursal',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: customer.sucursal.isEmpty
                                    ? const Icon(Icons.point_of_sale_outlined,
                                        color: Colors.black, size: 20)
                                    : null,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                              onChanged: (value) => customerFormProvider
                                  .copyCustomerWith(sucursal: value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sucursal is Required';
                                }
                                if (value.length < 2) {
                                  return 'The Sucursal required minimum 3 characters';
                                }
                                if (value.length > 15) {
                                  return 'Max 15 characters';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: customer.direccion,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Address',
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Address',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: customer.direccion.isEmpty
                                    ? const Icon(Icons.location_city_rounded,
                                        color: Colors.black, size: 20)
                                    : null,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                              onChanged: (value) => customerFormProvider
                                  .copyCustomerWith(direccion: value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address is Required';
                                }
                                if (value.length < 2) {
                                  return 'The Address required minimum 3 characters';
                                }
                                // if (value.length > 35) return 'Max 35 characters';
                                return null;
                              }),
                          const SizedBox(height: 30),
                        ],
                      )),
                      WhiteCard(
                          child: Column(
                        children: [
                          Text('Aditonal Information',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Color.fromARGB(255, 58, 60, 65),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: customer.note,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: 'Note',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                labelText: 'Note',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.info_outline_rounded,
                                    color: Colors.black, size: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 58, 60, 65),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 60, 65),
                                )),
                              ),
                              onChanged: (value) => customerFormProvider
                                  .copyCustomerWith(note: value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Note is Required';
                                }
                                if (value.length < 2) {
                                  return 'The note required minimum 3 characters';
                                }
                                // if (value.length >= 41) return 'Max 40 characters';
                                return null;
                              }),
                          const SizedBox(height: 10),
                        ],
                      ))
                    ],
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(177, 255, 46, 1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 1,
                  )),
              child: TextButton(
                child: Text(
                  'Save',
                  style: GoogleFonts.plusJakartaSans(
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                onPressed: () async {
                  final saved = await customerFormProvider.updateCustomer();
                  if (saved) {
                    if (!context.mounted) return;
                    NotificationService.showSnackBa('Customer Updated');
                    Provider.of<CustomersProvider>(context, listen: false)
                        .refreshCustomer(customer);
                  } else {
                    NotificationService.showSnackBarError(
                        'Error to Update the Customer');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}