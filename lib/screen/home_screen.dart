import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/navbar/bottom_navbar.dart';
import 'package:rbti_android/provider/book.dart';
import 'package:rbti_android/provider/books.dart';
import 'package:rbti_android/widgets/book_item.dart';
import 'package:rbti_android/widgets/coba.dart';
import 'package:rbti_android/widgets/koleksi_home.dart';
import "../widgets/rekomendasi_buku.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<Books>(context);
    final bookItems = books.itemsLimited;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavbar(),
      body: Stack(
        children: [
          ColoredBox(
            color: Theme.of(context).colorScheme.secondary,
            child: SizedBox(
              width: double.infinity,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(children: [
              RekomendasiBuku(bookItems: bookItems),
              KoleksiHome(),
              BookItem(
                  title: "Menjalani Hari Hari",
                  penulis: "Donny Cat",
                  kategori: "Kucing Book"),
              BookItem(
                  title: "Menjalani Hari Hari",
                  penulis: "Donny Cat",
                  kategori: "Kucing Book"),
              BookItem(
                  title: "Menjalani Hari Hari",
                  penulis: "Donny Cat",
                  kategori: "Kucing Book"),
            ]),
          ),
        ],
      ),
    );
  }
}
