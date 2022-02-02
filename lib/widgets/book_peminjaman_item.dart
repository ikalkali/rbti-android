import "package:flutter/material.dart";
import 'package:rbti_android/screen/detail_peminjaman_screen.dart';

class PeminjamanItemExpansion extends StatelessWidget {
  const PeminjamanItemExpansion(
      {Key? key, required this.bookPeminjaman, required this.idPeminjaman})
      : super(key: key);

  final List<BookPeminjaman> bookPeminjaman;
  final int idPeminjaman;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Buku dipinjam",
                style: TextStyle(
                    fontFamily: "Raleway", fontWeight: FontWeight.bold)),
            Divider(
              thickness: 1,
              color: Colors.black54,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bookPeminjaman.map<Widget>((item) {
                  return Column(
                    children: [
                      Container(
                        child: Text(item.judul),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          DetailPeminjamanScreen.routeName,
                          arguments:
                              ArgsDetailPeminjaman(idPeminjaman.toString()));
                    },
                    child: Text(
                      "Lihat Barcode",
                      style: TextStyle(color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }
}

class BookPeminjaman {
  final int id;
  final String judul;
  final String tahun;
  bool isExpanded;

  BookPeminjaman(
      {required this.id,
      required this.judul,
      required this.tahun,
      this.isExpanded = false});
}
