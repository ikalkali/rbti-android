import 'dart:convert';

import 'package:flutter/material.dart';
import "package:flutter/foundation.dart";

class Book {
  final int id;
  final String title;
  final String kategori;
  final String penulis;
  final String tipe;
  final int idKategori;

  final String? penerbit;
  final int? jenis;
  final int? jumlahTotal;
  final int? jumlahTersedia;
  final String? nim;
  final int? tahun;
  final bool? isAvailable;

  Book(
      {required this.id,
      required this.title,
      required this.kategori,
      required this.idKategori,
      required this.penulis,
      required this.tipe,
      this.penerbit,
      this.jenis,
      this.jumlahTotal,
      this.jumlahTersedia,
      this.nim,
      this.tahun,
      this.isAvailable});
}
