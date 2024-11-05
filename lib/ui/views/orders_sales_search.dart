  
  
import 'package:flutter/material.dart';

class OrdersSalesSearch extends StatelessWidget {
  const OrdersSalesSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(child: Text('SALES'),);
  }
}
  
  
  
  //Row(
  //            mainAxisAlignment: MainAxisAlignment.center,
  //            children: [
  //              Text('Search Options',
  //                  style: GoogleFonts.plusJakartaSans(
  //                      fontSize: 14, fontWeight: FontWeight.bold))
  //            ],
  //          ),
  //          const SizedBox(height: 20),
  //          Container(
  //              height: 260,
  //              color: Colors.white,
  //              child: Column(
  //                children: [
  //                  const SizedBox(height: 20),
  //                  const Text('Search by Sales Representative'),
  //                  const SizedBox(height: 20),
  //                  Row(
  //                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                    children: [
  //                      ElevatedButton(
  //                          onPressed: () async {
  //                            DateTime? picked = await showDatePicker(
  //                                context: context,
  //                                initialDate: DateTime.now(),
  //                                firstDate: DateTime(2020),
  //                                lastDate: DateTime(2040));
  //                            if (picked != null && picked != selectedDate) {
  //                              setState(() {
  //                                selectedDate = picked;
  //                              });
  //                            }
  //                          },
  //                          child: Text(selectedDate != null
  //                              ? DateFormat('yyy-MM-dd').format(selectedDate!)
  //                              : 'Select Date')),
  //                      DropdownButton<String>(
  //                          value: selectedStatus,
  //                          hint: const Text('Select Status'),
  //                          items: statusOptions.map((String value) {
  //                            return DropdownMenuItem<String>(
  //                                value: value, child: Text(value));
  //                          }).toList(),
  //                          onChanged: (newValue) {
  //                            setState(() {
  //                              selectedStatus = newValue;
  //                            });
  //                          }),
  //                      SizedBox(
  //                        width: 400,
  //                        child: Consumer<OrdenesProvider>(
  //                          builder: (context, ordenesProvider, child) {
  //                            if (ordenesProvider.ordenes.isEmpty) {
  //                              return const Text('No Orders Available');
  //                            }
//
  //                            // Obtener usuarios sin duplicados
  //                            List<String> usuariosZona = ordenesProvider
  //                                .ordenes
  //                                .map((orden) =>
  //                                    orden.ruta.first.usuarioZona.nombre)
  //                                .toSet()
  //                                .toList();
//
  //                            return DropdownButton<String>(
  //                              value: selectedSales,
  //                              hint: const Text(
  //                                  'Sales Representative'), // Texto sugerido
  //                              items: usuariosZona.map((nombre) {
  //                                return DropdownMenuItem<String>(
  //                                  value: nombre,
  //                                  child: Text(nombre),
  //                                );
  //                              }).toList(),
  //                              onChanged: (newValue) {
  //                                setState(() {
  //                                  selectedSales = newValue;
  //                                });
  //                              },
  //                            );
  //                          },
  //                        ),
  //                      ),
  //                      IconButton(
  //                          onPressed: () {}, icon: const Icon(Icons.search)),
  //                    ],
  //                  ),
  //                  const SizedBox(height: 10),
  //                  Column(
  //                    children: [
  //                      const SizedBox(height: 20),
  //                      const Text('Search by Customer'),
  //                      const SizedBox(height: 20),
  //                      Row(
  //                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                        children: [
  //                          ElevatedButton(
  //                              onPressed: () async {
  //                                DateTime? picked = await showDatePicker(
  //                                    context: context,
  //                                    initialDate: DateTime.now(),
  //                                    firstDate: DateTime(2020),
  //                                    lastDate: DateTime(2040));
  //                                if (picked != null &&
  //                                    picked != selectedDate) {
  //                                  setState(() {
  //                                    selectedDate = picked;
  //                                  });
  //                                }
  //                              },
  //                              child: Text(selectedDate != null
  //                                  ? DateFormat('yyy-MM-dd')
  //                                      .format(selectedDate!)
  //                                  : 'Select Date')),
  //                          DropdownButton<String>(
  //                              value: selectedStatus,
  //                              hint: const Text('Select Status'),
  //                              items: statusOptions.map((String value) {
  //                                return DropdownMenuItem<String>(
  //                                    value: value, child: Text(value));
  //                              }).toList(),
  //                              onChanged: (newValue) {
  //                                setState(() {
  //                                  selectedStatus = newValue;
  //                                });
  //                              }),
  //                          SizedBox(
  //                            width: 400,
  //                            child: Consumer<OrdenesProvider>(
  //                              builder: (context, ordenesProvider, child) {
  //                                if (ordenesProvider.ordenes.isEmpty) {
  //                                  return const Text('No Orders Available');
  //                                }
//
  //                                // Obtener usuarios sin duplicados
  //                                List<String> clientes = ordenesProvider
  //                                    .ordenes
  //                                    .where(
  //                                        (orden) => orden.clientes.isNotEmpty)
  //                                    .map((orden) =>
  //                                        orden.clientes.first.nombre)
  //                                    .toSet()
  //                                    .toList();
//
  //                                return DropdownButton<String>(
  //                                  value: selectedClient,
  //                                  hint: const Text(
  //                                      'Select Client'), // Texto sugerido
  //                                  items: clientes.map((nombre) {
  //                                    return DropdownMenuItem<String>(
  //                                      value: nombre,
  //                                      child: Text(nombre),
  //                                    );
  //                                  }).toList(),
  //                                  onChanged: (newValue) {
  //                                    setState(() {
  //                                      selectedClient = newValue;
  //                                    });
  //                                  },
  //                                );
  //                              },
  //                            ),
  //                          ),
  //                          IconButton(
  //                              onPressed: () {},
  //                              icon: const Icon(Icons.search)),
  //                        ],
  //                      ),
  //                      const SizedBox(height: 20),
  //                    ],
  //                  ),
  //                ],
  //              )),
  //          const SizedBox(height: 20),