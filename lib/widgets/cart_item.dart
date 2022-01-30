import "package:flutter/material.dart";
import 'package:rbti_android/provider/books.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key,
      required this.judul,
      required this.detail,
      required this.id,
      required this.cartRepo,
      required this.isAvailable})
      : super(key: key);

  final String judul;
  final String detail;
  final int id;
  final Books cartRepo;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key("$id"),
        onDismissed: (direction) {
          cartRepo.removeCartItem("185060707111004", this.id);
        },
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          child: Icon(Icons.delete, color: Colors.white, size: 40),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          // margin: EdgeInsets.symmetric(
          //   horizontal: 15,
          //   vertical: 4,
          // ),
        ),
        child: buildDetailItem(context, isAvailable, judul, detail));
  }
}

Widget buildDetailItem(
    BuildContext context, bool isAvailable, String judul, String detail) {
  if (isAvailable) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(detail, style: Theme.of(context).textTheme.caption)
          ],
        ),
      ),
    );
  } else {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.grey[400]),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Judul tidak tersedia",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.red)),
            SizedBox(
              height: 5,
            ),
            Text(detail,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.grey[400]))
          ],
        ),
      ),
    );
  }
}
