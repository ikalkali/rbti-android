import 'package:flutter/material.dart';

class ChoiceChipExample extends StatefulWidget {
  @override
  _ChoiceChipExampleState createState() => _ChoiceChipExampleState();
}

class _ChoiceChipExampleState extends State<ChoiceChipExample> {
  final listChoices = <ItemChoice>[
    ItemChoice(1, '7 Hari'),
    ItemChoice(2, '14 Hari'),
    ItemChoice(3, '1 Bulan'),
    ItemChoice(4, '3 Bulan'),
  ];
  var idSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Terakhir ditambahkan'),
          Wrap(
            children: listChoices
                .map((e) => ChoiceChip(
                      label: Text(e.label),
                      selected: idSelected == e.id,
                      onSelected: (_) => setState(() => idSelected = e.id),
                    ))
                .toList(),
            spacing: 8,
          ),
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
