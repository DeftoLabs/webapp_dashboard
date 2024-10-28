
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class ProductNewModal extends StatefulWidget {
  final Producto? producto;

  const ProductNewModal({super.key, this.producto});

  @override
  State<ProductNewModal> createState() => _ProductNewModalState();
}

class _ProductNewModalState extends State<ProductNewModal> {
  String nombre = '';
  double precio1 = 0.0;
  double precio2 = 0.0;
  double precio3 = 0.0;
  double precio4 = 0.0;
  double precio5 = 0.0;
  String? descripcion;
  String? id;
  double stock = 0.0;
  String? unid;
  String? categoria;
  String? finance;

  final _precioController1  = TextEditingController();
  final _precioController2 = TextEditingController();
  final _precioController3 = TextEditingController();
  final _precioController4 = TextEditingController();
  final _precioController5 = TextEditingController();
  final _stockController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeProduct();
  }

  void _initializeProduct() {
    final producto = widget.producto;
    nombre = producto?.nombre ?? '';
    precio1 = producto?.precio1 ?? 0.0;
    precio2 = producto?.precio2 ?? 0.0;
    precio3 = producto?.precio3 ?? 0.0;
    precio4 = producto?.precio4 ?? 0.0;
    precio5 = producto?.precio5 ?? 0.0;
    descripcion = producto?.descripcion;
    id = producto?.id;
    stock = producto?.stock ?? 0.0;
    unid = producto?.unid;
    categoria = producto?.categoria.id;
    finance = producto?.finance.id;

    _precioController1.text = precio1.toString();  
    _precioController2.text = precio2.toString();
    _precioController3.text = precio3.toString();
    _precioController4.text = precio4.toString();
    _precioController5.text = precio5.toString();

    _stockController.text = stock.toString();

    final categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);
    categoriesProvider.getCategories();

    final financeProvider = Provider.of<FinanceProvider>(context, listen: false);
    financeProvider.getFinance();
  
  }
  

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    productProvider.producto;

    return Consumer<ProductsProvider>(
        builder: (context, productProvider, child) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 700,
          width: 800,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 58, 60, 65),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ADD PRODUCT',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 20),
                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(450),
                      1: FixedColumnWidth(250),
                      2: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: WhiteCardNoMargin(
                              title: 'PRODUCT DETAIL',
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                    TextFormField(
                                      initialValue: nombre,
                                      onChanged: (value) {
                                        final uppercaseValue = value.toUpperCase();
                                        nombre = uppercaseValue;          
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'BarCode & Internal Code',
                                        labelText: 'BarCode & Internal Code',
                                        labelStyle: GoogleFonts.plusJakartaSans(
                                            color: Colors.black, fontSize: 12),
                                        hintStyle: GoogleFonts.plusJakartaSans(
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              width: 1.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0),
                                        ),
                                      ),
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'This field is required';
                                        }
                                        if (value.length > 20) {
                                          return 'The code cannot have more than 20 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _stockController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: InputDecoration(
                                      hintText: 'Stock',
                                      labelText:
                                          'Stock - (Accept 2 Digits )e.g. 10.20',
                                      labelStyle: GoogleFonts.plusJakartaSans(
                                          color: Colors.black, fontSize: 12),
                                      hintStyle: GoogleFonts.plusJakartaSans(
                                          color: Colors.black.withOpacity(0.7)),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                      border: const OutlineInputBorder(),
                                    ),
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.black),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Stock is required';
                                      }
                                      if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                          .hasMatch(value)) {
                                        return 'Invalid Stock Format. Use "." for decimals and Max 2 Decimals';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'Invalid number';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (double.tryParse(value) != null) {
                                        stock = double.tryParse(value) ?? 0.0;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  Consumer<ProductsProvider>(
                                    builder: (context, productProvider, child) {
                                      return DropdownButtonFormField<String>(
                                        value: unid,
                                        decoration: InputDecoration(
                                          hintText: 'Unit',
                                          labelText: 'Unit',
                                          labelStyle:
                                              GoogleFonts.plusJakartaSans(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                          hintStyle:
                                              GoogleFonts.plusJakartaSans(
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                width: 1.0),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1.0),
                                          ),
                                          border: const OutlineInputBorder(),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        dropdownColor: Colors.white,
                                        items:
                                            productProvider.units.map((unit) {
                                          return DropdownMenuItem<String>(
                                            value: unit,
                                            child: Text(unit,
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            unid = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Unit is required';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: descripcion,
                                      onChanged: (value) {
                                        final uppercaseValue = value.toUpperCase();
                                        descripcion = uppercaseValue;          
                                      },
                                    decoration: InputDecoration(
                                      hintText: 'Description',
                                      labelText: 'Description',
                                      labelStyle: GoogleFonts.plusJakartaSans(
                                          color: Colors.black, fontSize: 12),
                                      hintStyle: GoogleFonts.plusJakartaSans(
                                          color: Colors.black.withOpacity(0.7)),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 20),
                                  Consumer<CategoriesProvider>(
                                    builder:
                                        (context, categoriesProvider, child) {
                                      return DropdownButtonFormField<String>(
                                        value: categoria,
                                        decoration: InputDecoration(
                                            hintText: 'Category',
                                            labelText: 'Category',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                            hintStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: Colors.black
                                                        .withOpacity(0.7)),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  width: 1.0),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                            ),
                                            border: const OutlineInputBorder()),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black),
                                        dropdownColor: Colors.white,
                                        items: categoriesProvider.categorias
                                            .map((category) {
                                          return DropdownMenuItem<String>(
                                            value: category.id,
                                            child: Text(category.nombre),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            categoria = value!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a Category';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  Consumer<FinanceProvider>(
                                    builder: (context, financeProvider, child) {
                                      return DropdownButtonFormField<String>(
                                        value: finance, 
                                        decoration: InputDecoration(
                                        hintText: 'Select a TAX',
                                        labelText: 'TAX',
                                        labelStyle:  GoogleFonts.plusJakartaSans(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                        hintStyle:  GoogleFonts.plusJakartaSans(
                                                    color: Colors.black.withOpacity(0.7)),
                                           focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(0, 0, 0, 1), width: 1.0),),
                                        enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                            ),
                                            border: const OutlineInputBorder()),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black),
                                        dropdownColor: Colors.white,
                                      items: financeProvider.finances
                                            .map((finances) {
                                          return DropdownMenuItem<String>(
                                            value: finances.id,
                                            child: Text(finances.tax1number.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                        setState(() {
                                          finance = value;
                                        });
                                      },
                                      validator: (value) {
                                        if(value == null || value.isEmpty) {
                                          return 'PLEASE SELECT A TAX';
                                        }
                                        return null;
                                      },
                                          );        
                                      }
                                  ),
                                  const SizedBox(height: 20), 
                                ],
                              ),
                            )),
                        ChangeNotifierProvider.value(
                          value: productProvider,
                          child: WhiteCardNoMargin(
                            title: 'LEVELS PRICE',
                            width: 250,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),

                                  // Primero
                             Row(
                                    children: [
                                      const Text('1. ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _precioController1,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          decoration: InputDecoration(
                                            hintText: 'Price',
                                            labelText: 'Price - e.g. 10.20',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12),
                                            hintStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                            255, 0, 0, 0)
                                                        .withOpacity(0.7)),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 58, 60, 65),
                                                  width: 1.0),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  width: 1.0),
                                            ),
                                            border: const OutlineInputBorder(),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.black),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Price is required';
                                            }
                                            if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                                .hasMatch(value)) {
                                              return 'Invalid price format. Use "." for decimals';
                                            }
                                            if (double.tryParse(value) ==
                                                null) {
                                              return 'Invalid number';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (double.tryParse(value) !=
                                                null) {
                                              precio1 =
                                                  double.tryParse(value) ?? 0.0;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  // Segundo
                                  Row(
                                    children: [
                                      const Text('2. ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _precioController2,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          decoration: InputDecoration(
                                            hintText: 'Price',
                                            labelText: 'Price - e.g. 10.20',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12),
                                            hintStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                            255, 0, 0, 0)
                                                        .withOpacity(0.7)),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 58, 60, 65),
                                                  width: 1.0),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  width: 1.0),
                                            ),
                                            border: const OutlineInputBorder(),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.black),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Price is required';
                                            }
                                            if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                                .hasMatch(value)) {
                                              return 'Invalid price format. Use "." for decimals';
                                            }
                                            if (double.tryParse(value) ==
                                                null) {
                                              return 'Invalid number';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (double.tryParse(value) !=
                                                null) {
                                              precio2 =
                                                  double.tryParse(value) ?? 0.0;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  // Tercero
                                  Row(
                                    children: [
                                      const Text('3. ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _precioController3,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          decoration: InputDecoration(
                                            hintText: 'Price',
                                            labelText: 'Price - e.g. 10.20',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12),
                                            hintStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                            255, 0, 0, 0)
                                                        .withOpacity(0.7)),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 58, 60, 65),
                                                  width: 1.0),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  width: 1.0),
                                            ),
                                            border: const OutlineInputBorder(),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.black),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Price is required';
                                            }
                                            if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                                .hasMatch(value)) {
                                              return 'Invalid price format. Use "." for decimals';
                                            }
                                            if (double.tryParse(value) ==
                                                null) {
                                              return 'Invalid number';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (double.tryParse(value) !=
                                                null) {
                                              precio3 =
                                                  double.tryParse(value) ?? 0.0;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  // Cuarto
                                  Row(
                                    children: [
                                      const Text('4. ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _precioController4,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          decoration: InputDecoration(
                                            hintText: 'Price',
                                            labelText: 'Price - e.g. 10.20',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12),
                                            hintStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                            255, 0, 0, 0)
                                                        .withOpacity(0.7)),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 58, 60, 65),
                                                  width: 1.0),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  width: 1.0),
                                            ),
                                            border: const OutlineInputBorder(),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.black),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Price is required';
                                            }
                                            if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                                .hasMatch(value)) {
                                              return 'Invalid price format. Use "." for decimals';
                                            }
                                            if (double.tryParse(value) ==
                                                null) {
                                              return 'Invalid number';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (double.tryParse(value) !=
                                                null) {
                                              precio4 =
                                                  double.tryParse(value) ?? 0.0;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  // Quinto
                                  Row(
                                    children: [
                                      const Text('5. ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _precioController5,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          decoration: InputDecoration(
                                            hintText: 'Price',
                                            labelText: 'Price - e.g. 10.20',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12),
                                            hintStyle:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color.fromARGB(
                                                            255, 0, 0, 0)
                                                        .withOpacity(0.7)),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 58, 60, 65),
                                                  width: 1.0),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  width: 1.0),
                                            ),
                                            border: const OutlineInputBorder(),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.black),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Price is required';
                                            }
                                            if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                                .hasMatch(value)) {
                                              return 'Invalid price format. Use "." for decimals';
                                            }
                                            if (double.tryParse(value) ==
                                                null) {
                                              return 'Invalid number';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (double.tryParse(value) !=
                                                null) {
                                              precio5 =
                                                  double.tryParse(value) ?? 0.0;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: CustomOutlineButtom(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            if (id == null) {
                              await productProvider.newCreateProduct(
                                nombre: nombre,
                                precio1: precio1,
                                precio2: precio2,
                                precio3: precio3,
                                precio4: precio4,
                                precio5: precio5,
                                descripcion: descripcion,
                                stock: stock,
                                unid: unid!,
                                categoria: categoria!,
                                finance: finance!,
                              );
                              if(! context.mounted) return;
                              NotificationService.showSnackBa(
                                  '$descripcion Created');
                            }
                            Navigator.of(context).pop();
                          } catch (e) {
                            NotificationService.showSnackBarError(
                                'Could not save the Product');
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      text: 'Save',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
