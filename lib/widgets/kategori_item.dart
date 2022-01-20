import "package:flutter/material.dart";
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/screen/buku_list_view.dart';

class KategoriItem extends StatelessWidget {
  final String kategori;
  final int idKategori;

  KategoriItem(this.kategori, this.idKategori);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(BukuListViewScreen.routeName,
            arguments: BookFilter(idKategori: idKategori, kategori: kategori));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              height: 5,
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(kategori),
            ),
          ],
        ),
      ),
    );
  }
}
