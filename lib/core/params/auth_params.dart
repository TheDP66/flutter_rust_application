class RegisterUserParams {
  String email;
  String name;
  String password;
  String passwordConfirm;

  RegisterUserParams({
    required this.email,
    required this.name,
    required this.password,
    required this.passwordConfirm,
  });
}

class LoginUserParams {
  String email;
  String password;

  LoginUserParams({
    required this.email,
    required this.password,
  });
}
