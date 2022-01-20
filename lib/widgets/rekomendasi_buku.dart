import "package:flutter/material.dart";
import '../widgets/book_item.dart';
import '../provider/book.dart';

class RekomendasiBuku extends StatelessWidget {
  const RekomendasiBuku({
    Key? key,
    required this.bookItems,
  }) : super(key: key);

  final List<Book> bookItems;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              "Selamat Datang di\nRBTI Online",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              softWrap: false,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search...",
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Rekomendasi buku",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            ),
            width: double.infinity,
          ),
          Container(
              width: double.infinity,
              child: Column(
                children: bookItems
                    .map((e) => BookItem(
                        title: e.title,
                        penulis: e.penulis,
                        kategori: e.kategori))
                    .toList(),
              )),
          SizedBox(
            height: 20,
          )
        ]);
  }
}
