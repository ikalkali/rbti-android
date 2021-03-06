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
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });

    if (_isInit) {
      Provider.of<KategoriList>(context)
          .fetchAndSetKategori()
          .then((_) => null);
      _isInit = false;
    }

    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final kategori = Provider.of<KategoriList>(context);
    final kategoriItem = kategori.allKategori;
    return Scaffold(
        appBar: AppBar(
          title: Text("Kategori"),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(() {
            setState(() {
              _isInit = true;
              super.didChangeDependencies();
            });
          }),
          child: Container(
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
                // SearchBar("Filter kategori..."),
                if (_isLoading)
                  Container(
                      height: 500,
                      child: Center(child: CircularProgressIndicator()))
                else
                  Container(
                      height: 550,
                      child: ListView.builder(
                          itemCount: kategoriItem.length,
                          itemBuilder: (context, idx) {
                            return KategoriItem(kategoriItem[idx].kategori,
                                kategoriItem[idx].id);
                          }))
              ],
            ),
          ),
        ));
  }
}
