
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import 'package:web_dashboard/datatables/users_datasource.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.getPaginatedUsers();
  }

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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color.fromRGBO(177, 255, 46, 100), 
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 0.6
                  )
                  ),
                  
                  child: TextButton.icon(
                    label: Text('Add a New User', style: GoogleFonts.plusJakartaSans(color: const Color.fromARGB(255, 0, 0, 0)),) ,
                    onPressed: (){
                     NavigationService.replaceTo('dashboard/users/newuser');
                   
                    }, 
                    icon: const Icon(Icons.person_add_alt_1, color: Color.fromARGB(255, 0, 0, 0),)),
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

              DataColumn(label: const Text('Code'), onSort: (colIndex, _) {
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