import "package:flutter/material.dart";

class BottomNavbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      items : const [
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Buku",),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.view_list), label: "Peminjaman")
      ]
    );
  }
}