import 'package:shared_preferences/shared_preferences.dart';

class Data {
  SharedPreferences spref;

  Future<bool> setUName(String uname) async {
     spref = await SharedPreferences.getInstance();
    return spref.setString('uname', uname);
  }

  Future<String> getUName() async {
    spref = await SharedPreferences.getInstance();
    return spref.getString('uname');
  }

  Future<bool> setLanguage(String uname) async {
    spref = await SharedPreferences.getInstance();
    return spref.setString('language', uname);
  }

}
