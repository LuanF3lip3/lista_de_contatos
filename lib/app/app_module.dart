import 'package:flutter_modular/flutter_modular.dart';
import 'package:udemy_lista_de_contatos/modulos/config/config_modulo.dart';
import 'package:udemy_lista_de_contatos/modulos/contact/contact_modulo.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_modulo.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ModuleRoute("/", module: ContactListModule()),
    ModuleRoute("/contact/", module: ContactModule()),
    ModuleRoute("/config/", module: ConfigModule()),
  ];
}