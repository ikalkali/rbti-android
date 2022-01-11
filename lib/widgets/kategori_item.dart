import "package:flutter/material.dart";

class KategoriItem extends StatelessWidget {
  final String kategori;

  KategoriItem(this.kategori);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 5,
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(kategori),
          ),
        ],
      ),
    );
  }
}
