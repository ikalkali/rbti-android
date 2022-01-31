import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rbti_android/helper/api.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Auth with ChangeNotifier {
  String? _token = "";
  DateTime? _expiryDate = null;
  String? _nim = "";

  User? _user;

  bool get isAuth {
    return _token != "";
  }

  String get nim {
    return _nim!;
  }

  User? get userData {
    return _user;
  }

  Future<void> signup(User user) async {
    const url = APILink.apiLink + "/signup";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "nim": user.nim,
            "email": user.email,
            "password": user.password,
            "nomor_telp": user.nomorTelp
          }));

      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw responseData["error"][0];
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> getDataUser() async {
    final url = APILink.apiLink + "/api/mahasiswa?nim=" + _nim!;
    print("URL ${url}");
    try {
      final resp = await http.get(Uri.parse(url));
      final respData = json.decode(resp.body)["data"] as Map<String, dynamic>;

      var user = User(
        email: respData["email"],
        nama: respData["nama"],
        nomorTelp: respData["nomor_telp"],
        nim: respData["nim"],
      );

      // print("DATA USER ${user}");

      _user = user;
    } catch (err) {
      throw err;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expire'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'] as String;
    _nim = extractedUserData['nim'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _nim = null;
    _expiryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> login(String email, String password) async {
    const url = APILink.apiLink + "/login";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
          }));

      final responseData = json.decode(response.body);
      if (responseData["code"] != 200) {
        throw responseData["message"];
      }

      Map<String, dynamic> payload =
          Jwt.parseJwt(responseData["token"] as String);

      _token = responseData["token"];
      _expiryDate = DateTime.parse(responseData["expire"]);
      _nim = payload["nim"];

      getDataUser();
      notifyListeners();

      // decode token to get nim

      final prefs = await SharedPreferences.getInstance();
      print("NIM ${payload['nim']}");
      final userData = json.encode({
        'token': _token,
        'nim': payload["nim"],
        'expire': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (err) {
      throw err;
    }
  }
}

class User {
  String nim;
  String nama;
  String nomorTelp;
  String email;
  String? password;
  int? angkatan;

  User(
      {required this.nim,
      required this.nama,
      required this.nomorTelp,
      required this.email,
      this.password,
      this.angkatan});
}
