import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/provider/auth.dart';
import 'package:rbti_android/provider/kategori.dart';
import 'package:rbti_android/provider/peminjaman.dart';
import 'package:rbti_android/screen/auth_screen.dart';
import 'package:rbti_android/screen/buku_detail.dart';
import 'package:rbti_android/screen/buku_list_view.dart';
import 'package:rbti_android/screen/cart_screen.dart';
import 'package:rbti_android/screen/detail_peminjaman_screen.dart';
import 'package:rbti_android/screen/kategori_screen.dart';
import 'package:rbti_android/screen/peminjaman_screen.dart';
import 'package:rbti_android/screen/splash_screen.dart';
import 'package:rbti_android/screen/user_screen.dart';
import './provider/books.dart';
import './screen/home_screen.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Books>(
            create: (ctx) => Books("", []),
            update: (context, auth, prevBooks) =>
                Books(auth.nim, prevBooks == null ? [] : prevBooks.items)),
        ChangeNotifierProxyProvider<Auth, PeminjamanList>(
            create: (ctx) => PeminjamanList(""),
            update: (context, auth, prevBooks) => PeminjamanList(auth.nim)),
        ChangeNotifierProvider.value(value: KategoriList()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) {
              if (settings.name == BukuListViewScreen.routeName) {
                final args = settings.arguments as BookFilter;

                return MaterialPageRoute(builder: (context) {
                  return BukuListViewScreen(
                      filter: BookFilter(
                          query: args.query,
                          idKategori: args.idKategori,
                          kategori: args.kategori,
                          jenis: args.jenis ?? ""));
                });
              }
            },
            theme: ThemeData(
                colorScheme: ThemeData().colorScheme.copyWith(
                    primary: Color.fromRGBO(0, 109, 238, 1),
                    secondary: Color.fromRGBO(85, 163, 255, 1)),
                textTheme: TextTheme(
                    headline1: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black54),
                    headline2: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54),
                    headline3: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black),
                    headline4: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    bodyText1: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black),
                    caption: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.grey[400]))),
            home: auth.isAuth
                ? HomeScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : HomeScreen()),
            routes: {
              AuthScreen.routeName: (ctx) => AuthScreen(),
              PeminjamanScreen.routeName: (ctx) => PeminjamanScreen(),
              KategoriScreen.routeName: (ctx) => KategoriScreen(),
              BukuDetail.routeName: (ctx) => BukuDetail(),
              CartScreen.routeName: (ctx) => CartScreen(),
              UserScreen.routeName: (ctx) => UserScreen(),
              DetailPeminjamanScreen.routeName: (ctx) =>
                  DetailPeminjamanScreen()
            }),
      ),
    );
  }
}
