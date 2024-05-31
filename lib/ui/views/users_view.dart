
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

    final activeUsers = userProvider.users.where((user) => user.estado).toList();

    final userDataSource = UserDatasource( activeUsers );


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Row(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Users View', style: CustomLabels.h1,),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    color:  Color.fromRGBO(40, 41, 38, 0.808),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: (){}, 
                    icon: const Icon(Icons.person_add_alt_1, color: Colors.white,)),
                ),
              ),
              const SizedBox(width: 10,),
            ],
          ),

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

              DataColumn(label: const Text('Phone'), onSort: (colIndex, _) {
                userProvider.sortColumnIndex = colIndex;
                userProvider.sort((user) => user.phone);
              }),

              DataColumn(label: const Text('Zone'), onSort: (colIndex, _) {
                userProvider.sortColumnIndex = colIndex;
                userProvider.sort((user) => user.zone);
              }),

              DataColumn(label: const Text('Rol'), onSort: (colIndex, _) {
                userProvider.sortColumnIndex = colIndex;
                userProvider.sort((user) => user.rol);
              }),


              const DataColumn(label: Text('Update'),
              ),                
            ], 
            
            source: userDataSource,
            onPageChanged: ( page ) {

            },
            ),
        ],
      ),
      
    );
  }
}