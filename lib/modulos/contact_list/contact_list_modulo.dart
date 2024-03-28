import 'package:flutter_modular/flutter_modular.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_controller.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_page.dart';

class ContactListModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ContactListController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ContactListPage()),
  ];
}