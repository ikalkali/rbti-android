import "package:flutter/material.dart";
import 'package:rbti_android/screen/buku_detail.dart';
import 'package:rbti_android/widgets/coba.dart';

class BookItem extends StatelessWidget {
  final String title;
  final String penulis;
  final String kategori;
  final String tipe;
  final String id;
  bool? isAvailable = false;

  BookItem(
      {required this.title,
      required this.penulis,
      required this.kategori,
      required this.tipe,
      required this.id,
      this.isAvailable});

  @override
  Widget build(BuildContext context) {
    // var argsDetail = DetailBuku(id, title, kategori, penulis, tipe);
    var argsDetail = DetailBuku(
        id: id,
        title: title,
        kategori: kategori,
        penulis: penulis,
        tipe: tipe,
        isAvailable: isAvailable);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BukuDetail.routeName,
            arguments: argsDetail);
      },
      child: Card(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kategori,
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                penulis,
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
