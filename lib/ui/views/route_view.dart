
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/zona.dart';
import 'package:web_dashboard/providers/routes_providers.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class RouteView extends StatefulWidget {

  final String id;

  const RouteView({super.key, required this.id});

  @override
  State<RouteView> createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> {

  Zona? zona;

  @override
  void initState() {
    super.initState();
    final routesProvider = Provider.of<RoutesProviders>(context, listen: false);

    routesProvider.getZonasById(widget.id).then((zonaDB) => setState(() {
      zona = zonaDB;
    }));
  }

  @override
  Widget build(BuildContext context) {

        if (zona == null) {
      return const Center(
        child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 4.0),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Route View', style: CustomLabels.h1,),

          const SizedBox(height: 10),
      
      WhiteCardColor(
        title: 'Test',
        child: Container(),
        ),
        ],
      ),
    );
  }
}