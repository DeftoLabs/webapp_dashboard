import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/ui/views/dashboard_adminrole/dashboard.dart';

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
                // FIRST ROW
                Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 90,
                                  decoration: BoxDecoration(
                                     gradient: const LinearGradient(
                                      colors: [
                                       Color.fromARGB(255, 58, 60, 65),
                                       Color.fromARGB(255, 64, 68, 75),
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
                                       Color.fromARGB(255, 58, 60, 65),
                                       Color.fromARGB(255, 64, 68, 75),
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
                                       Color.fromARGB(255, 58, 60, 65),
                                       Color.fromARGB(255, 64, 68, 75),
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
                                       Color.fromARGB(255, 58, 60, 65),
                                       Color.fromARGB(255, 64, 68, 75),
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
                        const SizedBox(height: 10),
                        // SECOND ROW
                          Expanded(
                            child: Row(
                              children: [
                               Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                       color: const Color.fromARGB(255, 145, 148, 154),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                    child: const WeeklyOrdersBarChart(),
                                  ),
                                ),
                                 const SizedBox(width: 10),
                                   Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 58, 60, 65),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.only(right: 16, left: 16),
                                    child: const DashboardTop5ProductByDay()
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                    const SizedBox(height: 10),
                        // THIRD ROW
                          Expanded(
                            child: Row(
                              children: [
                                   Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 145, 148, 154),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.only(right: 16, left: 16),
                                    child: const StackedAreaChartWidget()
                                  ),
                                ),
                                 const SizedBox(width: 10),
                               Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                       color: const Color.fromARGB(255, 145, 148, 154),
                                      borderRadius: BorderRadius.circular(12), // Esquinas redondeadas
                                    ),
                                    padding: const EdgeInsets.all(16.0), // Padding opcional
                                    child: const SalesLineChart(),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Row(
                            children: [
                                   Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  const Color.fromARGB(255, 58, 60, 65),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.only(right: 16, left: 16, bottom: 5),
                                    child: const DashboardTop5CustomerByDay()
                                      ),
                                      
                                      ),
                                      const SizedBox(width: 10),
                                  Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 58, 60, 65),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.only(right: 16, left: 16, bottom: 5),
                                    child: const DashboardTop5CustomerByMonth()
                                      ),
                                      ),
                                      const SizedBox(width: 10),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 58, 60, 65),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.only(right: 16, left: 16),
                                    child: const DashboardTop5ProductByMonth()
                                      ),
                                      ),
                            ],
                          ),
                    ),
                    Container(
                      height: 20,
                    )
                  ],
                  ),
              Positioned(
                top: 90,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: const Color.fromRGBO(177, 255, 46, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //const Icon(Icons.add, color: Color.fromARGB(255, 145, 148, 154)),
                      //const SizedBox(height: 4), // Espaciado entre icono y texto
                      Text(
                        'IA',
                        style: GoogleFonts.plusJakartaSans(fontSize: 14,fontWeight: FontWeight.bold, color:const Color.fromARGB(255, 58, 60, 65),)
                      ),
                    ],
                  ),
                ),
              )

              ],
            ),
          )
          else 
          // SALES REPRESENTATIVE VIEW
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.85,
              child: Stack(
                children: [
                  Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 90,
                                    decoration: BoxDecoration(
                                       gradient: const LinearGradient(
                                        colors: [
                                       Color.fromARGB(255, 58, 60, 65),
                                       Color.fromARGB(255, 64, 68, 75),
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
                                        child: DashboardFirstRowUserRole()))
                                  ),
                                ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 90,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                       Color.fromARGB(255, 58, 60, 65),
                                       Color.fromARGB(255, 64, 68, 75),
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
                                        child: DashboardTwoRowUserRole()))
                                ),
                              ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 90,
                                    decoration: BoxDecoration(
                                        gradient:const LinearGradient(
                                        colors: [
                                       Color.fromARGB(255, 58, 60, 65),
                                       Color.fromARGB(255, 64, 68, 75),
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
                                        child: DashboardThreeRowUserRole()))
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 90,
                                    decoration: BoxDecoration(
                                        gradient:const LinearGradient(
                                      colors: [
                                       Color.fromARGB(255, 58, 60, 65),
                                       Color.fromARGB(255, 64, 68, 75),
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
                                        child: DashboardFourRowUserRole()))
                                  ),
                                ),
                                
                              ],
                            ),
                        const SizedBox(height: 20),
                           Expanded(
                            child: Row(
                              children: [
                               Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 145, 148, 154),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                    child: const WeeklyOrdersBarChartUserRole(),
                                  ),
                                ),
                                 const SizedBox(width: 10),
                                   Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 58, 60, 65),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.only(right: 16, left: 16),
                                    child: const DashboardTop5ProductByDayUserRole()
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                           const SizedBox(height: 10),
                           Expanded(
                            child: Row(
                              children: [
                               Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  const Color.fromARGB(255, 58, 60, 65),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                    child: const DashboardTop5CustomerByDayUserRole(),
                                  ),
                                ),
                                 const SizedBox(width: 10),
                                   Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  const Color.fromARGB(255, 145, 148, 154),
                                      borderRadius: BorderRadius.circular(12), 
                                    ),
                                    padding: const EdgeInsets.only(right: 16, left: 16),
                                    child: const SalesLineChartUserRole()
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
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
        ],
      )
    );
  }
}