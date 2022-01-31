import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/provider/books.dart';
import 'package:rbti_android/widgets/tabel_detail_buku.dart';

class BukuDetail extends StatelessWidget {
  static const routeName = "/buku-detail";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailBuku;
    print("ARGS DI SCREEN ${args.tipe}");

    final bookRepo = Provider.of<Books>(context, listen: false);

    Widget buttonAddToCart() {
      if (args.isAvailable == true) {
        return Container(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              bookRepo.addCartItem("185060707111004", [
                int.parse(args.id)
              ]).then((value) => {
                    print("VALUE ADD TO CART $value"),
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            content: Wrap(
                              children: [
                                Column(children: [
                                  Icon(
                                    Icons.check_circle,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 60,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Berhasil menambahkan ${args.title} ke keranjang pinjaman",
                                    style: TextStyle(
                                        fontFamily: "Raleway",
                                        color: Colors.black,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ])
                              ],
                            ),
                          );
                        })
                  });
            },
            child: Text(
              "PINJAM",
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                // minimumSize: ,
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
          ),
        );
      }
      return Container(
          width: double.infinity,
          child: TextButton(
            onPressed: null,
            child: Text(
              "STOK HABIS",
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.grey[400]),
          ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(args.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 10,
                ),
                RowDetailBuku("Penulis", args.penulis, true),
                RowDetailBuku("Penerbit", "Doni Subandono", true),
                RowDetailBuku("Tahun", "2009", true),
                RowDetailBuku("Kategori", args.kategori, true),
                RowDetailBuku("Nomor Rak", "12A", true),
                RowDetailBuku("ID Judul", args.id, false),
                SizedBox(height: 20),
                args.tipe.toLowerCase() == "buku"
                    ? buttonAddToCart()
                    : Text(""),
              ],
            ),
          ),
        ));
  }
}

class DetailBuku {
  final String id;
  final String title;
  final String kategori;
  final String penulis;
  final String tipe;
  bool? isAvailable = true;

  DetailBuku(
      {required this.id,
      required this.title,
      required this.kategori,
      required this.penulis,
      required this.tipe,
      this.isAvailable});
}
