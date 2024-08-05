import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/categories.dart';
import 'package:web_dashboard/providers/categories_provider.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class CategoryModal extends StatefulWidget {
  final Categoria? categoria;

  const CategoryModal({super.key, this.categoria});

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

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 300,
        width: 600, 
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:  const Color.fromARGB(255, 58, 60, 65),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.categoria?.nombre ?? 'Add Category',
                  style: CustomLabels.h1.copyWith(color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: Colors.white70),

            const SizedBox(height: 40),

             TextFormField(
              initialValue: widget.categoria?.nombre ?? '',
              onChanged: (value) => nombre = value,
              decoration: InputDecoration(
                hintText: 'Category Name',
                labelText: 'Category',
                labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
                hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white.withOpacity(0.7)),
                focusedBorder:const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(177, 255, 46, 100), width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
              style: GoogleFonts.plusJakartaSans(color: Colors.white),
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              child: CustomOutlineButtom(
                onPressed: () async {
                  try {
                    if (id == null) {
                      await categoryProvider.newCategory(nombre);
                      NotificationService.showSnackBa('$nombre Created');
                    } else {
                      await categoryProvider.updateCategory(id!, nombre);
                      NotificationService.showSnackBa('$nombre Updated');
                    }
                    if(!context.mounted) return;
                    Navigator.of(context).pop();
                  } catch (e) {
                    if (mounted) NotificationService.showSnackBa('Could not save the category');
                    if (mounted) Navigator.of(context).pop();
                  }
                },
                text: 'Save',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
