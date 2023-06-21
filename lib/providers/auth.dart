import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  late String _token;
  DateTime? _expiryDate = DateTime.now();
  String _userid = '';
  late Timer? _authTimer = null;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userid;
  }

  String? get token {
    if (_expiryDate != null) {
      if (_expiryDate!.isAfter(DateTime.now())) {
        return _token;
      }
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAw7IhJalsmXKjoGf7Vol_pDo1nMELtnsI');
    try {
      final response = await http
          .post(url,
              body: json.encode({
                'email': email,
                'password': password,
                'returnSecureToken': true,
              }))
          .timeout(Duration(seconds: 100));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      _token = responseData['idToken'];
      _userid = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userid': _userid,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryDate;
    if (prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData').toString());
    if (extractedUserData != null) {
      expiryDate = DateTime.parse(extractedUserData['expiryDate'].toString());

      if (expiryDate.isBefore(DateTime.now())) {
        return false;
      }
      _token = extractedUserData['token'].toString();
      _userid = extractedUserData['userid'].toString();
      _expiryDate = DateTime.parse(extractedUserData['expiryDate'].toString());
      notifyListeners();
      autoLogout();
    }
    return true;
  }

  Future<void> logout() async {
    _token = '';
    _userid = '';
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    _authTimer = Timer(Duration(minutes: 5), logout);
  }
}
