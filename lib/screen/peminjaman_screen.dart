import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/navbar/bottom_navbar.dart';
import 'package:rbti_android/provider/peminjaman.dart';
import 'package:rbti_android/widgets/book_peminjaman_item.dart';
import 'package:rbti_android/widgets/peminjaman_item.dart';

class PeminjamanScreen extends StatefulWidget {
  const PeminjamanScreen({Key? key}) : super(key: key);

  @override
  State<PeminjamanScreen> createState() => _PeminjamanScreenState();
}

class _PeminjamanScreenState extends State<PeminjamanScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<PeminjamanList>(context)
          .fetchAndSetPeminjaman("185060707111004");
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final listPeminjaman = Provider.of<PeminjamanList>(context).listPeminjaman;
    return Scaffold(
      appBar: AppBar(
        title: Text("Peminjaman"),
      ),
      bottomNavigationBar: BottomNavbar(
        index: 2,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "List\nPeminjaman",
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 0.75,
                color: Colors.black54,
              ),
              Container(
                  height: 500,
                  child: SingleChildScrollView(
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          listPeminjaman[index].isExpanded =
                              !listPeminjaman[index].isExpanded;
                        });
                      },
                      children: buildPeminjaman(listPeminjaman),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

List<ExpansionPanel> buildPeminjaman(List<Peminjaman> listPeminjaman) {
  return listPeminjaman.map<ExpansionPanel>((Peminjaman peminjaman) {
    return ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: PeminjamanItem(peminjaman: peminjaman),
          );
        },
        body: PeminjamanItemExpansion(
            idPeminjaman: peminjaman.id,
            bookPeminjaman: peminjaman.bukuDipinjam
                .map<BookPeminjaman>((item) => BookPeminjaman(
                    id: item.id,
                    judul: item.title,
                    tahun: item.tahun.toString()))
                .toList()),
        isExpanded: peminjaman.isExpanded);
  }).toList();
}

// ListView.separated(
//                     itemBuilder: (context, index) {
//                       return PeminjamanItem(
//                         peminjaman: listPeminjaman[index],
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return Divider(
//                         thickness: 0.75,
//                         color: Colors.black54,
//                       );
//                     },
//                     itemCount: listPeminjaman.length),