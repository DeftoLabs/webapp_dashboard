
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_dashboard/gps/blocs/blocs.dart';


import 'package:web_dashboard/ui/labels/custom_labels.dart';


class GpsScreen extends StatefulWidget {
  const GpsScreen({super.key});

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<LocationBloc, LocationState>(
          builder:(context, state) {
            if( state.lastKnowLocation == null) return const Center(child: Text('Wait Please ...'));

        final CameraPosition initialCameraPosition = CameraPosition(
        target: state.lastKnowLocation!,
        zoom: 15
        );

        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Text('GPS View', style: CustomLabels.h1),
                const SizedBox(height: 10),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: initialCameraPosition,
              ),
            ),
              ],
            ),
        );  
          } ,)



    );
  }
}

 
        
      
  