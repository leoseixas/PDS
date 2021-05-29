class User {
  User(
      {this.name,
      this.email,
      this.phone,
      this.password,
      this.id,
      this.createdAt});

  String id;
  String name;
  String email;
  String phone;
  String password;
  DateTime createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, password: $password, createdAt: $createdAt}';
  }
}
