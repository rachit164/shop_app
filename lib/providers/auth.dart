import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCZw75XRmrcwNocfX_TkK_7HA4K38beGeY');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
    //   print(json.decode(response.body));
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
    // final url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCZw75XRmrcwNocfX_TkK_7HA4K38beGeY');
    // final response = await http.post(
    //   url,
    //   body: json.encode(
    //     {'email': email, 'password': password, 'returnSecureToken': true},
    //   ),
    // );
    // print(json.decode(response.body));
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
  //   final url = Uri.parse(
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCZw75XRmrcwNocfX_TkK_7HA4K38beGeY');
  //   final response = await http.post(
  //     url,
  //     body: json.encode(
  //       {'email': email, 'password': password, 'returnSecureToken': true},
  //     ),
  //   );
  //   print(json.encode(response.body));
  // }

}
