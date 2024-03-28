import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:udemy_lista_de_contatos/modulos/add_contact/contact_page.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_controller.dart';
import 'package:udemy_lista_de_contatos/shared/components/contact_card_component.dart';
import 'package:udemy_lista_de_contatos/shared/enums/order_options.dart';
import 'package:udemy_lista_de_contatos/shared/models/contact_model.dart';
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
    controller.getAllContacts();
  }

  void _showContactPage({ContactModel? contact}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contact: contact,
        ),
      ),
    );
    controller.getAllContacts();
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
                        _showContactPage(contact: controller.contacts[index]);
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
            actions: [
              PopupMenuButton<OrderOptions>(
                itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                  PopupMenuItem(
                    value: OrderOptions.loadContacts,
                    child: Text(
                      "Carregar contatos do dispositivo",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
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
          body: ListView.builder(
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showContactPage();
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
