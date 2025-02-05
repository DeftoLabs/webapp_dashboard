import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/products_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class ProductsDTS extends DataTableSource {

  final List<Producto> productos;
  final BuildContext context;

  ProductsDTS(this.productos, this.context);

  @override
  DataRow? getRow(int index) {

    final product = productos[index];

    final image = (product.img == null || product.img!.isEmpty) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35,) 
    : FadeInImage.assetNetwork(
      placeholder: 'load.gif', 
      image: product.img!, width: 35, height: 35,);


    return DataRow.byIndex(
      index: index,
      cells:[ 
        DataCell ( Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            )
          ),
          child: ClipOval( child: image)) ), 


        DataCell (Text(product.nombre)), 
        DataCell (Text(product.descripcion ?? '')),
        DataCell (Text(product.stock.toString())),
        DataCell (Text(product.unid)),
        DataCell (Text(product.precio1.toString())),
        DataCell (Text(product.categoria.nombre)),                
        DataCell (
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: (){
                 NavigationService.replaceTo('/dashboard/products/${product.id}');
                } 
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red.withValues(alpha: 0.4)),
                onPressed: (){
                  final dialog = AlertDialog(
                    title: const Text('Are you sure to delete this register?'),
                    content: Text('Delete ${product.nombre}'),
                    actions: [
                      TextButton(
                        child: const Text('No'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                      ),
                      TextButton(
                        child: const Text('Yes, Delete'),
                        onPressed: () async {
                          final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
                          await productsProvider.deleteProduct(product.id);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }, 
                      )
                    ],
                  );

                  showDialog(
                    context: context, 
                    builder: ( _ ) => dialog);
                } 
              ),
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
