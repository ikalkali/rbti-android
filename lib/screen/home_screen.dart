import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/navbar/bottom_navbar.dart';
import 'package:rbti_android/provider/book.dart';
import 'package:rbti_android/provider/books.dart';
import 'package:rbti_android/widgets/book_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<Books>(context);
    final bookItems = books.itemsLimited;
    return Scaffold(
      appBar: AppBar(title: const Text("RBTI Universitas Brawijaya"),),
      bottomNavigationBar: BottomNavbar(),
      body: 
        Stack(children: [
              ColoredBox(
                color: Theme.of(context).colorScheme.secondary,
                  child: SizedBox(
                    width: double.infinity,
                    height: 170,
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text("Selamat Datang di\nRBTI Online", style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold
                          ), textAlign: TextAlign.left,
                          softWrap: false,),
                    ),
                        const SizedBox(height: 10,),
                      Container(height: 40, width: double.infinity, decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8)
                      ),),
                      const SizedBox(height: 10,),
                      Container(child: Text("Rekomendasi buku", style: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white
                      ),), width: double.infinity,),
                      Container(
                        height: 400,
                        width: double.infinity,
                        child: ListView.builder(itemBuilder: (ctx, idx) {
                          return BookItem(title: bookItems[idx].title, penulis: bookItems[idx].penulis, kategori: bookItems[idx].kategori);
                        }, itemCount: bookItems.length,),
                      )
                  ]
                ),
              ),
        ],),
    );
  }
}