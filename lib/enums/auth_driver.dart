// auth_driver.dart
enum AuthDriver {
  defaultDriver,
  passport,
  sanctum,
}

extension AuthDriverExtension on AuthDriver {
  String get name {
    switch (this) {
      case AuthDriver.defaultDriver:
        return 'default';
      case AuthDriver.passport:
        return 'passport';
      case AuthDriver.sanctum:
        return 'sanctum';
      default:
        return '';
    }
  }
}
