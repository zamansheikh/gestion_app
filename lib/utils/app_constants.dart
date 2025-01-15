
class AppConstants{

  static String APP_NAME="project_template";
  static String bearerToken = "bearerToken";
  static String email = "email";
  static String name = "name";
  static String pas = "pas";
  static String role = "role";
  static String userId = "userId";
  static String user = "user";
  static String image = "image";
  static String isLogged = "isLogged";
  static String lat = "lat";
  static String log = "log";

  // share preference Key
  static String THEME ="theme";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
  );


}