import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final productsProvider = Provider.of<ProductsProvider>(context);
    final productDataSource = ProductsDTS(productsProvider.productos, context);


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
           Row(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Products', style: CustomLabels.h1,),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color.fromRGBO(177, 255, 46, 100), 
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 0.6,
                  )
                  ),
                  
                  child: TextButton.icon(
                    label: Text('PDF List', style: GoogleFonts.plusJakartaSans(color: const Color.fromARGB(255, 0, 0, 0)),) ,
                    onPressed: (){
                      //TODO Create .pdf list
                    }, 
                    icon: const Icon(Icons.share, color: Color.fromARGB(255, 0, 0, 0),)),
                ),
              ),
              const SizedBox(width: 10,),
            ],
          ),

          const SizedBox(height: 10),

        PaginatedDataTable(
              sortAscending: productsProvider.ascending,
              sortColumnIndex: productsProvider.sortColumnIndex,

              columns: [
                const DataColumn(label: Text('Image'),),

                const DataColumn(label: Text('Code'),),

                DataColumn(label: const Text('Description'), onSort: ( colIndex, _) {
                  productsProvider.sortColumnIndex = colIndex;
                  productsProvider.sort((producto) => producto.descripcion.toString());
                }),
                DataColumn(label: const Text('Stock'), onSort:  ( colIndex, _) {
                  productsProvider.sortColumnIndex = colIndex;
                  productsProvider.sort((producto) => producto.disponible.toString());
                }),
                DataColumn(label: const Text('Price'), onSort:  ( colIndex, _) {
                  productsProvider.sortColumnIndex = colIndex;
                  productsProvider.sort((producto) => producto.precio);
                }),
                DataColumn(label: const Text('Categorie'), onSort: (colIndex, _) {
                //  productsProvider.sortColumnIndex = colIndex;
                //  productsProvider.sort((producto) => producto.categoria.toString());
                }),


                const DataColumn(label: Text('Actions')),                
              ], 
              source: productDataSource,
              header: const  Text( ' List of Products', maxLines: 2),
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              actions: [
                IconButton(onPressed: (){}, icon:const Icon(Icons.search)),
                const SizedBox(width: 20,),
                CustomIconButton(
                  onPressed: (){
                   showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ProductModal(producto: null);
                              },
                            );
                  }, 
                  text:'Create New Product', 
                  icon: Icons.add_outlined)
              ],
              )
        ],
      )
    );
  }
}