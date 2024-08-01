import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/datatables/products_datasource.dart';
import 'package:web_dashboard/providers/products_provider.dart';

import 'package:web_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';
import 'package:web_dashboard/ui/modals/product_modal.dart';


class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {

    final productos = Provider.of<ProductsProvider>(context).productos;


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Products', style: CustomLabels.h1,),

          const SizedBox(height: 10),

        PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('Code'),),
                DataColumn(label: Text('Description'),),
                DataColumn(label: Text('Stock'),),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Categorie')),
                DataColumn(label: Text('Actions')),                
              ], 
              source: ProductsDTS(productos, context,),
              header: const  Text( ' List of Products', maxLines: 2),
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: (){
                   showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ProductModal(producto: null);
                              },
                            );
                  }, 
                  text:'Create', 
                  icon: Icons.add_outlined)
              ],
              )
        ],
      )
    );
  }
}