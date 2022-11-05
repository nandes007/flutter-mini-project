import 'package:laundry_app/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  final String _token = '';

  Future<bool> saveToken(Auth auth) async {
    final store = await SharedPreferences.getInstance();
    final token = await store.setString(_token, auth.token);
    if (token) return true;
    return false;
  }

  Future<Auth?> getToken() {
    return Future(() async {
      final store = await SharedPreferences.getInstance();
      final token = store.getString(_token);

      if (token != null) {
        return Auth(token);
      }

      return null;
    });
  }

  Future<bool> removeToken() async {
    final store = await SharedPreferences.getInstance();
    final token = await store.remove(_token);

    if (token) return true;

    return false;
  }

  Future<bool> isLogin() async {
    var currentToken = await getToken();
    if (currentToken != null) return true;
    return false;
  }
}
