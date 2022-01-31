import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/provider/auth.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  static const routeName = "/user-detail";

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    var _isInit = true;

    @override
    void didChangeDependencies() {
      if (_isInit) {
        Provider.of<Auth>(context, listen: false).getDataUser();
        _isInit = false;
      }
      super.didChangeDependencies();
    }

    List<Widget> dataUserBuilder() {
      var dataUser = Provider.of<Auth>(context).userData;
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("NIM"), Text(dataUser!.nim)],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Nama"), Text(dataUser.nama)],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Nomor Telepon"), Text(dataUser.nomorTelp)],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Email"), Text(dataUser.email)],
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          child: Column(
            children: dataUserBuilder(),
          ),
        ),
      ),
    );
  }
}
