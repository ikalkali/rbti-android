import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/provider/books.dart';
import 'package:rbti_android/screen/kategori_screen.dart';

class KoleksiHome extends StatefulWidget {
  const KoleksiHome({Key? key, required this.filterFn, required this.filter})
      : super(key: key);

  final Function filterFn;
  final BookFilter filter;

  @override
  _KoleksiHomeState createState() => _KoleksiHomeState();
}

class _KoleksiHomeState extends State<KoleksiHome> {
  final listChoices = <ItemChoice>[
    ItemChoice(1, 'Buku', "buku"),
    ItemChoice(2, 'Skripsi', "skripsi"),
    ItemChoice(3, 'Laporan PKL', "jurnal"),
  ];
  var idSelected = 1;

  @override
  Widget build(BuildContext context) {
    final TextStyle selectedText = TextStyle(
        fontFamily: "Raleway", color: Theme.of(context).colorScheme.primary);
    final TextStyle deselectedText = TextStyle(fontFamily: "Raleway");
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Koleksi RBTI berdasarkan kategori",
                  style: Theme.of(context).textTheme.headline2,
                ),
                InkWell(
                  child: Text(
                    "Cari kategori lain",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(KategoriScreen.routeName);
                  },
                )
              ]),
          Wrap(
            children: listChoices
                .map((e) => ChoiceChip(
                      selected: widget.filter.jenis == e.value,
                      label: Text(e.label),
                      onSelected: (_) => setState(() {
                        widget.filterFn(e.value);
                        idSelected = e.id;
                      }),
                    ))
                .toList(),
            spacing: 8,
          )
        ],
      ),
    );
  }
}

class ItemChoice {
  final int id;
  final String label;
  final String value;

  ItemChoice(this.id, this.label, this.value);
}
