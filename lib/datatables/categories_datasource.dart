import 'package:flutter/material.dart';
import 'package:web_dashboard/models/categories.dart';
import 'package:web_dashboard/ui/modals/category_modal.dart';



class CategoriesDTS extends DataTableSource {

  final List<Categoria> categorias;
  final BuildContext context;

  CategoriesDTS(this.categorias, this.context);

  @override
  DataRow? getRow(int index) {

    final category = categorias[index];

    return DataRow.byIndex(
      index: index,
      cells:[ 
        DataCell (Text(category.nombre)),
        DataCell (Text(category.usuario.nombre)),        
       // DataCell (
       //   Row(
       //     children: [
       //       IconButton(
       //         icon: const Icon(Icons.edit_outlined),
       //         onPressed: (){
       //            showDialog(
       //               context: context, 
       //               builder: ( _ ) => CategoryModal(categoria: category));
//
       //         } ),
//
       //       // Opcion para cambiar el estado de la categoria - FALSE -
//
       //       //IconButton(
       //       //  icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.4)),
       //       //  onPressed: (){
       //       //    final dialog = AlertDialog(
       //       //      title: const Text('Are you sure to delete this register?'),
       //       //      content: Text('Delete ${category.nombre}'),
       //       //      actions: [
       //       //        TextButton(
       //       //          child: const Text('No'),
       //       //          onPressed: (){
       //       //            Navigator.of(context).pop();
       //       //          }, ),
       //       //        TextButton(
       //       //          child: const Text('Yes, Delete'),
       //       //          onPressed: () async {
       //       //            final categoriesProvider = Provider.of<CategoriesProvier>(context, listen: false);
       //       //            await categoriesProvider.deleteCategory(category.id);
       //       //            if (context.mounted) {
       //       //              Navigator.of(context).pop();
       //       //            }
       //       //          }, )
       //       //      ],
       //       //    );
////
       //       //    showDialog(
       //       //      context: context, 
       //       //      builder: ( _ ) => dialog);
       //       //  } ),
       //     ],
       //   )
       // ),
      ]
       );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categorias.length;

  @override
  int get selectedRowCount => 0;

}