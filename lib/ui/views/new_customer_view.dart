import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/zona.dart';
import 'package:web_dashboard/providers/newcustomer_provider.dart';
import 'package:web_dashboard/providers/zones_providers.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class NewCustomerView extends StatefulWidget {
  final Customer? customer;
  final formKey = GlobalKey<FormState>();

  NewCustomerView({super.key, this.customer});

  @override
  State<NewCustomerView> createState() => _NewCustomerViewState();
}

class _NewCustomerViewState extends State<NewCustomerView> {
  @override
  Widget build(BuildContext context) {
    final newCustomerRegisterProvider =
        Provider.of<NewCustomerProvider>(context, listen: false);

    return WhiteCardCustomer(
        title: 'Customer View',
        child: Form(
          key: newCustomerRegisterProvider.formKey,
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
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      decoration: const InputDecoration(
                                        hintText: 'Condition Sale',
                                        hintStyle: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        labelText: 'Credit (Days) & Cash',
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        prefixIcon: Icon(Icons.monetization_on,
                                            color: Colors.black, size: 20),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 58, 60, 65),
                                        )),
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 58, 60, 65),
                                        )),
                                      ),
                                      onChanged: (value) =>
                                          newCustomerRegisterProvider.credito =
                                              int.tryParse(value) ?? 0,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Credit is Required';
                                        }
                                        if (!RegExp(r'^[0-9]+$')
                                            .hasMatch(value)) {
                                          return 'Only numbers are allowed';
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
                                const SizedBox(width: 30)
                              ],
                            ),
                            const SizedBox(height: 10),
                            Consumer<ZonesProviders>(
                              builder: (context, zonasProvider, child) {
                                return DropdownButtonFormField<Zona>(
                                  decoration: InputDecoration(
                                    hintText: 'Zone Name',
                                    labelText: 'Zone Name',
                                    labelStyle: GoogleFonts.plusJakartaSans(
                                        color: Colors.black, fontSize: 16),
                                    hintStyle: GoogleFonts.plusJakartaSans(
                                        color: Colors.black.withOpacity(0.7)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                  ),
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.black),
                                  dropdownColor: Colors.grey[300],
                                  items: zonasProvider.zonas.map((zona) {
                                    return DropdownMenuItem<Zona>(
                                      value: zona,
                                      child: Text(zona.nombrezona,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    );
                                  }).toList(),
                                  value: newCustomerRegisterProvider.zone,
                                  onChanged: (Zona? selectedZona) {
                                    if (selectedZona != null) {
                                      newCustomerRegisterProvider
                                          .updateZone(selectedZona);
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null) {
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
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                decoration: const InputDecoration(
                                  hintText: 'Manager',
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  labelText: 'Manager',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  prefixIcon: Icon(Icons.person_rounded,
                                      color: Colors.black, size: 20),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
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
                                onChanged: (value) {
                                  final uppercaseValue = value.toUpperCase();
                                  newCustomerRegisterProvider.contacto =
                                      uppercaseValue;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Manager is Required';
                                  }
                                  if (value.length > 31) {
                                    return 'Max 30 characters';
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 10),
                            TextFormField(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                decoration: const InputDecoration(
                                  hintText: 'Phone',
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  prefixIcon: Icon(Icons.phone_iphone_rounded,
                                      color: Colors.black, size: 20),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
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
                                 onChanged: (value) {
                                    newCustomerRegisterProvider.telefono = value;
                                        },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone is Required';
                                  }
                                  if (!RegExp(r'^\+?[0-9]+$').hasMatch(value)) {
                                    return 'Only numbers and a leading + are allowed (No space allowed)';
                                  }
                                  if (value.length > 21) {
                                    return 'Max 20 characters';
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'email',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'email',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                prefixIcon: Icon(Icons.email_rounded,
                                    color: Colors.black, size: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
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
                              onChanged: (value) {
                                final lowercaseValue = value.toLowerCase();
                                newCustomerRegisterProvider.correo =
                                    lowercaseValue;
                              },
                              validator: (value) {
                                if (!EmailValidator.validate(value ?? '')) {
                                  return 'Email not Valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'WebSite',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'WebSite',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                prefixIcon: Icon(Icons.web_asset,
                                    color: Colors.black, size: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
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
                              onChanged: (value) {
                                final lowercaseValue = value.toLowerCase();
                                newCustomerRegisterProvider.web =
                                    lowercaseValue;
                              },
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
                            onPressed: () {
                              final validForm =
                                  newCustomerRegisterProvider.validateForm();
                              if (!validForm) return;

                              newCustomerRegisterProvider.newCustomerRegister(
                                  newCustomerRegisterProvider.codigo,
                                  newCustomerRegisterProvider.idfiscal,
                                  newCustomerRegisterProvider.nombre,
                                  newCustomerRegisterProvider.razons,
                                  newCustomerRegisterProvider.sucursal,
                                  newCustomerRegisterProvider.direccion,
                                  newCustomerRegisterProvider.correo,
                                  newCustomerRegisterProvider.telefono,
                                  newCustomerRegisterProvider.web,
                                  newCustomerRegisterProvider.contacto,
                                  newCustomerRegisterProvider.credito,
                                  newCustomerRegisterProvider.note,
                                  newCustomerRegisterProvider.name,
                                  newCustomerRegisterProvider.zone);
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
                            Row(
                              children: [
                                Text('Customer Info',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const Spacer(),
                                ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.map,
                                      color: Colors.black,
                                    ),
                                    label: const Text('Add Location'),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(16),
                                      backgroundColor: const Color.fromRGBO(177, 255, 46, 1),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              color: Color.fromARGB(255, 58, 60, 65),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'Customer Internal Code',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'Internal Code',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                              ),
                              onChanged: (value) {
                                final uppercaseValue = value.toUpperCase();
                                newCustomerRegisterProvider.codigo =
                                    uppercaseValue;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Internal Code is Required';
                                }
                                if (value.length > 20) {
                                  return 'Max 20 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'Tax ID',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'Tax ID',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                              ),
                              onChanged: (value) {
                                final uppercaseValue = value.toUpperCase();
                                newCustomerRegisterProvider.idfiscal =
                                    uppercaseValue;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'TAX ID is Required';
                                }
                                if (value.length > 20) {
                                  return 'Max 20 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'Legal Name',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'Legal Name',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                              ),
                              onChanged: (value) {
                                final uppercaseValue = value.toUpperCase();
                                newCustomerRegisterProvider.razons =
                                    uppercaseValue;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Legal Name is Required';
                                }
                                if (value.length < 2) {
                                  return 'The Legal Name requires a minimum of 2 characters';
                                }
                                if (value.length > 40) {
                                  return 'Max 40 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'Business Name',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'Business Name',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                              ),
                              onChanged: (value) {
                                final uppercaseValue = value.toUpperCase();
                                newCustomerRegisterProvider.nombre =
                                    uppercaseValue;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Business Name is Required';
                                }
                                if (value.length < 2) {
                                  return 'The Business Name requires a minimum of 2 characters';
                                }
                                if (value.length > 40) {
                                  return 'Max 40 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'Branch',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'Branch',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                              ),
                              onChanged: (value) {
                                final uppercaseValue = value.toUpperCase();
                                newCustomerRegisterProvider.sucursal =
                                    uppercaseValue;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                if (value.length < 2) {
                                  return 'The Branch requires a minimum of 2 characters';
                                }
                                if (value.length > 17) {
                                  return 'Max 17 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              maxLines: 2,
                              decoration: const InputDecoration(
                                hintText: 'Address',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                              ),
                              onChanged: (value) {
                                final uppercaseValue = value.toUpperCase();
                                newCustomerRegisterProvider.direccion =
                                    uppercaseValue;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address is Required';
                                }
                                if (value.length < 2) {
                                  return 'The Address requires a minimum of 2 characters';
                                }
                                if (value.length > 100) {
                                  return 'Max 100 characters';
                                }
                                return null;
                              },
                            ),
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
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  hintText: 'Note',
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  labelText: 'Note',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  prefixIcon: Icon(Icons.info_outline_rounded,
                                      color: Colors.black, size: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 58, 60, 65),
                                  )),
                                ),
                                onChanged: (value) {
                                  final uppercaseValue = value.toUpperCase();
                                  newCustomerRegisterProvider.note =
                                      uppercaseValue;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Note is Required';
                                  }
                                  if (value.length < 2) {
                                    return 'The note required minimum 3 characters';
                                  }
                                  if (value.length > 180) {
                                    return 'Max 179 characters';
                                  }
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
        ));
  }
}
