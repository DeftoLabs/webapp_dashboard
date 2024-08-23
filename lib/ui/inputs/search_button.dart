import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final Function(String) onSearch; // Función que se llama al buscar

  const SearchButton({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200, 
        borderRadius: BorderRadius.circular(10), 
      ),
      child: TextField(
        onSubmitted: onSearch, 
        decoration: const InputDecoration(
          hintText: 'Search',
          hintStyle:  TextStyle(color: Colors.black), 
          border: InputBorder.none, // Sin borde
          prefixIcon:  Icon(Icons.search, color: Colors.black), 
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), 
        ),
      ),
    );
  }
}