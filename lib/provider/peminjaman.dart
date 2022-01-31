import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rbti_android/helper/api.dart';
import 'package:rbti_android/provider/book.dart';
import 'package:http/http.dart' as http;

class PeminjamanList extends ChangeNotifier {
  final String nimLocal;
  PeminjamanList(this.nimLocal);

  List<Peminjaman> _peminjaman = [];

  List<Peminjaman> get listPeminjaman {
    return [..._peminjaman];
  }

  Future<void> fetchAndSetPeminjaman(String nim) async {
    var url = "${APILink.apiLink}/api/peminjaman/nim";
    var requestBody = json.encode({"nim": nimLocal});

    final response = await http.post(Uri.parse(url), body: requestBody);
    final extractedData =
        json.decode(response.body)["peminjaman"] as List<dynamic>;
    final List<Peminjaman> loadedData = [];

    extractedData.forEach((peminjaman) {
      DateTime parsedDate =
          DateTime.parse(peminjaman["tanggal_peminjaman"].toString());
      List<Book> loadedBook = [];
      var extractedBook = peminjaman["buku_dipinjam"] as List<dynamic>;
      extractedBook.forEach((buku) {
        loadedBook.add(Book(
            title: buku["judul"],
            id: buku["id_buku"],
            kategori: "null",
            tahun: buku["tahun"],
            idKategori: 1,
            penulis: "null",
            tipe: "Buku"));
      });

      loadedData.add(Peminjaman(
          id: peminjaman["id_peminjaman"],
          tanggalPeminjaman: parsedDate,
          bukuDipinjam: loadedBook,
          denda: peminjaman["denda"],
          detailDenda: peminjaman["detail_denda"]));
    });

    _peminjaman = loadedData;
    notifyListeners();
  }
}

class Peminjaman {
  final int id;
  final DateTime tanggalPeminjaman;
  final List<Book> bukuDipinjam;
  final int denda;
  final String detailDenda;
  bool isExpanded;

  Peminjaman(
      {required this.id,
      required this.tanggalPeminjaman,
      required this.bukuDipinjam,
      required this.denda,
      required this.detailDenda,
      this.isExpanded = false});
}
