import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
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

    final localization = AppLocalizations.of(context)!;

    return WhiteCardCustomer(
        title: localization.customer,
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
                            Text(localization.creditsales,
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
                                      decoration: InputDecoration(
                                        hintText: localization.conditionsales,
                                        hintStyle: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        labelText: localization.creditinfo,
                                        labelStyle: const TextStyle(
                                            color: Colors.black, fontSize: 12),
                                        prefixIcon: const Icon(Icons.monetization_on,
                                            color: Colors.black, size: 20),
                                        enabledBorder:  const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 1)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 58, 60, 65),
                                        )),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        focusedErrorBorder: const OutlineInputBorder(
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
                                          return localization.requiredcredit;
                                        }
                                        if (!RegExp(r'^[0-9]+$')
                                            .hasMatch(value)) {
                                          return localization.onlynumbers;
                                        }
                                        if (value.length > 4) {
                                          return localization.maxlegth3;
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(width: 10),
                                Text(localization.days,
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
                                    hintText: localization.zonename,
                                    labelText: localization.zonename,
                                    labelStyle: GoogleFonts.plusJakartaSans(
                                        color: Colors.black, fontSize: 16),
                                    hintStyle: GoogleFonts.plusJakartaSans(
                                        color: Colors.black.withValues(alpha: 0.7)),
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
                                      return localization.selectzone;
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
                            Text(localization.contacinfo,
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
                                decoration: InputDecoration(
                                  hintText: localization.manager,
                                  hintStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  labelText: localization.manager,
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  prefixIcon: const Icon(Icons.person_rounded,
                                      color: Colors.black, size: 20),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 58, 60, 65),
                                  )),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder:const OutlineInputBorder(
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
                                    return localization.requiredmanager;
                                  }
                                  if (value.length > 31) {
                                    return localization.maxlegth30;
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 10),
                            TextFormField(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: localization.phone,
                                  hintStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  labelText: localization.phone,
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  prefixIcon: const Icon(Icons.phone_iphone_rounded,
                                      color: Colors.black, size: 20),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 58, 60, 65),
                                  )),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 58, 60, 65),
                                  )),
                                ),
                                 onChanged: (value) {
                                    newCustomerRegisterProvider.telefono = value;
                                        },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return localization.requiredphone;
                                  }
                                  if (!RegExp(r'^\+?[0-9]+$').hasMatch(value)) {
                                    return localization.phonemessage01;
                                  }
                                  if (value.length > 21) {
                                    return localization.maxlegth20;
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
                                  return localization.emailnotvalid;
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
                          width: 150,
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
                              localization.save,
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
                                Text(localization.customerinfo,
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
                                    label: Text(localization.addlocation),
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
                              decoration: InputDecoration(
                                hintText: localization.code,
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: localization.code,
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
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
                                  return localization.requiredcode;
                                }
                                if (value.length > 20) {
                                  return localization.maxlegth20;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: localization.taxid,
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText:  localization.taxid,
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
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
                                  return localization.requiredtaxid;
                                }
                                if (value.length > 20) {
                                  return localization.maxlegth20;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: localization.legalname,
                                hintStyle: const  TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText:  localization.legalname,
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
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
                                  return localization.requiredbussinessname;
                                }
                                if (value.length < 2) {
                                  return localization.minlegth3;
                                }
                                if (value.length > 40) {
                                  return localization.maxlegth40;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: localization.bussinessname,
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: 'Business Name',
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
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
                                  return localization.requiredbussinessname;
                                }
                                if (value.length < 2) {
                                  return localization.minlegth3;
                                }
                                if (value.length > 40) {
                                  return localization.maxlegth40;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: localization.branchm,
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: localization.branchm,
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: const  OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
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
                                  return localization.minlegth3;
                                }
                                if (value.length > 17) {
                                  return localization.maxlegth17;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              maxLines: 2,
                              decoration: InputDecoration(
                                hintText: localization.address,
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                labelText: localization.address,
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
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
                                  return localization.requiredaddress;
                                }
                                if (value.length < 2) {
                                  return localization.minlegth3;
                                }
                                if (value.length > 100) {
                                  return localization.maxlegth100;
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
                            Text(localization.aditionalinformation,
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
                                decoration: InputDecoration(
                                  hintText: localization.note,
                                  hintStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  labelText: localization.note,
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  prefixIcon: const Icon(Icons.info_outline_rounded,
                                      color: Colors.black, size: 20),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65),
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: const OutlineInputBorder(
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
                                    return localization.requirednote;
                                  }
                                  if (value.length < 2) {
                                    return localization.minlegth3;
                                  }
                                  if (value.length > 180) {
                                    return localization.max179legth;
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
