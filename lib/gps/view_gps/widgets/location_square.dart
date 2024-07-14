import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:web_dashboard/gps/blocs/blocs.dart';
import 'package:web_dashboard/providers/users_providers.dart';

class LocationSquare extends StatefulWidget {
  const LocationSquare({
    Key? key,
    required this.containerWidth,
    required this.containerHeight,
  }) : super(key: key);

  final double containerWidth;
  final double containerHeight;

  @override
  State<LocationSquare> createState() => _LocationSquareState();
}

class _LocationSquareState extends State<LocationSquare> {
  bool _isExpanded = false;
  int _currentPage = 0;
  final int _itemsPerPage = 4;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.getPaginatedUsers();
  }

  void _nextPage() {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    if ((_currentPage + 1) * _itemsPerPage < userProvider.users.length) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  Future<String> _getAddress(double lat, double lng) async {
    final apiKey = dotenv.env['MAPBOXKEY'];
    final url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['features'] != null && json['features'].isNotEmpty) {
        return json['features'][0]['place_name'];
      } else {
        throw Exception('Error to get address: No results found');
      }
    } else {
      throw Exception('Error to connect to the server');
    }
  }


  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsersProvider>(context);
    final users = userProvider.users;
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (_currentPage + 1) * _itemsPerPage;
    final paginatedUsers = users.sublist(
      startIndex,
      endIndex > users.length ? users.length : endIndex,
    );

    return Positioned(
      top: 10,
      right: 30,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Container(
          width: widget.containerWidth,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(177, 255, 46, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Center(child: Text('Sales Representative', style: TextStyle(fontWeight: FontWeight.bold))),
                trailing: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ),
              if (_isExpanded)
                SizedBox(
                  height: widget.containerHeight,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: paginatedUsers.length,
                          itemBuilder: (context, index) {
                            final user = paginatedUsers[index];
                            return FutureBuilder<String>(
                              future: _getAddress(user.location!.lat, user.location!.lng),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return ListTile(
                                    title: Text(user.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: const Text('Loading...'),
                                  );
                                } else if (snapshot.hasError) {
                                  return ListTile(
                                    title: Text(user.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: Text('Error: ${snapshot.error}'),
                                  );
                                } else {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                             backgroundColor: Colors.white,
                                             maxRadius: 15,
                                              child: IconButton(
                                                iconSize: 15,
                                                onPressed: (){
                                                  
                                                 }, 
                                                icon: const Icon(Icons.my_location_outlined)),
                                            ),
                                            Text(user.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        const SizedBox(height: 10)
                                      ],
                                    ),
                                    subtitle: Text(snapshot.data ?? 'No address available'),
                                  );
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: widget.containerWidth * 0.7,
                            child: const Divider(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _previousPage,
                  ),
                  Text('Page ${_currentPage + 1}'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _nextPage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
