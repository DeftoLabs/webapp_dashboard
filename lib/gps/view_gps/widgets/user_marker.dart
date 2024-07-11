import 'package:flutter/material.dart';

class UserMarker extends StatefulWidget {

  final double lat;
  final double lng;

  const UserMarker({
    super.key, 
    required this.lat, 
    required this.lng});

  @override
  State<UserMarker> createState() => _UserMarkerState();
}

class _UserMarkerState extends State<UserMarker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: const BoxDecoration(
         color: Colors.red,
          shape: BoxShape.circle),
    );
  }
}