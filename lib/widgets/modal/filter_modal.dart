import "package:flutter/material.dart";
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/widgets/koleksi_home.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({Key? key, required BookFilter this.filter})
      : super(key: key);

  final BookFilter filter;

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final listChoices = <ItemChoice>[
    ItemChoice(1, 'Buku', "buku"),
    ItemChoice(2, 'Skripsi', "skripsi"),
    ItemChoice(3, 'Laporan PKL', "jurnal"),
  ];
  var idSelected = 1;
  var selectedValue = "buku";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Jenis",
          style: Theme.of(context).textTheme.headline4,
        ),
        Wrap(
          children: listChoices
              .map((e) => ChoiceChip(
                    selected: idSelected == e.id,
                    label: Text(e.label),
                    onSelected: (_) => setState(() {
                      selectedValue = e.value;
                      idSelected = e.id;
                    }),
                  ))
              .toList(),
          spacing: 8,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () {
                Navigator.pop(context, selectedValue);
              },
              child: Text(
                "APPLY FILTER",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: Colors.white, fontSize: 16),
              )),
        )
      ]),
    ));
  }
}
