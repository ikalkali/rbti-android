import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/provider/kategori.dart';
import 'package:rbti_android/widgets/kategori_item.dart';
import 'package:rbti_android/widgets/search_bar.dart';

class KategoriScreen extends StatefulWidget {
  static const routeName = "/kategori";

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<KategoriList>(context)
          .fetchAndSetKategori()
          .then((_) => null);
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final kategori = Provider.of<KategoriList>(context);
    final kategoriItem = kategori.allKategori;
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
                  child: ListView.builder(
                      itemCount: kategoriItem.length,
                      itemBuilder: (context, idx) {
                        return KategoriItem(
                            kategoriItem[idx].kategori, kategoriItem[idx].id);
                      }))
            ],
          ),
        ));
  }
}
