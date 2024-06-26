import 'package:flutter_modular/flutter_modular.dart';
import 'package:udemy_lista_de_contatos/core/models/contact_model.dart';

class AppRoutes {
  static const String routeContactList = "/";
  static const String routeContact = "/contact/";
  static const String routeConfig = "/config/";

  static void goToContactListPage() {
    Modular.to.pushNamed(routeContactList);
  }

  static void goToConfigPage() {
    Modular.to.pushNamed(routeConfig);
  }

  static Future<void> goToContact(ContactModel? contact) async {
    await Modular.to.pushNamed(routeContact, arguments: contact);
  }
}
