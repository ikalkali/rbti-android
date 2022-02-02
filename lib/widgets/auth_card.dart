import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:rbti_android/provider/auth.dart';
import 'package:rbti_android/screen/home_screen.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

enum AuthMode { Signup, Login }

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {};
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState!.save();
    try {
      if (_authMode == AuthMode.Login) {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'] as String,
          _authData['password'] as String,
        );
        setState(() {
          _isLoading = false;
        });
        Navigator.popUntil(context, ModalRoute.withName('/'));
      } else {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Auth>(context, listen: false).signup(User(
            nim: _authData['nim'] as String,
            nama: _authData['nama'] as String,
            nomorTelp: _authData['no_telp'] as String,
            email: _authData['email'] as String,
            password: _authData['password'] as String));

        _showInfoDialog();
        setState(() {
          _isLoading = false;
        });
      }
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(err.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Signup berhasil!'),
        content: Text("Akun berhasil dibuat, silakan login"),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  List<Widget> signupForm() {
    if (_authMode == AuthMode.Signup) {
      return [
        TextFormField(
          decoration: InputDecoration(label: Text("Nomor Induk")),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty || value.length < 5) {
              return 'Nomor Induk tidak boleh kosong!';
            }
          },
          onSaved: (value) {
            _authData['nim'] = value!;
          },
        ),
        TextFormField(
          decoration: InputDecoration(label: Text("Nama")),
          validator: (value) {
            if (value!.isEmpty || value.length < 5) {
              return 'Nama tidak boleh kosong!';
            }
          },
          onSaved: (value) {
            _authData['nama'] = value!;
          },
        ),
        TextFormField(
          decoration: InputDecoration(label: Text("Nomor HP")),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty || value.length < 5) {
              return 'Nomor Telepon tidak boleh kosong!';
            }
          },
          onSaved: (value) {
            _authData['no_telp'] = value!;
          },
        ),
      ];
    }
    return [SizedBox.shrink()];
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      child: Container(
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(label: Text("Email")),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text("Password")),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ...signupForm(),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                      onPressed: _submit,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(_authMode == AuthMode.Login
                                  ? 'LOGIN'
                                  : 'SIGN UP'),
                            )),
                      )),
                TextButton(
                  onPressed: () {
                    _switchAuthMode();
                  },
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
