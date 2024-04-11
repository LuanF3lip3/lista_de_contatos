import 'dart:typed_data';

class ContactModel {
  static const String idColumn = "id";
  static const String nameColumn = "name";
  static const String emailColumn = "email";
  static const String phoneColumn = "phone";
  static const String imgColumn = "img";

  String? id;
  String? name;
  String? email;
  String? phone;
  Uint8List? img;

  ContactModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.img,
  });

  ContactModel.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      idColumn: id,
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
    };
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, image: $img)";
  }
}
