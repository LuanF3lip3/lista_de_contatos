import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_lista_de_contatos/core/models/contact_model.dart';

const String contactTable = "contactTable";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsnew.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async {
        await db.execute("CREATE TABLE $contactTable("
            "${ContactModel.idColumn} INTEGER PRIMARY KEY,"
            "${ContactModel.nameColumn} TEXT,"
            "${ContactModel.emailColumn} TEXT,"
            "${ContactModel.phoneColumn} TEXT,"
            "${ContactModel.imgColumn} TEXT)");
      },
    );
  }

  Future<ContactModel> saveContact(ContactModel contact) async {
    Database dbContact = await db;
    // contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<ContactModel> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      contactTable,
      columns: [
        ContactModel.idColumn,
        ContactModel.nameColumn,
        ContactModel.emailColumn,
        ContactModel.phoneColumn,
        ContactModel.imgColumn
      ],
      where: "${ContactModel.idColumn} = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ContactModel.fromMap(maps.first);
    } else {
      return ContactModel.fromMap(maps.single);
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "${ContactModel.idColumn} = ?", whereArgs: [id]);
  }

  Future<int> updateContact(ContactModel contact) async {
    Database dbContact = await db;
    return await dbContact.update(
      contactTable,
      contact.toMap(),
      where: "${ContactModel.idColumn} = ?",
      whereArgs: [contact.id],
    );
  }

  Future<List> getAllContact() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<ContactModel> listContact = [];
    for (Map m in listMap) {
      listContact.add(ContactModel.fromMap(m));
    }
    return listContact;
  }

  Future<int?> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    await dbContact.close();
  }
}
