import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:udemy_lista_de_contatos/shared/enums/order_options.dart';
import 'package:udemy_lista_de_contatos/shared/helpers/contact_helper.dart';
import 'package:udemy_lista_de_contatos/shared/models/contact_model.dart';

part 'contact_list_controller.g.dart';

class ContactListController = ContactListControllerBase with _$ContactListController;

abstract class ContactListControllerBase with Store {
  ObservableList<ContactModel> contacts = ObservableList();

  @observable
  ContactHelper helper = ContactHelper();

  @action
  void getAllContacts() {
    helper.getAllContact().then((list) {
      contacts.clear();
      contacts.addAll(ObservableList.of([...list]));
    });
  }

  @action
  void orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderAZ:
        contacts.sort(
          (a, b) {
            return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
          },
        );
        break;
      case OrderOptions.orderZA:
        contacts.sort(
          (a, b) {
            return b.name!.toLowerCase().compareTo(a.name!.toLowerCase());
          },
        );
        break;
      case OrderOptions.loadContacts:
        getContactsFromDevice();
        break;
    }
  }

  @action
  Future<void> getContactsFromDevice() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts();
      print(contacts);
    } else {
      showBottomSheet(
        context: Modular.routerDelegate.navigatorKey.currentContext!,
        builder: (context) {
          return Container(
            child: Text("Para trazer os contatos do dispositivo, e necessario aceitar a permissão"),
          );
        },
      );
    }
  }
}
