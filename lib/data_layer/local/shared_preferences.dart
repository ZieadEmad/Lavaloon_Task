import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;

Future<void> sharedPreferences() async {
  preferences = await SharedPreferences.getInstance();
}

//save token
Future<bool> saveUserToken(String userToken) => preferences.setString('userToken', userToken);
Future<bool> removeUserToken() => preferences.remove('userToken');
String? getUserToken() => preferences.getString('userToken');

//save user id
Future<bool> saveUserId(String userId) => preferences.setString('userId', userId);
Future<bool> removeUserId() => preferences.remove('userId');
String? getUserId() => preferences.getString('userId');

//save session id
Future<bool> saveSessionId(String sessionId) => preferences.setString('sessionId', sessionId);
Future<bool> removeSessionId() => preferences.remove('sessionId');
String? getSessionId() => preferences.getString('sessionId');


