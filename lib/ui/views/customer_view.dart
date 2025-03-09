import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/providers/customer_form_provider.dart';
import 'package:web_dashboard/providers/customers_provider.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/providers/zones_providers.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

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
  final customerProvider = Provider.of<CustomersProvider>(context, listen: false);
  final customerFormProvider = Provider.of<CustomerFormProvider>(context, listen: false);
  
  customerProvider.getCustomerById(widget.id).then((customerDB) {
    
    if (customerDB != null) {
      customerFormProvider.customer = customerDB;
      customerFormProvider.formKey = GlobalKey<FormState>();
      setState(() {
        customer = customerDB;
      });
    } else {
      NavigationService.replaceTo('/dashboard/customers');
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


    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 60, height: 60) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 60, height: 60);

    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.getPaginatedUsers();

    if (customer == null) {
      return const Center(
        child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 4.0),
      );
    }

    final localization = AppLocalizations.of(context)!;

    return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 58, 60, 65),
      borderRadius: BorderRadius.circular(10)
    ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: customerFormProvider.formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                    children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      NavigationService.replaceTo('/dashboard/customers');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                    Text(localization.back, style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14)),
                      Expanded(
                        child: Center(
                          child: Text(
                            localization.customer,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white), // Usa el color del título aquí
                          ),
                        ),
                      ),
                      ClipOval(child: image),
                      const SizedBox(width: 20)
                    ],
                  ),
                  const SizedBox(height: 20),
              Table(
                columnWidths: const {
                  0: FixedColumnWidth(350),
                  1: FixedColumnWidth(10),
                },
                children: [
                  TableRow(
                    children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
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
                              const SizedBox(height:10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                        initialValue: customer.credito.toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: localization.conditionsales,
                                          hintStyle: const TextStyle(
                                              color: Colors.black, fontSize: 16),
                                          labelText: localization.creditinfo,
                                          labelStyle: const  TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          prefixIcon: const Icon(Icons.monetization_on,
                                              color: Colors.black, size: 20),
                                          enabledBorder: const OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.black, width: 1)),
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
                                        onChanged: (value) =>
                                            customerFormProvider.copyCustomerWith(
                                                credito: value as int),
                                        validator: (value) {
                                    if (value == null || value.isEmpty) {
                                        return localization.requiredcredit;
                                      }
                                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                        return localization.onlynumbers;
                                      }
                                      if (value.length > 4) {
                                        return localization.maxlegth3;
                                      }
                                      return null;
                                    }
                                        ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(localization.days,
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 120)
                                ],
                              ),
                              const SizedBox(height: 10),
                               Consumer<ZonesProviders>(
                              builder: (context, zonasProvider, child) {
                                return DropdownButtonFormField<String>(
                                  value: customer.zona.id, 
                                  decoration: InputDecoration(
                              hintText: localization.zonename,
                              labelText: localization.zonename,
                              labelStyle: GoogleFonts.plusJakartaSans(
                                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                              hintStyle: GoogleFonts.plusJakartaSans(
                                color: Colors.black.withValues(alpha: 0.7)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.0),
                              ),
                                                      ),
                                                      style: GoogleFonts.plusJakartaSans(color: Colors.black),
                                                      dropdownColor: Colors.grey[300],
                                                      items: zonasProvider.zonas.map((zona) {
                              return DropdownMenuItem<String>(
                                value: zona.id,  
                                child: Text(zona.nombrezona, 
                                    style: const TextStyle(color: Colors.black)),
                              );
                                }).toList(),
                                onChanged: (value) {
                              setState(() {
                                customer.zona.id = value!; 
                              });
                                  },
                                  validator: (value) {
                              if (value == null || value.isEmpty) {
                                return localization.selectzone;
                              }
                              return null;
                                   },
                                 );
                               },
                             ),
                               const SizedBox(height: 10),
                                   ],
                                 ),
                            )),
                        const SizedBox(height: 10),
                        Container(
                          decoration: 
                          BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
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
                                  initialValue: customer.contacto,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: localization.manager,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: localization.manager,
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: const Icon(Icons.person_rounded,
                                        color: Colors.black, size: 20),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 1)),
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
                                  onChanged: (value) {
                                  final uppercaseValue = value.toUpperCase();
                                   customerFormProvider.copyCustomerWith(contacto: uppercaseValue);
                                  },
                                
                                  validator: (value) {
                                        if (value == null || value.isEmpty) {
                                    return localization.requiredmanager;
                                  }
                                  if (value.length > 31) {
                                    return localization.maxlegth30;
                                  }
                                  return null;
                                  }
                                  ),
                              const SizedBox(height: 10),
                              TextFormField(
                                  initialValue: customer.telefono,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: localization.phone,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: localization.phone,
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: const Icon(Icons.phone_iphone_rounded,
                                        color: Colors.black, size: 20),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 1)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65),
                                    )),
                                    errorBorder:const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)),
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65),
                                    )),
                                  ),
                                  onChanged: (value) => customerFormProvider
                                      .copyCustomerWith(telefono: value),
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
                                initialValue: customer.correo,
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
                                      borderSide: BorderSide(color: Colors.black, width: 1)),
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
                                customerFormProvider.copyCustomerWith(correo: lowercaseValue);
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
                                initialValue: customer.web,
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
                                      borderSide: BorderSide(color: Colors.black, width: 1)),
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
                                customerFormProvider.copyCustomerWith(web: lowercaseValue);
                                }, 
                                 validator: (value) {
                                     if (value == null || value.isEmpty) {
                                    return localization.requiredwebsite;
                                  }
                                  if (value.length > 41) {
                                    return localization.maxlegth40;
                                  }
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
                                                    ),
                            )
                        ),
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
                                onPressed: () async {
                                  final saved = await customerFormProvider.updateCustomer();
                                  if (saved) {
                                    if (!context.mounted) return;
                                    NotificationService.showSnackBa(localization.updatecustomer);
                                    Provider.of<CustomersProvider>(context, listen: false)
                                        .refreshCustomer(customer);
                                      if(!context.mounted) return;
                                    Navigator.of(context).popAndPushNamed('/dashboard/customers');
                                  } else {
                                    NotificationService.showSnackBarError(
                                        localization.errorupdatecustomer);
                                  }
                                },
                              ),
                            ),
                      ],
                    ),
                    // ESPACIO DIVISION ENTRE COLUMN
                    const Column(
                      
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                                      children: [
                              Row(
                                children: [
                                  Text('${localization.code} ${customer.codigo}',
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
                                style: const TextStyle
                                (
                                    color: Colors.black, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: localization.taxid,
                                  hintStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  labelText: localization.taxid,
                                  labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: customer.idfiscal.isEmpty
                                      ? const Icon(Icons.info_sharp,
                                          color: Colors.black, size: 20)
                                      : null,
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1)),
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
                                onChanged: (value) {
                                final uppercaseValue = value.toUpperCase();
                                customerFormProvider.copyCustomerWith(idfiscal: uppercaseValue);
                                }, 
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return localization.requiredtaxid;
                                }
                                if (value.length < 2) {
                                  return localization.maxlegth3;
                                }
                                if (value.length > 21) return localization.maxlegth20;
                                return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                  initialValue: customer.razons,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: localization.legalname,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: localization.legalname,
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: customer.razons.isEmpty
                                        ? const Icon(Icons.business_outlined,
                                            color: Colors.black, size: 20)
                                        : null,
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 1)),
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
                                  onChanged: (value) {
                                    final uppercaseValue = value.toUpperCase();
                                    customerFormProvider.copyCustomerWith(razons: uppercaseValue);
                                  },  
                                  validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Legal Name is Required';
                                  }
                                  if (value.length < 2) {
                                    return localization.minlegth3;
                                  }
                                  if (value.length > 40) {
                                    return localization.maxlegth40;
                                  }
                                  return null;
                                  }),
                              const SizedBox(height: 10),
                              TextFormField(
                                  initialValue: customer.nombre,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: localization.bussinessname,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: localization.bussinessname,
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: customer.nombre.isEmpty
                                        ? const Icon(Icons.burst_mode_sharp,
                                            color: Colors.black, size: 20)
                                        : null,
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 1)),
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
                                  onChanged: (value) {
                                    final uppercaseValue = value.toUpperCase();
                                    customerFormProvider.copyCustomerWith(nombre: uppercaseValue);
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
                                  }
                                  ),
                              const SizedBox(height: 10),
                              TextFormField(
                                  initialValue: customer.sucursal,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: localization.branchm,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: localization.branchm,
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16),
                                    prefixIcon: customer.sucursal.isEmpty
                                        ? const Icon(Icons.business_outlined,
                                            color: Colors.black, size: 20)
                                        : null,
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 1)),
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
                                  onChanged: (value) {
                                  final uppercaseValue = value.toUpperCase();
                                  customerFormProvider.copyCustomerWith(sucursal: uppercaseValue);
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
                                  }),
                              const SizedBox(height: 10),
                              TextFormField(
                                  initialValue: customer.direccion,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: localization.address,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: localization.address,
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: customer.direccion.isEmpty
                                        ? const Icon(Icons.location_city_rounded,
                                            color: Colors.black, size: 20)
                                        : null,
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 1)),
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
                                  onChanged: (value) {
                                    final uppercaseValue = value.toUpperCase();
                                    customerFormProvider.copyCustomerWith(direccion: uppercaseValue);                  
                                  }, 
                                  validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return localization.requiredaddress;
                                  }
                                  if (value.length < 2) {
                                    return localization.minlegth3;
                                  }
                                  if (value.length > 91) {
                                    return localization.max90legth;
                                  }
                                  return null;
                                  }),
                              const SizedBox(height: 30),
                                                      ],
                                                    ),
                            )),
                            const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
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
                                  initialValue: customer.note,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    hintText: localization.note,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: localization.note,
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: const Icon(Icons.info_outline_rounded,
                                        color: Colors.black, size: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 58, 60, 65),
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)),
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 58, 60, 65),
                                    )),
                                  ),
                                  onChanged: (value) {
                                  final uppercaseValue = value.toUpperCase();
                                  customerFormProvider.copyCustomerWith(note: uppercaseValue);
                                  }, 
                                  validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return localization.requirednote;
                                  }
                                  if (value.length < 2) {
                                    return localization.minlegth3;
                                  }
                                  if (value.length > 180) return localization.max179legth;
                                  return null;
                                  }),
                              const SizedBox(height: 10),
                                                      ],
                                                    ),
                            ))
                      ],
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 20),
            
            ],
          ),
        ),
      ),
    );
  }
}
