import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/providers/customer_form_provider.dart';
import 'package:web_dashboard/providers/routes_providers.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class NewCustomerView extends StatefulWidget {
  const NewCustomerView({super.key});

  @override
  State<NewCustomerView> createState() => _NewCustomerViewState();
}

class _NewCustomerViewState extends State<NewCustomerView> {
  Customer? customer;

  @override
  Widget build(BuildContext context) {
    final customerFormProvider = Provider.of<CustomerFormProvider>(context);
    final customer = customerFormProvider.customer;

    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.getPaginatedUsers();

    return WhiteCardCustomer(
      title: 'Customer View',
      //child: Form(
      //  key: customerFormProvider.formKey,
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
                            // initialValue: customer.contacto,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'Manager',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Manager',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.person_rounded,
                                  color: Colors.black, size: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                              if (value.length > 21) {
                                return 'Max 20 characters';
                              }
                              return null;
                            }),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                  // initialValue:
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  decoration: const InputDecoration(
                                    hintText: 'Condition Sale',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: 'Credit (Days) & Cash',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: Icon(Icons.monetization_on,
                                        color: Colors.black, size: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2)),
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
                                  onChanged: (value) => customerFormProvider
                                      .copyCustomerWith(credito: value as int),
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
                        Consumer<RoutesProviders>(
                          builder: (context, zonasProvider, child) {
                            return DropdownButtonFormField<String>(
                              //  value: customer.zona.id,
                              decoration: InputDecoration(
                                hintText: 'Route Name',
                                labelText: 'Route Name',
                                labelStyle: GoogleFonts.plusJakartaSans(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                hintStyle: GoogleFonts.plusJakartaSans(
                                    color: Colors.black.withOpacity(0.7)),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                              ),
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black),
                              dropdownColor: Colors.grey[300],
                              items: zonasProvider.zonas.map((zona) {
                                return DropdownMenuItem<String>(
                                  value: zona.id,
                                  child: Text(zona.nombrezona,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please, select a Route';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                    const SizedBox(height: 10),
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
                            // initialValue: customer.contacto,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'Manager',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Manager',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.person_rounded,
                                  color: Colors.black, size: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                              if (value.length > 21) {
                                return 'Max 20 characters';
                              }
                              return null;
                            }),
                        const SizedBox(height: 10),
                        TextFormField(
                            // initialValue: customer.telefono,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'Phone',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Phone',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.phone_iphone_rounded,
                                  color: Colors.black, size: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                          // initialValue: customer.correo,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: 'email',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 16),
                            labelText: 'email',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.email_rounded,
                                color: Colors.black, size: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
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
                          // initialValue: customer.web,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: 'WebSite',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 16),
                            labelText: 'WebSite',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.web_asset,
                                color: Colors.black, size: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
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
                          onChanged: (value) =>
                              customerFormProvider.copyCustomerWith(web: value),
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                    const SizedBox(height: 30),
                    Container(
                      height: 50,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(177, 255, 46, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromRGBO(177, 255, 46, 1),
                            width: 2,
                          )),
                      child: TextButton(
                        child: Text(
                          'Save',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () async {
                          final saved =
                              await customerFormProvider.updateCustomer();
                          if (saved) {
                            if (!context.mounted) return;
                            Navigator.of(context)
                                .popAndPushNamed('/dashboard/customers');
                          } else {
                            NotificationService.showSnackBarError(
                                'Error to Update the Customer');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    WhiteCard(
                        child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Divider(
                          color: Color.fromARGB(255, 58, 60, 65),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          // initialValue: customer.idfiscal,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: 'Tax ID',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 16),
                            labelText: 'Tax ID',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
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
                            //  initialValue: customer.razons,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'Legal Name',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Legal Name',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                            //  initialValue: customer.nombre,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'Bussiness Name',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Bussiness Name',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                            //  initialValue: customer.sucursal,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'Sucursal',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Sucursal',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                            //   initialValue: customer.direccion,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'Address',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Address',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                            //    initialValue: customer.note,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Note',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Note',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.info_outline_rounded,
                                  color: Colors.black, size: 20),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
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
                              if (value.length > 80) return 'Max 80 characters';
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
        ],
      ),
    );
    // );
  }
}
