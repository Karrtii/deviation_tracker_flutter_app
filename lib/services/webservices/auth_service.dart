import 'dart:convert';

import 'package:deviation_tracker_flutter_app/models/user_model.dart';
import 'package:http/http.dart';

class AuthService
{
  final String url = "http://karrtii.com:8080/api/auth";

  Future<UserModel?> loginUser(String username, String password) async {
    Map<String, dynamic> jsonMap =
    {
      "username":username,
      "password":password
    };

    try {
      Response responsePost = await post(
        Uri.parse("$url/login"), body: jsonMap,
      );
      Map tokens = jsonDecode(responsePost.body);

      print(responsePost.body);

      Response responseGet = await get(Uri.parse("$url/getUser"), headers: {
        "Authorization": "Bearer ${tokens['token']}"
      });

      print(responseGet.body);

      Map userDetails = jsonDecode(responseGet.body);
      UserModel user = UserModel(
          userId: userDetails['userId'],
          userEmail: userDetails['userEmail'],
          access_token: tokens['token'],
      );
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> registerUser(String userEmail, String password) async {

    Map<String, dynamic> jsonMap = {
      "userEmail": userEmail,
      "userPassword": password,
    };

    try{
      Response response = await post(
          Uri.parse("$url/register"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(jsonMap)
      );

      if(response.statusCode == 200)
        return true;
      else
        return false;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }
}