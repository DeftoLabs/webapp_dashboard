import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/products_provider.dart';
import 'package:web_dashboard/ui/modals/product_modal.dart';

class ProductsDTS extends DataTableSource {

  final List<Producto> productos;
  final BuildContext context;

  ProductsDTS(this.productos, this.context);

  @override
  DataRow? getRow(int index) {

    final product = productos[index];

    return DataRow.byIndex(
      index: index,
      cells:[ 
        DataCell (Text(product.descripcion.toString())), 
        DataCell ( Text(product.usuario.nombre)),    
        DataCell (
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: (){
                   showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context, 
                      builder: ( _ ) => ProductModal(producto: product));

                } ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.4)),
                onPressed: (){
                  final dialog = AlertDialog(
                    title: const Text('Are you sure to delete this register?'),
                    content: Text('Delete ${product.nombre}'),
                    actions: [
                      TextButton(
                        child: const Text('No'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, ),
                      TextButton(
                        child: const Text('Yes, Delete'),
                        onPressed: () async {
                          final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
                          await productsProvider.deleteProduct(product.id);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }, )
                    ],
                  );

                  showDialog(
                    context: context, 
                    builder: ( _ ) => dialog);
                } ),
            ],
          )
        ),
      ]
       );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => productos.length;

  @override
  int get selectedRowCount => 0;

}