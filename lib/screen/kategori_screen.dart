import "package:flutter/material.dart";
import 'package:rbti_android/widgets/kategori_item.dart';
import 'package:rbti_android/widgets/search_bar.dart';

class KategoriScreen extends StatelessWidget {
  static const routeName = "/kategori";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kategori"),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Semua\nkategori buku",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 10,
              ),
              SearchBar("Filter kategori..."),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 470,
                child: ListView(
                  children: [
                    KategoriItem("Kucing"),
                    KategoriItem("Kucing"),
                    KategoriItem("Kucing"),
                    KategoriItem("Kucing"),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
