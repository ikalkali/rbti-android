import "package:flutter/material.dart";
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/navbar/bottom_navbar.dart';
import 'package:rbti_android/widgets/list/search_book_listview.dart';
import 'package:rbti_android/widgets/modal/filter_modal.dart';
import 'package:rbti_android/widgets/search_bar.dart';

class BukuListViewScreen extends StatefulWidget {
  const BukuListViewScreen({Key? key, required BookFilter this.filter})
      : super(key: key);

  static const routeName = "/buku-listview";
  final BookFilter filter;

  @override
  _BukuListViewScreenState createState() => _BukuListViewScreenState();
}

class _BukuListViewScreenState extends State<BukuListViewScreen> {
  BookFilter _filter = BookFilter();
  @override
  void didChangeDependencies() {
    _filter = widget.filter;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String titleText;
    if (widget.filter.kategori != null) {
      titleText = "Koleksi ${widget.filter.kategori}";
    } else {
      titleText = "Hasil pencarian";
    }

    void submitSearchHandler(String value) {
      var newFilter = BookFilter(query: value);
      setState(() {
        _filter = newFilter;
      });
    }

    return Scaffold(
        bottomNavigationBar: BottomNavbar(
          index: 1,
        ),
        appBar: AppBar(
          title: Container(
            height: 40,
            child: SearchBar("Cari judul, penulis...", submitSearchHandler),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(8),
              child: IconButton(
                icon: Icon(Icons.filter_alt),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return FilterModal(
                          filter: _filter,
                        );
                      }).then((val) {
                    if (val != null) {
                      var newFilter = BookFilter(
                          jenis: val, idKategori: widget.filter.idKategori);
                      setState(() {
                        _filter = newFilter;
                      });
                    }
                  });
                },
              ),
            )
          ],
        ),
        body: SearchBookListView(
          filter: _filter,
        ));
  }
}
