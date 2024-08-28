

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/profile.dart';

class ProfileDTS extends DataTableSource {

  final List<Profile> profiles;

  ProfileDTS(this.profiles);

  
  @override
  DataRow getRow(int index) {

    final profile = profiles[index];

    const image = Image(image: AssetImage('noimage.jpeg'), width: 50, height: 50,);

    return DataRow.byIndex(
      index:index,
      cells: [
        DataCell(Container(
          decoration: BoxDecoration(
            shape:BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 2,
            )
          ),
          child: const ClipOval(child: image))),

         DataCell(Text(profile.razons)),
         DataCell(Text(profile.idfiscal)),
         DataCell(
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: (){},
            )
         ), 
      ]);

  }
  
  @override
  bool get isRowCountApproximate => false;
  
  @override

  int get rowCount => profiles.length;
  
  @override
  int get selectedRowCount => 0;

  
}