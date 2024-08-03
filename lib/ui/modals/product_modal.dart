import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/products_provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';
import 'package:web_dashboard/ui/shared/widget/image_product.dart';

class ProductModal extends StatefulWidget {
  final Producto? producto;

  const ProductModal({super.key, this.producto});

  @override
  State<ProductModal> createState() => _ProductModalState();
}

class _ProductModalState extends State<ProductModal> {
  String nombre = '';
  double precio = 0.0;
  String? descripcion;
  String? id;
  bool disponible = true;
  String? categoria;

  final _precioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nombre = widget.producto?.nombre ?? '';
    precio = widget.producto?.precio ?? 0.0;
    descripcion = widget.producto?.descripcion;
    id = widget.producto?.id;
    disponible = widget.producto?.disponible ?? true;
    categoria = widget.producto?.categoria.id;

    _precioController.text = precio.toString();

    final categoriesProvider =
        Provider.of<CategoriesProvier>(context, listen: false);
    categoriesProvider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 470,
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
                      widget.producto?.descripcion ?? 'Add Product',
                      style: CustomLabels.h1.copyWith(color: Colors.white),
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
                    0: FixedColumnWidth(250),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(children: [
                       ImageProduct(producto: widget.producto),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: nombre,
                                onChanged: (value) => nombre = value,
                                decoration: InputDecoration(
                                  hintText: 'BarCode & Internal Code',
                                  labelText: 'BarCode & Internal Code',
                                  labelStyle: GoogleFonts.plusJakartaSans(
                                      color: Colors.white, fontSize: 12),
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                      color: Colors.white.withOpacity(0.7)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(177, 255, 46, 100),
                                        width: 2.0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                ),
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (value.length > 20) {
                                    return 'The code cannot have more than 20 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _precioController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: InputDecoration(
                                  hintText: 'Price',
                                  labelText: 'Price - e.g. 10.20',
                                  labelStyle: GoogleFonts.plusJakartaSans(
                                      color: Colors.white, fontSize: 12),
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                      color: Colors.white.withOpacity(0.7)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(177, 255, 46, 100),
                                        width: 2.0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Price is required';
                                  }
                                  if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                      .hasMatch(value)) {
                                    return 'Invalid price format. Use "." for decimals';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Invalid number';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (double.tryParse(value) != null) {
                                    precio = double.tryParse(value) ?? 0.0;
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                initialValue: descripcion,
                                onChanged: (value) => descripcion = value,
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  labelText: 'Description',
                                  labelStyle: GoogleFonts.plusJakartaSans(
                                      color: Colors.white, fontSize: 12),
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                      color: Colors.white.withOpacity(0.7)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(177, 255, 46, 100),
                                        width: 2.0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                ),
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Consumer<CategoriesProvier>(
                                builder: (context, categoriesProvider, child) {
                                  return DropdownButtonFormField<String>(
                                    value: categoria,
                                    decoration: InputDecoration(
                                      hintText: 'Category',
                                      labelText: 'Category',
                                      labelStyle: GoogleFonts.plusJakartaSans(
                                          color: Colors.white, fontSize: 12),
                                      hintStyle: GoogleFonts.plusJakartaSans(
                                          color: Colors.white.withOpacity(0.7)),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                177, 255, 46, 100),
                                            width: 2.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white),
                                    dropdownColor: Colors.grey[800],
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
                            ],
                          ))
                    ])
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: CustomOutlineButtom(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          if (id == null) {
                            await productProvider.newProduct(
                              nombre: nombre,
                              precio: precio,
                              descripcion: descripcion,
                              disponible: disponible,
                              categoria: categoria!,
                            );
                            NotificationService.showSnackBa(
                                '$descripcion Created');
                          } else {
                            await productProvider.updateProduct(
                              id: id!,
                              nombre: nombre,
                              precio: precio,
                              descripcion: descripcion,
                              disponible: disponible,
                              categoria: categoria!,
                            );
                            NotificationService.showSnackBa(
                                '$descripcion Updated');
                          }
                          if (mounted) Navigator.of(context).pop();
                        } catch (e) {
                          print('Error saving product: $e');
                          if (mounted)
                            NotificationService.showSnackBa(
                                'Could not save the Product');
                          if (mounted) Navigator.of(context).pop();
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
  }
}


