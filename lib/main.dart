import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:udemy_lista_de_contatos/app/app_module.dart';
import 'package:udemy_lista_de_contatos/app/app_widget.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
