import 'package:flutter_modular/flutter_modular.dart';
import 'package:udemy_lista_de_contatos/modulos/config/config_controller.dart';
import 'package:udemy_lista_de_contatos/modulos/config/config_page.dart';

class ConfigModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ConfigController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const ConfigPage(),
    ),
  ];
}
