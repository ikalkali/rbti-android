import "package:flutter/material.dart";
import 'package:rbti_android/screen/kategori_screen.dart';

class KoleksiHome extends StatefulWidget {
  const KoleksiHome({Key? key}) : super(key: key);

  @override
  _KoleksiHomeState createState() => _KoleksiHomeState();
}

class _KoleksiHomeState extends State<KoleksiHome> {
  final listChoices = <ItemChoice>[
    ItemChoice(1, 'Buku'),
    ItemChoice(2, 'Skripsi'),
    ItemChoice(3, 'Laporan PKL'),
  ];
  var idSelected = 0;

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
                      selected: idSelected == e.id,
                      label: Text(e.label),
                      onSelected: (_) => setState(() {
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

  ItemChoice(this.id, this.label);
}
