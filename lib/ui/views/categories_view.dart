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

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvier>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {

    final categorias = Provider.of<CategoriesProvier>(context).categorias;
    final categoriasProvider = Provider.of<CategoriesProvier>(context);

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
              header: const  Text( ' Categories', maxLines: 2),
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
                                return const CategoryModal(categoria: null);
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