import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import './provider/book.dart';
import './provider/books.dart';
import './screen/home_screen.dart';
import './widgets/book_item.dart';
import './navbar/bottom_navbar.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Books())],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color.fromRGBO(0, 109, 238, 1),
                secondary: Color.fromRGBO(85, 163, 255, 1)),
            textTheme: TextTheme(
                headline1: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    fontSize: 18))),
        home: HomeScreen(),
      ),
    );
  }
}
