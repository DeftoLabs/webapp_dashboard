import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/categories_provider.dart';
import 'package:web_dashboard/providers/product_form_provider.dart';
import 'package:web_dashboard/providers/products_provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class ProductView extends StatefulWidget {
  final String id;

  const ProductView({super.key, required this.id});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Producto? producto;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final productFormProvider = Provider.of<ProductFormProvider>(context, listen: false);

    productsProvider.getProductById(widget.id).then((productDB) {
    productFormProvider.producto = productDB;

      if( productDB !=null ) {
        productFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
        producto = productDB;
        _isLoading = false;
      });
      }else {
        NavigationService.navigateTo('/dashboard/products');
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
        color: Color.fromRGBO(255, 0, 200, 0.612),
        strokeWidth: 4.0),
        );
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(), 
          children: [
          Row(
            children: [
              IconButton(
                  color: Colors.black,
                  onPressed: () {
                    NavigationService.replaceTo('/dashboard/products');
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              Expanded(
                  child: Center(
                child: Text('Product View', style: CustomLabels.h1),
              )),
            ],
          ),
          const SizedBox(height: 10),
          _ProductViewBody()
        ]
        ));
  }
}

class _ProductViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(250),
        1: FixedColumnWidth(500),
        2: FixedColumnWidth(250),
      },
      children: [
        TableRow(children: [_Avatar(), _ProductFormView(), _PriceProductView()])
      ],
    );
  }
}

class _PriceProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final producto = productFormProvider.producto!;

    return WhiteCardColor(
      title: 'Prices',
      child: SizedBox(
          height: 330,
          child: Column(children: [
            const SizedBox(height: 20),
            TextFormField(
                initialValue: producto.precio.toString(),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Price',
                  labelText: 'Price - e.g. 10.20',
                  labelStyle: GoogleFonts.plusJakartaSans(
                      color: Colors.white, fontSize: 12),
                  hintStyle: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withOpacity(0.7)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  border: const OutlineInputBorder(),
                ),
                style: GoogleFonts.plusJakartaSans(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  }
                  if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
                    return 'Invalid price format. Use "." for decimals';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  producto.precio = double.tryParse(value) ?? 0.0;
                }),
          ])),
    );
  }
}

class _ProductFormView extends StatefulWidget {
  @override
  State<_ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<_ProductFormView> {
  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final producto = productFormProvider.producto!;

    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoriesProvider.getCategories();

    return WhiteCardColor(
        title: 'General Information',
        child: Form(
          key: productFormProvider.formKey,
          child: Container(
            height: 450,
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(children: [
                Container(
                  width: 440,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(177, 255, 46, 100),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    producto.nombre,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: producto.descripcion,
                  onChanged: (value) => producto.descripcion = value,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                    labelStyle: GoogleFonts.plusJakartaSans(
                        color: Colors.white, fontSize: 12),
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: Colors.white.withOpacity(0.7)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  validator: (value) {
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        value.length > 20) {
                      return 'Description cannot be more than 20 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                    initialValue: producto.stock.toString(),
                    style: const TextStyle(
                        color: Colors.white), // Añade esta línea
                    decoration: InputDecoration(
                      hintText: 'Stock',
                      hintStyle: GoogleFonts.plusJakartaSans(
                          color: Colors.white.withOpacity(0.7)),
                      labelText: 'Stock - (Accept 2 Digits )e.g. 10.20',
                      labelStyle: GoogleFonts.plusJakartaSans(
                          color: Colors.white, fontSize: 12),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(177, 255, 46, 100),
                            width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Stock is required';
                      }
                      if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
                        return 'Invalid Stock Format. Use "." for decimals and Max 2 Decimals';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      producto.stock = double.tryParse(value) ?? 0.0;
                    }),
                const SizedBox(height: 20),
                Consumer<ProductsProvider>(
                  builder: (context, productProvider, child) {
                    return DropdownButtonFormField<String>(
                      value: producto.unid,
                      decoration: InputDecoration(
                        hintText: 'Unit',
                        labelText: 'Unit',
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 12),
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.7)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(177, 255, 46, 100),
                              width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      dropdownColor: const Color.fromARGB(255, 58, 60, 65),
                      items: productProvider.units.map((unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit,
                              style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        producto.unid = value!;
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
                Consumer<CategoriesProvider>(
                  builder: (context, categoriesProvider, child) {
                    return DropdownButtonFormField<String>(
                      value: producto.categoria.id,
                      decoration: InputDecoration(
                        hintText: 'Category',
                        labelText: 'Category',
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 12),
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.7)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(177, 255, 46, 100),
                              width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      dropdownColor: Colors.grey[800],
                      items: categoriesProvider.categorias.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(category.nombre,
                              style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          producto.categoria.id = value!;
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
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  child: CustomOutlineButtom(
                    onPressed: () async {
                      final saved = await productFormProvider.updateProduct();

                      if (saved) {
                        NotificationService.showSnackBa(
                            '${producto.descripcion} Updated');
                            NavigationService.replaceTo('/dashboard/products');
                      } else {
                        NotificationService.showSnackBarError(
                            'Could not save the Product');
                      }
                    },
                    text: 'Save',
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}

class _Avatar extends StatefulWidget {
  @override
  State<_Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<_Avatar> {
  @override
  Widget build(BuildContext context) {

    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final producto = productFormProvider.producto!;

      final image = (producto.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg')) 
    : FadeInImage.assetNetwork(
      placeholder: 'load.gif', 
      image: producto.img!);


    return WhiteCard(
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(
                      child: image),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 5)),
                        child: FloatingActionButton(
                            backgroundColor:
                                const Color.fromRGBO(177, 255, 46, 100),
                            elevation: 0,
                            child: const Icon(Icons.camera_alt_outlined),
                            onPressed: () async {
                                   FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'jpeg', 'png'],
                            allowMultiple: false,
                          );
                          if (result != null) {
                              if(!context.mounted) return;
                              NotificationService.showBusyIndicator(context);
                              await productFormProvider.uploadImage(
                                '/uploads/productos/${producto.id}',
                                result.files.first.bytes!,
                              );
                                if(!context.mounted) return;
                              Navigator.of(context).pop();
                            } else {
                              NotificationService.showSnackBarError('Failed to Upload Image');
                            }
                            })),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Recommended Image Size:',
                style: GoogleFonts.plusJakartaSans(fontSize: 12)),
            Text(
              '450x450 Pixels',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
