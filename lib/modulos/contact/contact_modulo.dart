import 'package:flutter_modular/flutter_modular.dart';
import 'package:udemy_lista_de_contatos/modulos/contact/contact_controller.dart';
import 'package:udemy_lista_de_contatos/modulos/contact/contact_page.dart';

class ContactModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ContactController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => ContactPage(
        contact: args.params[0],
      ),
    ),
  ];
}
