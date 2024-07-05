import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_dashboard/gps/blocs/blocs.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';
import 'dart:async';
import 'dart:html' as html;

class GpsScreen extends StatefulWidget {
  const GpsScreen({super.key});

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  late LocationBloc locationBloc;
  Completer<void> _googleMapsCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();

    // Verifica si el script de Google Maps ya está presente
    final googleMapsScript = html.document.querySelector(
        'script[src*="https://maps.googleapis.com/maps/api/js"]');
    if (googleMapsScript != null) {
      _googleMapsCompleter.complete();
    } else {
      // Observa cuando se agregue el script de Google Maps
      html.document.head!.children
          .whereType<html.ScriptElement>()
          .firstWhere(
            (script) =>
                script.src.contains('https://maps.googleapis.com/maps/api/js'),
            orElse: () => throw Exception('Google Maps script not found!'),
          )
          .onLoad
          .listen((event) {
        _googleMapsCompleter.complete();
      });
    }
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _googleMapsCompleter.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading Google Maps: ${snapshot.error}'));
          } else {
            return BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state.lastKnowLocation == null) {
                  return const Center(child: Text('Wait Please ...'));
                }

                final CameraPosition initialCameraPosition = CameraPosition(
                  target: state.lastKnowLocation!,
                  zoom: 15,
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
              },
            );
          }
        },
      ),
    );
  }
}

        
      
  