import "package:flutter/material.dart";

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key, required this.judul, required this.detail, required this.id})
      : super(key: key);

  final String judul;
  final String detail;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("$id"),
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
      child: Container(
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
      ),
    );
  }
}
