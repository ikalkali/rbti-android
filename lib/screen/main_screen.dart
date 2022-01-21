import "package:flutter/material.dart";
import 'package:rbti_android/main.dart';
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/screen/buku_list_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    HomePage(),
    BukuListViewScreen(
      filter: BookFilter(),
    ),
    Center(
      child: Text("Peminjaman"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
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
          ]),
    );
  }
}
