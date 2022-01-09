import 'package:flutter/material.dart';
import "package:flutter/foundation.dart";

class Book with ChangeNotifier {
  final String id;
  final String title;
  final String kategori;
  final String penulis;

  Book({
    required this.id,
    required this.title,
    required this.kategori,
    required this.penulis
  });
}