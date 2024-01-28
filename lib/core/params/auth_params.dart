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
