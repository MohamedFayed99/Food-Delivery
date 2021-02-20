class Vendor {
  String id;
  String mangerName;
  String password;
  String mail;
  String phone = '';
  String address;
  String name;
  List<String> natuerFood = [];

  Vendor({
    this.mangerName,
    this.natuerFood,
    this.id,
    this.name,
    this.password,
    this.phone,
  });

  get getId => id;
  get getName => name;
  get getPassword => password;
  get getPhone => phone;
  get getManger => mangerName;
  get getNatureFood => natuerFood;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'password': this.password,
      'phone': this.phone,
      'mangerName': this.mangerName,
      'NatureFood': this.natuerFood
    };
  }

  factory Vendor.fromMap(Map map) {
    return Vendor(
      mangerName: map['mangerName'],
      natuerFood: map['natureFood'],
      name: map['name'],
      password: map['password'],
      id: map['id'],
      phone: map['phone'],
    );
  }
}
