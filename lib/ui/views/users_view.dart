
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:web_dashboard/datatables/users_datasource.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsersProvider>(context);

    final userDataSource = UserDatasource( userProvider.users);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Users View', style: CustomLabels.h1,),

          const SizedBox(height: 10),

          PaginatedDataTable(
            sortAscending: userProvider.ascending,
            sortColumnIndex: userProvider.sortColumnIndex,
            columns: [
              const DataColumn(label: Text('Avatar')),
              DataColumn(label:const Text('Name'), onSort: (colIndex, _) {
                userProvider.sortColumnIndex = colIndex;
                userProvider.sort((user) => user.nombre);
              }),
              DataColumn(label:const Text('Email'), onSort: (colIndex, _) {
                userProvider.sortColumnIndex = colIndex;
                userProvider.sort((user) => user.correo);
              }),
              const DataColumn(label: Text('Phone')),
              DataColumn(label: const Text('Zone'), onSort: (colIndex, _) {
                userProvider.sortColumnIndex = colIndex;
                userProvider.sort((user) => user.zone!);
              }),
              const DataColumn(label: Text('Update'),
              ),                
            ], 
            
            source: userDataSource,
            onPageChanged: ( page ) {

            },
            ),
        ],
      )
    );
  }
}