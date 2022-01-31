import "package:flutter/material.dart";
import 'package:rbti_android/widgets/auth_card.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = "/auth";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(children: [
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Login RBTI",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              AuthCard()
            ],
          ),
        ),
      ]),
    );
  }
}
