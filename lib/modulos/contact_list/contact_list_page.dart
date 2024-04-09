import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_controller.dart';
import 'package:udemy_lista_de_contatos/core/components/contact_card_component.dart';
import 'package:udemy_lista_de_contatos/core/components/empty_message_component.dart';
import 'package:udemy_lista_de_contatos/core/enums/order_options.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  ContactListController controller = ContactListController();

  @override
  void initState() {
    super.initState();
    controller.getContactsFromDevice();
  }

  _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        // launch("sms: ${controller.contacts[index].phone}");
                        Future<void> makePhoneCall(String? phone) async {
                          final Uri launchUri = Uri(
                            scheme: 'sms',
                            path: phone ?? "",
                          );
                          await launchUrl(launchUri);
                        }

                        makePhoneCall("${controller.contacts[index].phone}");
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ligar",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        controller.goToContactPage(controller.contacts[index]);
                      },
                      child: Text(
                        "Editar",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        controller.helper.deleteContact(controller.contacts[index].id!);
                        setState(() {
                          controller.contacts.removeAt(index);
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "Excluir",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Contatos"),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            actions: [
              PopupMenuButton<OrderOptions>(
                icon: const Icon(Icons.filter_alt_sharp),
                itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                  PopupMenuItem(
                    value: OrderOptions.orderAZ,
                    child: Text(
                      "Ordenar de A-Z",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  PopupMenuItem(
                    value: OrderOptions.orderZA,
                    child: Text(
                      "Ordenar de Z-A",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
                onSelected: controller.orderList,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: controller.permissionToAccessContacts
              ? controller.contacts.isEmpty
                  ? const EmptyMessageComponent(
                      "Nenhum contato encontrado",
                      centralize: true,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: controller.contacts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ContactCardComponent(
                            contact: controller.contacts[index],
                            onTap: () {
                              _showOptions(context, index);
                            },
                          ),
                        );
                      },
                    )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const EmptyMessageComponent(
                      "Por favor, para ver os contatos, permita o aplicativo.",
                      centralize: true,
                    ),
                    FilledButton(
                      onPressed: () {
                        controller.allowContacts();
                      },
                      child: const Text("Permitir"),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.goToContactPage(null);
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}
