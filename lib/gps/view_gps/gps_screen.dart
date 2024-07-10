import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/gps/blocs/blocs.dart';
import 'package:web_dashboard/gps/view_gps/screen_gps.dart';
import 'package:web_dashboard/providers/users_providers.dart';
import 'package:web_dashboard/ui/views/dashboard_view.dart';


class GpsScreen extends StatefulWidget {
  const GpsScreen({super.key});

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  late LocationBloc locationBloc;
  Completer<void> _googleMapsCompleter = Completer<void>();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();

    final googleMapsScript = html.document.querySelector(
        'script[src*="https://maps.googleapis.com/maps/api/js"]');
    if (googleMapsScript != null) {
      _googleMapsCompleter.complete();
    } else {
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
    _mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _addUserMarkers();
  }

  void _addUserMarkers() {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    final users = userProvider.users;
    setState(() {
      _markers.clear();
      for (var user in users) {
        if (user.location != null) {
          final marker = Marker(
            markerId: MarkerId(user.uid),
            position: LatLng(user.location!.lat, user.location!.lng),
            infoWindow: InfoWindow(title: user.nombre, snippet: user.correo),
          );
          _markers.add(marker);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final containerWidth = screenWidth * 0.20;
    final containerHeigth = screenHeight * 0.6;

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

                return Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(state.lastKnowLocation!.latitude, state.lastKnowLocation!.longitude),
                        zoom: 15,
                      ),
                      markers: _markers,
                    ),
                    LocationSquare(containerWidth: containerWidth, containerHeigth: containerHeigth),
                      Positioned(
                            left:16,
                            bottom: 130,
                            child: FloatingActionButton.extended(
                              label: const Text('Back'),
                              icon: const  Icon(Icons.arrow_back),
                              backgroundColor: const Color.fromRGBO(177, 255, 46, 100),
                              onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const DashboardView() ));
                            },
                            )
                            ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}



  