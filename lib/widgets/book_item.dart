import "package:flutter/material.dart";

class BookItem extends StatelessWidget {
  final String title;
  final String penulis;
  final String kategori;

  BookItem({
      required this.title, 
      required this.penulis, 
      required this.kategori
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(kategori, style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 5,),
          Text(title, style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 5,),
          Text(penulis, style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold
          ),),
        ],),
      ),
    );
  }
}