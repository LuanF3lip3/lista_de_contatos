import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:udemy_lista_de_contatos/app/app_widget.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_modulo.dart';

void main() {
  runApp(
    ModularApp(
      module: ContactListModule(),
      child: const AppWidget(),
    ),
  );
}
