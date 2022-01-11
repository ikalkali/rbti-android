import "package:flutter/material.dart";

class RowDetailBuku extends StatelessWidget {
  final String text1;
  final String text2;
  final bool withDivider;

  RowDetailBuku(this.text1, this.text2, this.withDivider);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text(text1), Text(text2)],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 2,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
