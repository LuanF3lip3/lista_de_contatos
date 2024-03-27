class ContactModel {
  static const String idColumn = "id";
  static const String nameColumn = "name";
  static const String emailColumn = "email";
  static const String phoneColumn = "phone";
  static const String imgColumn = "img";

  int? id;
  String? name;
  String? email;
  String? phone;
  String? img;

  ContactModel();

  ContactModel.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, image: $img)";
  }
}
