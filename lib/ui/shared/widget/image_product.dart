import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:web_dashboard/models/products.dart';

import 'package:web_dashboard/providers/products_provider.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';


class ImageProduct extends StatefulWidget {
final Producto? producto;


  const ImageProduct({super.key, this.producto});

  @override
  State<ImageProduct> createState() => ImageProductState();
}

class ImageProductState extends State<ImageProduct> {
  Producto? get producto => widget.producto;
  
  @override
  Widget build(BuildContext context) {
   

    final productProvider = Provider.of<ProductsProvider>(context);

    final image = (producto!.img == null 
    ?  const Image(image: AssetImage('noimage.jpeg')) 
    :  FadeInImage.assetNetwork(placeholder: 'load.gif', image: producto!.img!)
    ) ;
    

    return WhiteCard(
      width: 250,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                   ClipOval(
                    child:image),

                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(100),
                         border: Border.all( color: Colors.white, width: 5)
                        ),
                        child:FloatingActionButton(
                          backgroundColor: const Color.fromRGBO(177, 255, 46, 100),
                          elevation: 0,
                          child: const Icon(Icons.camera_alt_outlined, size: 20),
                          onPressed: () async {
                             FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                              allowMultiple: false,
                                );
                              if (result != null) {
                              if (producto != null) {
                              NotificationService.showBusyIndicator(context);
                              final resp = await productProvider.uploadImage('/uploads/productos/${producto!.id}',result.files.first.bytes!,);
                              Navigator.of(context).pop();
                            } else {
                              //TODO: SnackBar: Error al cargar imagen
                            }
                          }}),
                      ),
                    )
                ],
              )
            ),
            const SizedBox( height: 20),


          ],
        ),

      ));
  }
}


