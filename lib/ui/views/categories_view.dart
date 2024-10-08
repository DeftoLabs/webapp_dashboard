import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/providers/categories_provider.dart';

import 'package:web_dashboard/datatables/categories_datasource.dart';

import 'package:web_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';
import 'package:web_dashboard/ui/modals/category_modal.dart';


class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {

    final categorias = Provider.of<CategoriesProvider>(context).categorias;
    final categoriasProvider = Provider.of<CategoriesProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Categories', style: CustomLabels.h1,),
          const SizedBox(height: 10),

        PaginatedDataTable(
              sortAscending: categoriasProvider.ascending,
              sortColumnIndex: categoriasProvider.sortColumnIndex,
              columns:[
                DataColumn(label: const Expanded(child: Text('Categories')), onSort:(colIndex, _) {
                  categoriasProvider.sortColumnIndex = colIndex;
                  categoriasProvider.sort((categorias) => categorias.nombre);
                }),
                const DataColumn(label: Text('Create by', textAlign: TextAlign.right), numeric: true),
                const DataColumn(label: Text('Actions', textAlign: TextAlign.right), numeric: true),                
              ], 
              source: CategoriesDTS(categorias, context),
              header: const  Text( '', maxLines: 2),
              onPageChanged: ( page ) {

            },
              actions: [
                CustomIconButton(
                  onPressed: (){
                   showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CategoryModal(categoria: null);
                              },
                            );
                  }, 
                  text:'Create a Category', 
                  icon: Icons.add_outlined)
              ],
              )
        ],
      )
    );
  }
}