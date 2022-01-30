import "package:flutter/material.dart";
import 'package:barcode_widget/barcode_widget.dart';

class DetailPeminjamanScreen extends StatelessWidget {
  const DetailPeminjamanScreen({Key? key}) : super(key: key);

  static const routeName = "/peminjaman-detail";

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ArgsDetailPeminjaman;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Peminjaman"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Scan Barcode di RBTI untuk mengambil buku",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "ID Peminjaman ${args.idPeminjaman.toString()}",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 200,
            ),
            BarcodeWidget(
              width: 400,
              height: 100,
              data: args.idPeminjaman.toString(),
              barcode: Barcode.code128(escapes: true),
            ),
          ]),
        ),
      ),
    );
  }
}

class ArgsDetailPeminjaman {
  final String idPeminjaman;

  ArgsDetailPeminjaman(this.idPeminjaman);
}
