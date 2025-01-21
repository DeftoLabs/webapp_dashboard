import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/views/dashboard/dashboard.dart';




import '../../providers/providers.dart';



class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  
  @override
  Widget build(BuildContext context) {

    final activeUser = Provider.of<AuthProvider>(context).user!;

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          if(activeUser.rol == 'ADMIN_ROLE' || activeUser.rol == 'MASTER_ROLE')
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 90,
                                  decoration: BoxDecoration(
                                     gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF0F2027), 
                                        Color(0xFF2C5364), 
                                        Color.fromRGBO(0, 200, 83, 1),
                                        Color.fromRGBO(177, 255, 46, 1),
                                      ],
                                      begin: Alignment.topLeft, 
                                      end: Alignment.bottomRight, 
                                    ),
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30),
                                      child: DashboardFirstRow()))
                                ),
                              ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 90,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(177, 255, 46, 1),
                                      Color.fromRGBO(0, 200, 83, 1),
                                      Color(0xFF2C5364),                                  
                                      Color(0xFF0F2027), 
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight
                                    ),
                                    borderRadius: BorderRadius.circular(30)
                                ),
                               child: const Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30),
                                      child: DashboardTwoRow()))
                              ),
                            ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 90,
                                  decoration: BoxDecoration(
                                      gradient:const LinearGradient(
                                      colors: [
                                        Color(0xFF0F2027), 
                                        Color(0xFF2C5364), 
                                        Color.fromRGBO(0, 200, 83, 1),
                                        Color.fromRGBO(177, 255, 46, 1),
                                      ],
                                      begin: Alignment.topLeft, // Inicio del degradado
                                      end: Alignment.bottomRight, // Fin del degradado
                                    ),
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                   child: const Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30),
                                      child: DashboardThreeRow()))
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 90,
                                  decoration: BoxDecoration(
                                      gradient:const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(177, 255, 46, 1),
                                      Color.fromRGBO(0, 200, 83, 1),
                                      Color(0xFF2C5364),                                  
                                      Color(0xFF0F2027), 
                                    ],
                                      begin: Alignment.topLeft, // Inicio del degradado
                                      end: Alignment.bottomRight, // Fin del degradado
                                    ),
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30),
                                      child: DashboardFourRow()))
                                ),
                              ),
                              
                            ],
                          ),
                        const SizedBox(height: 40),
                          Expanded(
                            child: Row(
                              children: [
                                const Flexible(
                                  child: WeeklyOrdersBarChart()
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.green, // Color para identificar la segunda sección
                                    child: const Center(child: Text("SALES x DAY By SR", style: TextStyle(color: Colors.white))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const Divider(),
                    Expanded(
                      child: Container(
                        color: Colors.green,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2, 
                              child: Container(
                                color: Colors.blue, // Color para identificar la segunda sección
                                child: const Center(child: Text("WEEK TOP 10 PRODUCT", style: TextStyle(color: Colors.white))),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.orange, // Color para identificar la tercera sección
                                child: const Center(child: Text("TOP 10 CUSTOMER", style: TextStyle(color: Colors.white))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: Container(
                        color: Colors.yellow, // Color para identificar la tercera parte
                        child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.red, // Color para identificar la primera sección
                                    child: const Center(child: Text("TOTAL ORDER VS STATUS VS MONEY ", style: TextStyle(color: Colors.white))),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.green, // Color para identificar la segunda sección
                                    child: const Center(child: Text("ORDER BY SALES VS MONEY", style: TextStyle(color: Colors.white))),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.blue, // Color para identificar la tercera sección
                                    child: const Center(child: Text("TOP 10 PRODUCT VS MONEY VS CANTIDAD", style: TextStyle(color: Colors.white))),
                                  ),
                                ),
                              ],
                            ),
                      ),
                    ),
                  ],
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: (){
          
                      },
                      backgroundColor: Colors.black,
                      child: const Icon(Icons.add, color: Colors.white,)
                    )
                    )
              ],
            ),
          )
          else 
          // SALES REPRESENTATIVE VIEW
            WhiteCard(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.80,
              child: Stack(
                children: [
                  Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.red, // Color para identificar la primera sección
                                      child: const Center(child: Text("ORDER STATUS", style: TextStyle(color: Colors.white))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.green, // Color para identificar la segunda sección
                                      child: const Center(child: Text("SALES x DAY By SR", style: TextStyle(color: Colors.white))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.blue, // Color para identificar la tercera sección
                                      child: const Center(child: Text("TOTAL ORDER", style: TextStyle(color: Colors.white))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.orange, // Color para identificar la cuarta sección
                                      child: const Center(child: Text("TOP 5 x DAY", style: TextStyle(color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      const Divider(),
                      Expanded(
                        child: Container(
                          color: Colors.green,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2, 
                                child: Container(
                                  color: Colors.blue, // Color para identificar la segunda sección
                                  child: const Center(child: Text("WEEK TOP 10 PRODUCT", style: TextStyle(color: Colors.white))),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.orange, // Color para identificar la tercera sección
                                  child: const Center(child: Text("TOP 10 CUSTOMER", style: TextStyle(color: Colors.white))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: Container(
                          color: Colors.yellow, // Color para identificar la tercera parte
                          child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.red, // Color para identificar la primera sección
                                      child: const Center(child: Text("TOTAL ORDER VS STATUS VS MONEY ", style: TextStyle(color: Colors.white))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.green, // Color para identificar la segunda sección
                                      child:const Center(child: Text("ORDER BY SALES VS MONEY", style: TextStyle(color: Colors.white))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.blue, // Color para identificar la tercera sección
                                      child: const Center(child: Text("TOP 10 PRODUCT VS MONEY VS CANTIDAD", style: TextStyle(color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      ),
                    ],
                    ),
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: (){

                        },
                        backgroundColor: Colors.black,
                        child: const Icon(Icons.add, color: Colors.white,)
                      )
                      )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}