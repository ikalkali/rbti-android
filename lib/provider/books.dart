import 'dart:convert';

import "package:flutter/material.dart";
import 'package:rbti_android/models/bookFilter.dart';
import './book.dart';
import 'package:http/http.dart' as http;
import "../helper/api.dart";

class Books with ChangeNotifier {
  List<Book> _items = [];
  List<Book> _cartItems = [];

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

  List<Book> get cartItems {
    return [..._cartItems];
  }

  Future<void> fetchAndSetBooks(int limit, int offset) async {
    var url = "${APILink.apiLink}/api/buku/search";
    final requestBody = json.encode(
        {"query": "", "jenis": "skripsi", "size": limit, "from": 10 + offset});
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

  Future<List<Book>> fetchPaginatedBook(
      int limit, int offset, BookFilter filter) async {
    var url = "${APILink.apiLink}/api/buku/search";

    final requestBody = json.encode({
      "query": filter.query,
      "jenis": filter.jenis,
      "id_kategori": filter.idKategori,
      "size": limit,
      "from": offset
    });
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
    notifyListeners();

    return loadedBooks;
  }

  Future<void> fetchCartItems(String nim) async {
    var url = "${APILink.apiLink}/api/cart";
    var requestBody = json.encode({"nim": nim});

    final response = await http.post(Uri.parse(url), body: requestBody);
    final extractedData =
        json.decode(response.body)["data"]["judul"] as List<dynamic>;
    final List<Book> loadedBooks = [];

    extractedData.forEach((book) {
      loadedBooks.add(Book(
          id: book["id"],
          title: book["judul"],
          kategori: "not given",
          idKategori: book["id_kategori"],
          penulis: book["penulis"],
          tipe: "Buku"));
    });

    _cartItems = loadedBooks;
    notifyListeners();
  }

  Future<String> addCartItem(String nim, List<int> id) async {
    var url = "${APILink.apiLink}/api/cart/edit";
    var requestBody = json.encode({
      "nim": nim,
      "id_judul": [...id],
      "action": "add"
    });

    final response = await http.post(Uri.parse(url), body: requestBody);
    if (response.statusCode > 400) {
      return "${json.decode(response.body)['errors']}";
    }

    return "success";
  }

  Future<String> addCartToPeminjaman(List<int> idJudul, String nim) async {
    var url = "${APILink.apiLink}/api/peminjaman";
    var requestBody = json.encode({
      "nim": nim,
      "id_judul": [...idJudul],
      "source": "app"
    });

    var oldCartItems = [..._cartItems];
    final response = await http.post(Uri.parse(url), body: requestBody);
    if (response.statusCode > 400) {
      return "${json.decode(response.body)['errors']}";
    }

    final extractedIdPeminjaman = json.decode(response.body)["data"] as String;

    _cartItems = [];
    notifyListeners();

    return extractedIdPeminjaman;
  }
}
