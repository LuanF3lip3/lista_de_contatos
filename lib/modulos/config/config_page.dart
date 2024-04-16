import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:udemy_lista_de_contatos/core/components/config_item_component.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: ListView(
        children: [
          Text(
            "- Tema",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ConfigItemComponent(Text("Tema")),
        ],
      ),
    );
  }
}
