import 'package:flutter_contacts/utils/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  login() {
    var dio = CustomDio().instance;
    dio.post("http://10.0.0.109:3000/login",
        data: {"user": "w1ll-dev", "pswd": "12345"}).then((res) async {
      print("token: ${res.data["token"]}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', res.data["token"]);
    }).catchError((onError) {
      throw Exception("Invalid username or password");
    });
  }
}
