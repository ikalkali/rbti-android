import "package:flutter/material.dart";

class SearchBar extends StatelessWidget {
  final String label;

  SearchBar(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: TextField(
        autofocus: false,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            labelText: label,
            border: InputBorder.none),
      ),
    );
  }
}
