class User {
  String? email;
  String? name;

  User(String email, String name) {
    this.email = email;
    this.name = this.name;
  }
  static User createUser(email, name) {
    return new User(email, name);
  }
}