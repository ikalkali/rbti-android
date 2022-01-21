import "package:flutter/material.dart";

class SearchBar extends StatelessWidget {
  final String label;
  final Function submitHandler;

  SearchBar(this.label, this.submitHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: TextField(
        autofocus: false,
        onSubmitted: (String value) {
          submitHandler(value);
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: label,
            border: InputBorder.none),
      ),
    );
  }
}
