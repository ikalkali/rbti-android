import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/navbar/bottom_navbar.dart';
import 'package:rbti_android/provider/peminjaman.dart';
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
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return PeminjamanItem(
                        peminjaman: listPeminjaman[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 0.75,
                        color: Colors.black54,
                      );
                    },
                    itemCount: listPeminjaman.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
