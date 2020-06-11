// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ntlm/ntlm.dart';

class Authentication {
  static Future<bool> getAuthentication() async {
    return Future.delayed(Duration(milliseconds: 1000), () => true);
  }

  static Future<http.Response> authenticate(
      {String username, String password}) async {
    NTLMClient client = NTLMClient(
      domain: "",
      workstation: "LAPTOP",
      username: username,
      password: password,
    );

    return client.get(
      "http://12.216.81.220:88/api/AuthenticateUser",
    );
  }
}
