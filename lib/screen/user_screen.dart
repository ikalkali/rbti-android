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
    final dataUser = Provider.of<Auth>(context).userData;
    @override
    void didChangeDependencies() {
      if (_isInit) {
        Provider.of<Auth>(context, listen: false).getDataUser();
        _isInit = false;
      }
      super.didChangeDependencies();
    }

    List<Widget> dataUserBuilder() {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("NIM"), Text(dataUser?.nim ?? "nim")],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Nama"), Text(dataUser?.nama ?? "nama")],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Nomor Telepon"),
            Text(dataUser?.nomorTelp ?? "telp")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Email"), Text(dataUser?.email ?? "email")],
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Data User"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataUser?.nama ?? "nama",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 24),
                    ),
                    Text(
                      dataUser?.nim ?? "nim",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 16, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(dataUser?.email ?? "email",
                            style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.5,
                      color: Colors.black54,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nomor HP",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(dataUser?.nomorTelp ?? "Nomor HP",
                            style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.5,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 300,
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      Provider.of<Auth>(context, listen: false).logout();
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text(
                      "LOGOUT",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
