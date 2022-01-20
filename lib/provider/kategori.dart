import 'dart:convert';

import 'package:flutter/material.dart';
import "../helper/api.dart";
import 'package:http/http.dart' as http;

class Kategori {
  final int id;
  final String kategori;

  Kategori({required this.id, required this.kategori});
}

class KategoriList with ChangeNotifier {
  List<Kategori> _items = [];

  List<Kategori> get allKategori {
    return [..._items];
  }

  Future<void> fetchAndSetKategori() async {
    var url = "${APILink.apiLink}/api/kategori";
    final response = await http.get(Uri.parse(url));
    final List<Kategori> loadedKategori = [];

    final extractedData = json.decode(response.body) as List<dynamic>;
    extractedData.forEach((item) {
      loadedKategori.add(Kategori(id: item["id"], kategori: item["kategori"]));
    });

    _items = loadedKategori;
    notifyListeners();
  }
}
