abstract class AuthCredentials {
  final String emailName;
  final String password;

  AuthCredentials({this.emailName, this.password});
}

// 2
class LoginCredentials extends AuthCredentials {
  LoginCredentials({String userName, String password}) : super(emailName: userName, password: password);
}

// 3
class SignUpCredentials extends AuthCredentials {
  final String email;

  SignUpCredentials({String userName, String password, this.email}) : super(emailName: userName, password: password);
}
