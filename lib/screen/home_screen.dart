import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/navbar/bottom_navbar.dart';
import 'package:rbti_android/provider/book.dart';
import 'package:rbti_android/provider/books.dart';
import 'package:rbti_android/widgets/book_item.dart';
import 'package:rbti_android/widgets/coba.dart';
import 'package:rbti_android/widgets/koleksi_home.dart';
import 'package:rbti_android/widgets/list/paged_book_listview.dart';
import "../widgets/rekomendasi_buku.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _filter = BookFilter(jenis: "buku");

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Books>(context).fetchAndSetBooks(3, 0).then((_) => null);
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  void setFilter(String filter) {
    if (_filter.jenis != filter) {
      setState(() {
        _filter = BookFilter(jenis: filter);
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<Books>(context, listen: false);
    final bookItems = books.itemsLimited;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
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
              child: ListView(primary: false, shrinkWrap: true, children: [
                RekomendasiBuku(bookItems: bookItems),
                KoleksiHome(
                  filterFn: setFilter,
                  filter: _filter,
                ),
                Consumer<Books>(builder: (context, book, child) {
                  return PagedBookListView(
                    bookRepository: book,
                    filter: _filter,
                  );
                }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
