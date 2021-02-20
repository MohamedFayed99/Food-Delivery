class User {
  String id;
  String name;
  String password;
  String mail;
  String phone = '';

  User({
    this.id,
    this.name,
    this.password,
    this.phone,
  });

  get getId => id;
  get getName => name;
  get getPassword => password;
  get getPhone => phone;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'password': this.password,
      'phone': this.phone,
    };
  }

  factory User.fromMap(Map map) {
    return User(
      name: map['name'],
      password: map['password'],
      id: map['id'],
      phone: map['phone'],
    );
  }
}
