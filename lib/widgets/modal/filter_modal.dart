import "package:flutter/material.dart";
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/widgets/koleksi_home.dart';
import 'package:dropdown_search/dropdown_search.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({Key? key, required BookFilter this.filter})
      : super(key: key);

  final BookFilter filter;

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final listChoices = <ItemChoice>[
    ItemChoice(4, 'Semua Buku', "semua"),
    ItemChoice(1, 'Buku', "buku"),
    ItemChoice(2, 'Skripsi', "skripsi"),
    ItemChoice(3, 'Laporan PKL', "jurnal"),
  ];
  var idSelected = 1;
  var selectedValue;

  final listJenis = <ItemChoice>[
    ItemChoice(0, "Semua", ""),
    ItemChoice(1, "Bisa Dipinjam", ""),
    ItemChoice(2, "Tidak Bisa Dipinjam", ""),
  ];
  var idSelectedJenis = 0;
  var availableOnly = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedValue = widget.filter.jenis ?? "semua" as String;
      idSelectedJenis = widget.filter.jenisPinjam ?? 0;
      if (idSelectedJenis == 1) {
        availableOnly = widget.filter.tersedia ?? false;
      }
      print("SELECTED VALUE : $selectedValue");
    });
  }

  Widget showRow() {
    if (idSelectedJenis == 1) {
      return Row(
        children: [
          Text("Perlihatkan buku dengan stok tersedia saja"),
          Checkbox(
              value: availableOnly,
              onChanged: (val) {
                setState(() {
                  availableOnly = val as bool;
                });
              })
        ],
      );
    }

    return SizedBox.shrink();
  }

  List<Widget> showJenisPinjam() {
    if (selectedValue == "buku") {
      return [
        Text(
          "Jenis",
          style: Theme.of(context).textTheme.headline4,
        ),
        Wrap(
          children: listJenis
              .map((e) => ChoiceChip(
                    selected: idSelectedJenis == e.id,
                    label: Text(e.label),
                    onSelected: (_) => setState(() {
                      idSelectedJenis = e.id;
                    }),
                  ))
              .toList(),
          spacing: 8,
        )
      ];
    }
    return [SizedBox.shrink()];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Tipe",
          style: Theme.of(context).textTheme.headline4,
        ),
        Wrap(
          children: listChoices
              .map((e) => ChoiceChip(
                    selected: selectedValue == e.value,
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
          height: 15,
        ),
        ...showJenisPinjam(),
        showRow(),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () {
                Navigator.pop(
                    context,
                    BookFilter(
                        jenis: selectedValue,
                        jenisPinjam: idSelectedJenis,
                        tersedia: availableOnly));
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
