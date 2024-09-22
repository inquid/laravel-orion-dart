import 'package:http/http.dart' as http;
import 'enums/auth_driver.dart';

class Orion {
  static late String baseUrl;
  static String prefix = 'api';
  static String? token;
  static AuthDriver authDriver =
      AuthDriver.defaultDriver; // Use the enum instead of a String.
  static late http.Client client;

  static void init(String baseUrl, {String? prefix, AuthDriver? authDriver}) {
    Orion.baseUrl = baseUrl;
    Orion.prefix = prefix ?? Orion.prefix;
    Orion.authDriver = authDriver ?? Orion.authDriver;
    client = http.Client();
  }

  static void setToken(String newToken) {
    token = newToken;
  }

  static void setAuthDriver(AuthDriver newAuthDriver) {
    authDriver = newAuthDriver;
  }

  static String getFullUrl(String endpoint) {
    print('$baseUrl/$prefix/$endpoint');

    return '$baseUrl/$prefix/$endpoint';
  }

  // Optional: If you need to get the auth driver as a string:
  static String getAuthDriverName() {
    return authDriver.name; // Use the extension to convert enum to a string.
  }
}
