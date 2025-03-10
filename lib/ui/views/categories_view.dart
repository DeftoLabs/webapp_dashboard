import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';

import 'package:web_dashboard/providers/categories_provider.dart';

import 'package:web_dashboard/datatables/categories_datasource.dart';
import 'package:web_dashboard/providers/profile_provider.dart';

import 'package:web_dashboard/ui/buttons/custom_icon_button.dart';
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

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    final localization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
                    const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded
              (child: Text(localization.categorys, style: GoogleFonts.plusJakartaSans(fontSize: 22),)),
              const SizedBox(width: 50),
              SizedBox(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: image,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10),
        PaginatedDataTable(
              sortAscending: categoriasProvider.ascending,
              sortColumnIndex: categoriasProvider.sortColumnIndex,
              columns:[
                DataColumn(label: Expanded(child: Text(localization.categorys)), onSort:(colIndex, _) {
                  categoriasProvider.sortColumnIndex = colIndex;
                  categoriasProvider.sort((categorias) => categorias.nombre);
                }),
                DataColumn(label: Text(localization.createby, textAlign: TextAlign.right), numeric: true),
                DataColumn(label: Text(localization.edit, textAlign: TextAlign.right), numeric: true),                
              ], 
              source: CategoriesDTS(categorias, context),
              header: const Text(''),
              onPageChanged: ( page ) {

            },
              actions: [
              //  if (activeUser.rol == 'MASTER_ROL') 
                  CustomIconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CategoryModal(categoria: null);
                        },
                      );
                    },
                    text: localization.createcaterory,
                    icon: Icons.add_outlined,
                  ),
              ],
              )
        ],
      )
    );
  }
}