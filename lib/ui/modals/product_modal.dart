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
  double stock = 0.0;
  String? categoria;
  String? img;
  

  final _precioController = TextEditingController();
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
    precio = producto?.precio ?? 0.0;
    descripcion = producto?.descripcion;
    id = producto?.id;
    stock = producto?.stock ?? 0.0;
    categoria = producto?.categoria.id;
    img = producto?.img;

    _precioController.text = precio.toString();
    _stockController.text  = stock.toString();

    final categoriesProvider = Provider.of<CategoriesProvier>(context, listen: false);
    categoriesProvider.getCategories();
  }

  Widget _buildNonEditableField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
              color: Colors.white.withOpacity(0.7), fontSize: 12),
        ),
        const SizedBox(height: 5),
        Container(
          width: 600,
          height:45,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(177, 255, 46, 100),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {

    return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
 return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 500,
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
                    TableRow(
                      children: [
                      ChangeNotifierProvider.value(
                        value: productProvider,
                        child: ImageProduct(producto: widget.producto)),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                                 if (nombre.isEmpty)
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
                                    )
                                  else
                                    _buildNonEditableField('BarCode & Internal Code', nombre),
                              const SizedBox(height: 10),
                               TextFormField(
                                controller: _stockController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: InputDecoration(
                                  hintText: 'Stock',
                                  labelText: 'Stock - (Accept 2 Digits )e.g. 10.20',
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
                              stock: stock,
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
                              stock: stock,
                              categoria: categoria!,
                            );
                            NotificationService.showSnackBa('$descripcion Updated');
                          }
                          if(!context.mounted) return;
                          Navigator.of(context).pop();
                        } catch (e) {
                          NotificationService.showSnackBa('Could not save the Product');
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

   