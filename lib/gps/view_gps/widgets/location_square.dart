import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/users_providers.dart';

class LocationSquare extends StatefulWidget {
  const LocationSquare({
    super.key,
    required this.containerWidth,
    required this.containerHeigth,
  });

  final double containerWidth;
  final double containerHeigth;

  @override
  State<LocationSquare> createState() => _LocationSquareState();
}

class _LocationSquareState extends State<LocationSquare> {

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.getPaginatedUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);

    return Positioned(
      top: 10,
      right: 30,
      child: Container(
        width: widget.containerWidth,
        height: widget.containerHeigth,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(177, 255, 46, 100),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListView.builder(
          itemCount: userProvider.users.length,
          itemBuilder: (context, index) {
            final user = userProvider.users[index];
            // Convertir location a una cadena para mostrarla en el ListTile
            final locationString = user.location != null
                ? 'Lat: ${user.location!.lat}, Lng: ${user.location!.lng}'
                : 'No location available';
            return ListTile(
              title: Text(user.nombre),
              subtitle: Text(locationString),
            );
          },
        ),
      ),
    );
  }
}
