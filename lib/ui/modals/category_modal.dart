import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/categories.dart';
import 'package:web_dashboard/providers/categories_provider.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/inputs/custom_inputs.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class CategoryModal extends StatefulWidget {

  final Categoria? categoria;

  const CategoryModal({
    super.key, 
    this.categoria});

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {

String nombre = '';
String? id;

@override
  void initState() {
    super.initState();

    nombre = widget.categoria?.nombre ?? '';
    id = widget.categoria?.id;
 
  }

  @override
  Widget build(BuildContext context) {

    final categoryProvider = Provider.of<CategoriesProvier>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.categoria?.nombre ?? 'Add Category', style: CustomLabels.h1.copyWith(color:Colors.white)),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white,),
                onPressed: () => Navigator.of(context).pop() )
            ]
          ),
          Divider(color: Colors.white.withOpacity(0.3)),

          const SizedBox(height: 20),

          TextFormField(
            initialValue: widget.categoria?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInput.loginInputDecoration(
              hint: 'Category Name', 
              label: 'Category', 
              icon: Icons.new_releases_outlined),
              style: GoogleFonts.plusJakartaSans(color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top:30),
            alignment: Alignment.center,
            child: CustomOutlineButtom(
              onPressed:() async {
                if(id == null) {
                  await categoryProvider.newCategory(nombre);

                }else {
                  await categoryProvider.updateCategory(id!, nombre);
                }
                Navigator.of(context).pop();
              },
              text: 'Save',
              color: Colors.white
              )
          )
        ],
      )
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: Color(0xff0F2041),
    boxShadow:[
      BoxShadow( color: Colors.black26)
    ]
  );
}