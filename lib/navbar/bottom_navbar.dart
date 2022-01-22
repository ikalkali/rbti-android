import "package:flutter/material.dart";
import 'package:rbti_android/main.dart';
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/screen/buku_list_view.dart';
import 'package:rbti_android/screen/peminjaman_screen.dart';

class BottomNavbar extends StatefulWidget {
  BottomNavbar({required this.index});

  final int index;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final screens = [];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: Colors.white,
        currentIndex: widget.index,
        onTap: (index) {
          if (index != widget.index) {
            switch (index) {
              case 0:
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return HomePage();
                }));
                break;
              case 1:
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return BukuListViewScreen(
                    filter: BookFilter(),
                  );
                }));
                break;
              case 2:
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return PeminjamanScreen();
                }));
            }
          }
        },
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: "Buku",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), label: "Peminjaman")
        ]);
  }
}
