import 'package:flutter/material.dart';
import 'package:web_dashboard/models/usuario.dart';
import 'package:web_dashboard/services/navigation_service.dart';


class UserDatasource extends DataTableSource {

  final List<Usuario> users;

  UserDatasource(this.users);



  @override
  DataRow getRow(int index) {

    final Usuario user = users[index];

    final image = (user.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35,) 
    : FadeInImage.assetNetwork(
      placeholder: 'load.gif', 
      image: user.img!, width: 35, height: 35,);

    return DataRow.byIndex(
      index: index,
      cells: [
          DataCell(
            ClipOval (child: image,)
           ),
          DataCell(Text( user.nombre)),
          DataCell(Text( user.correo)),
          DataCell(Text( user.phone)),
          DataCell(Text( user.zone)),
          DataCell(Text(
            user.rol == 'USER_ROLE' ? 'Sales Rep' : user.rol == 'ADMIN_ROLE' ? 'Admin' : user.rol)),
          DataCell(
            IconButton(icon: const Icon(Icons.edit_outlined),
            onPressed: (){
              NavigationService.replaceTo('/dashboard/users/${user.uid}');
            },)
          ),

        ]
      );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;


}