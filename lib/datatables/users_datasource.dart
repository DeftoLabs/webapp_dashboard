import 'package:flutter/material.dart';
import 'package:web_dashboard/models/usuaro.dart';

class UserDatasource extends DataTableSource {

  final List<Usuario> users;

  UserDatasource(this.users);



  @override
  DataRow getRow(int index) {

    final Usuario user = users[index];

    const image = Image( image: AssetImage('noimage.jpeg'), width: 35, height: 35,);

    return DataRow.byIndex(
      index: index,
      cells: [
          DataCell(
            ClipOval (child: image,)
           ),
          DataCell(Text( user.nombre)),
          DataCell(Text( user.correo)),
          DataCell(Text( user.phone!)),
          DataCell(Text( user.zone!)),
          DataCell(
            IconButton(icon: const Icon(Icons.edit_outlined),
            onPressed: (){},)
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