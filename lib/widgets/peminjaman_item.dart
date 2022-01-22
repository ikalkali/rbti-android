import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:rbti_android/provider/peminjaman.dart';

class PeminjamanItem extends StatelessWidget {
  const PeminjamanItem({Key? key, required Peminjaman this.peminjaman})
      : super(key: key);

  final Peminjaman peminjaman;

  @override
  @override
  Widget build(BuildContext context) {
    var tanggalPeminjamanConv =
        DateFormat.yMMMMd().format(peminjaman.tanggalPeminjaman);
    var tanggalPengembalian = DateFormat.yMMMMd()
        .format(peminjaman.tanggalPeminjaman.add(Duration(days: 14)));

    return Container(
      child: Container(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#${peminjaman.id.toString()}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Dipinjam pada ${tanggalPeminjamanConv}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text("Kembalikan sebelum ${tanggalPengembalian}",
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            )
          ],
        ),
      ),
    );
  }
}
