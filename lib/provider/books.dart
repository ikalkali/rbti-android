import 'dart:convert';

import "package:flutter/material.dart";
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/screen/cart_screen.dart';
import './book.dart';
import 'package:http/http.dart' as http;
import "../helper/api.dart";

class Books with ChangeNotifier {
  List<Book> _items = [];
  List<Book> _cartItems = [];
  bool _isAvailable = false;

  final String nimLocal;
  Books(this.nimLocal, this._items);

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

  bool get cartItemAvailable {
    return _isAvailable;
  }

  Future<void> fetchAndSetBooks(int limit, int offset) async {
    var url = "${APILink.apiLink}/api/buku/search";
    final requestBody = json.encode(
        {"query": "", "jenis": "skripsi", "size": limit, "from": 10 + offset});
    final response = await http.post(Uri.parse(url), body: requestBody);

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

    String filterJenis;
    if (filter.jenis == null || filter.jenis == "semua") {
      filterJenis = "";
    } else {
      filterJenis = filter.jenis as String;
    }

    final requestBody = {
      "query": filter.query,
      "jenis": filterJenis,
      "size": limit,
      "from": offset,
      "bisa_dipinjam": filter.tersedia,
      "jenis_pinjam": filter.jenisPinjam
    };
    if (filter.idKategori != null) {
      requestBody["id_kategori"] = [filter.idKategori];
    }
    final reqBodyEncode = json.encode(requestBody);

    final response = await http.post(Uri.parse(url), body: reqBodyEncode);
    final List<Book> loadedBooks = [];
    final totalItemCount = json.decode(response.body)["count"] as int;
    final extractedData = json.decode(response.body)["data"] as List<dynamic>;
    extractedData.forEach((book) {
      var jmlTersedia = book["jumlah_tersedia"] ?? 0;
      var tersedia = jmlTersedia != 0 ? true : false;
      loadedBooks.add(Book(
          id: book["id"],
          title: book["judul"],
          kategori: book["kategori"],
          idKategori: book["id_kategori"],
          isAvailable: tersedia,
          penulis: book["penulis"],
          tipe: book["tipe"]));
    });

    _paginateItemCount = totalItemCount;
    notifyListeners();

    return loadedBooks;
  }

  Future<void> fetchCartItems(String nim) async {
    var url = "${APILink.apiLink}/api/cart";
    var requestBody = json.encode({"nim": nimLocal});

    final response = await http.post(Uri.parse(url), body: requestBody);
    final extractedData = json.decode(response.body)["data"]["judul"];
    final List<Book> loadedBooks = [];

    if (extractedData == null) {
      return;
    }

    extractedData.forEach((book) {
      if (book["is_available"] as bool) {
        _isAvailable = true;
      }

      loadedBooks.add(Book(
          id: book["id"],
          title: book["judul"],
          kategori: "not given",
          idKategori: book["id_kategori"],
          penulis: book["penulis"],
          isAvailable: book["is_available"],
          tipe: "Buku"));
    });

    _cartItems = loadedBooks;
    notifyListeners();
  }

  Future<String> addCartItem(String nim, List<int> id) async {
    var url = "${APILink.apiLink}/api/cart/edit";
    var requestBody = json.encode({
      "nim": nimLocal,
      "id_judul": [...id],
      "action": "add"
    });

    final response = await http.post(Uri.parse(url), body: requestBody);
    if (response.statusCode > 400) {
      return "${json.decode(response.body)['errors']}";
    }

    return "success";
  }

  Future<String> removeCartItem(String nim, int id) async {
    var url = "${APILink.apiLink}/api/cart/edit";
    var requestBody = json.encode({
      "nim": nimLocal,
      "id_judul": [id],
      "action": "remove"
    });

    final response = await http.post(Uri.parse(url), body: requestBody);
    if (response.statusCode > 400) {
      return "${json.decode(response.body)['errors']}";
    }

    return "success";
  }

  Future<String> addCartToPeminjaman(
      List<CartDetailPeminjaman> cartDetail, String nim) async {
    var url = "${APILink.apiLink}/api/peminjaman";
    var urlCart = "${APILink.apiLink}/api/cart/edit";

    List<int> availableIdJudul = [];
    cartDetail.forEach((item) {
      if (item.isAvailable) {
        availableIdJudul.add(item.idJudul);
      }
    });

    var requestBody = json.encode({
      "nim": nimLocal,
      "id_judul": [...availableIdJudul],
      "source": "app"
    });

    var requestCart = json.encode({
      "nim": nimLocal,
      "id_judul": [...availableIdJudul],
      "action": "remove"
    });

    var oldCartItems = [..._cartItems];
    final response = await http.post(Uri.parse(url), body: requestBody);
    if (response.statusCode > 400) {
      return "${json.decode(response.body)['errors']}";
    }

    final responseCart = await http.post(Uri.parse(urlCart), body: requestCart);
    if (response.statusCode > 400) {
      return "${json.decode(response.body)['errors']}";
    }

    final extractedIdPeminjaman = json.decode(response.body)["data"] as String;

    _cartItems = [];
    _isAvailable = false;
    notifyListeners();

    return extractedIdPeminjaman;
  }
}
