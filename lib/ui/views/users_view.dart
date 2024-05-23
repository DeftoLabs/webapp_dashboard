
import 'package:flutter/material.dart';


import 'package:web_dashboard/datatables/users_datasource.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {

    final userDataSource = UserDatasource();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Users View', style: CustomLabels.h1,),

          const SizedBox(height: 10),

          PaginatedDataTable(
            columns: [
              DataColumn(label: Text('Avatar')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Zone')),
              DataColumn(label: Text('Update')),                
            ], 
            
            source: userDataSource),
        ],
      )
    );
  }
}