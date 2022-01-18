import 'dart:convert';

import "package:flutter/material.dart";
import './book.dart';
import 'package:http/http.dart' as http;
import "../helper/api.dart";

class Books with ChangeNotifier {
  List<Book> _items = [];

  List<Book> get items {
    return [..._items];
  }

  List<Book> get itemsLimited {
    if (_items.length > 0) {
      return [...items].sublist(0, 3);
    }
    return [...items];
  }

  Future<void> fetchAndSetBooks() async {
    var url = "${APILink.apiLink}/api/buku/search";
    final requestBody =
        json.encode({"query": "", "filter": "skripsi", "size": 5, "from": 10});
    final response = await http.post(Uri.parse(url), body: requestBody);
    print(response);
    final List<Book> loadedBooks = [];
    final extractedData = json.decode(response.body)["data"] as List<dynamic>;
    extractedData.forEach((book) {
      loadedBooks.add(Book(
          id: book["id"],
          title: book["judul"],
          kategori: book["kategori"],
          idKategori: book["id_kategori"],
          penulis: book["penulis"],
          tipe: book["tipe"]));
    });

    _items = loadedBooks;
    notifyListeners();
  }
}
