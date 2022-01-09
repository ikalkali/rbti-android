import "package:flutter/material.dart";

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
      child: Row(
        children: [
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
