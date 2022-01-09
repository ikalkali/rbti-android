import "package:flutter/material.dart";
import './book.dart';

class Books with ChangeNotifier {
  List<Book> _items = [
    Book(id: "p1", title: "Manajemen Nova", penulis: "Nova Putera", kategori: "PPIC"),
    Book(id: "p2", title: "Princess Sefira", penulis: "Sefira Salsabila", kategori: "Matematika"),
    Book(id: "p3", title: "Manajemen Produksi", penulis: "Ega Putera", kategori: "Statistik"),
    Book(id: "p4", title: "Analisis dan Perancangan Sistem Hahahhahahaha", penulis: "Rio Nugraha", kategori: "PPIC"),
    Book(id: "p5", title: "Analisis dan Perancangan Sistem Hahahhahahaha", penulis: "Rio Nugraha", kategori: "PPIC"),
    Book(id: "p6", title: "Analisis dan Perancangan Sistem Hahahhahahaha", penulis: "Rio Nugraha", kategori: "PPIC"),
    Book(id: "p7", title: "Analisis dan Perancangan Sistem Hahahhahahaha", penulis: "Rio Nugraha", kategori: "PPIC"),
  ];

  List<Book> get items {
    return [..._items];
  }

  List<Book> get itemsLimited {
    return [..._items].sublist(0, 3);
  }
}

