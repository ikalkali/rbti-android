import 'dart:convert';

import "package:flutter/material.dart";
import './book.dart';
import 'package:http/http.dart' as http;
import "../helper/api.dart";

class Books with ChangeNotifier {
  List<Book> _items = [];

  int _paginateItemCount = 0;

  List<Book> get items {
    return [..._items];
  }

  List<Book> get itemsLimited {
    if (_items.length > 0) {
      return [...items].sublist(0, 3);
    }
    return [...items];
  }

  int get currentPaginateCount {
    return _paginateItemCount;
  }

  Future<void> fetchAndSetBooks(int limit, int offset) async {
    var url = "${APILink.apiLink}/api/buku/search";
    final requestBody = json.encode(
        {"query": "", "filter": "skripsi", "size": limit, "from": 10 + offset});
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

  Future<List<Book>> fetchPaginatedBook(int limit, int offset,
      [String? filter = "buku"]) async {
    print(filter);
    var url = "${APILink.apiLink}/api/buku/search";
    final requestBody = json
        .encode({"query": "", "filter": filter, "size": limit, "from": offset});
    final response = await http.post(Uri.parse(url), body: requestBody);
    final List<Book> loadedBooks = [];
    final totalItemCount = json.decode(response.body)["count"] as int;
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

    _paginateItemCount = totalItemCount;
    print(_paginateItemCount);
    notifyListeners();

    return loadedBooks;
  }
}
