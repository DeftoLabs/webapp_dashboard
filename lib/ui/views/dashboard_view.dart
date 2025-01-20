import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/views/dashboard/order_status_donut_chart.dart';

import '../../providers/providers.dart';



class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Actualizar los datos y forzar la reconstrucción del widget
    Provider.of<OrdenesProvider>(context, listen: false).getOrderStatusCountForToday();
    setState(() {}); // Esto forzará la reconstrucción del widget para reflejar los cambios.
  }

  
  @override
  Widget build(BuildContext context) {

    final activeUser = Provider.of<AuthProvider>(context).user!;

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          if(activeUser.rol == 'ADMIN_ROLE' || activeUser.rol == 'MASTER_ROLE')
          WhiteCard(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: OrderStatusDonutChart()
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
                      top:5,
                      right: 5,
                      child:               
                    SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipOval(
                          child: image,
                        ),
                      ),),
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
                      top:5,
                      right: 5,
                      child:               
                    SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipOval(
                          child: image,
                        ),
                      ),),
                    Positioned(
                      top:20,
                      left: 20,
                      child: Text('DAILY RESUME', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold))),
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