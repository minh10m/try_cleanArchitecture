class UserModel {
  String? email;
  String? password;

  UserModel(String email, String password) {
    this.email = email;
    this.password = this.password;
  }
  static UserModel createUser(email, password) {
    return new UserModel(email, password);
  }
}