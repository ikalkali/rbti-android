import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/provider/auth.dart';
import 'package:rbti_android/provider/books.dart';
import 'package:rbti_android/screen/auth_screen.dart';
import 'package:rbti_android/screen/detail_peminjaman_screen.dart';
import 'package:rbti_android/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    if (_isInit) {
      Provider.of<Books>(context)
          .fetchCartItems("185060707111004")
          .then((_) => null);
      _isInit = false;
    }
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartRepo = Provider.of<Books>(context);
    final cartItems = cartRepo.cartItems;
    final cartItemAvaibility = cartRepo.cartItemAvailable;
    final isAuth = Provider.of<Auth>(context).isAuth;
    Widget errorMsg;

    if (cartItems.length == 0) {
      if (!isAuth) {
        errorMsg = Container(
          width: double.infinity,
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () {
                Navigator.of(context).pushNamed(AuthScreen.routeName);
              },
              child: Text(
                "LOGIN UNTUK MELIHAT CART",
                style: TextStyle(color: Colors.white),
              )),
        );
      } else {
        errorMsg = Text(
          "Tidak ada item pada cart",
          style: Theme.of(context).textTheme.headline4,
        );
      }
    }

    Widget renderList() {
      if (cartItems.length == 0) {
        if (!isAuth) {
          errorMsg = Container(
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  Navigator.of(context).pushNamed(AuthScreen.routeName);
                },
                child: Text(
                  "LOGIN UNTUK MELIHAT CART",
                  style: TextStyle(color: Colors.white),
                )),
          );
        } else {
          errorMsg = Container(
            height: 300,
            child: Center(
              child: Text(
                "Tidak ada item pada cart",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          );
        }

        return errorMsg;
      }
      return Container(
        height: 500,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return CartItem(
                judul: cartItems[index].title,
                isAvailable: cartItems[index].isAvailable as bool,
                detail: "${cartItems[index].penulis}",
                id: cartItems[index].id,
                cartRepo: cartRepo,
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                color: Colors.black54,
              );
            },
            itemCount: cartItems.length),
      );
    }

    Widget renderButton() {
      if (cartItems.length == 0) {
        return SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 30,
          child: TextButton(
              onPressed: !cartItemAvaibility
                  ? null
                  : () {
                      setState(() {
                        _isLoading = true;
                      });
                      List<CartDetailPeminjaman> cartDetailPeminjaman = [];
                      cartItems.forEach((item) {
                        cartDetailPeminjaman.add(CartDetailPeminjaman(
                            idJudul: item.id,
                            isAvailable: item.isAvailable as bool));
                      });
                      cartRepo
                          .addCartToPeminjaman(
                              cartDetailPeminjaman, "185060707111004")
                          .then((value) => Navigator.of(context)
                              .pushReplacementNamed(
                                  DetailPeminjamanScreen.routeName,
                                  arguments: ArgsDetailPeminjaman(value)))
                          .catchError(() {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    },
              style: TextButton.styleFrom(
                  backgroundColor: cartItemAvaibility
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[400]),
              child: Text(
                "SETUJU dan KONFIRMASI",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 14),
              )),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang"),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Buku dalam keranjang",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 1,
              color: Colors.black54,
            ),
            renderList(),
            SizedBox(
              height: 20,
            ),
            renderButton()
          ],
        ),
      )),
    );
  }
}

class CartDetailPeminjaman {
  final int idJudul;
  final bool isAvailable;

  CartDetailPeminjaman({required this.idJudul, required this.isAvailable});
}
