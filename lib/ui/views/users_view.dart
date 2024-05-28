
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

    String _selectedOption = 'active';
    List<String> _options = ['active', 'inactive'];
    

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
                  decoration: BoxDecoration(
                    color: Colors.indigo[500],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: (){}, 
                    icon: const Icon(Icons.person_add_alt_1, color: Colors.white,)),
                ),
              ),
              const SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child:              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber[100],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                              value: _selectedOption,
                              onChanged: (String? newValue) {
                  
                              },
                        items: _options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(child: Text(value)),
                  );
                              }).toList(),
                  dropdownColor: Colors.amber[100],
                  borderRadius: BorderRadius.circular(20),
                              ),
                ),
              ),
              )

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

              const DataColumn(label: Text('Phone')),

              DataColumn(label: const Text('Zone'), onSort: (colIndex, _) {
                userProvider.sortColumnIndex = colIndex;
                userProvider.sort((user) => user.zone!);
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