import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:udemy_lista_de_contatos/app/app_routes.dart';
import 'package:udemy_lista_de_contatos/core/enums/order_options.dart';
import 'package:udemy_lista_de_contatos/core/helpers/contact_helper.dart';
import 'package:udemy_lista_de_contatos/core/models/contact_model.dart';
import 'package:udemy_lista_de_contatos/core/ui/scaffold_messenger_component.dart';

part 'contact_list_controller.g.dart';

class ContactListController = ContactListControllerBase with _$ContactListController;

abstract class ContactListControllerBase with Store {
  ObservableList<ContactModel> contacts = ObservableList();

  @observable
  ContactHelper helper = ContactHelper();

  @action
  void getAllContacts() {
    helper.getAllContact().then(
      (list) {
        contacts.clear();
        contacts.addAll(ObservableList.of([...list]));
        contacts.sort(
          (a, b) {
            return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
          },
        );
      },
    );
  }

  @action
  void goToContactPage(ContactModel? contact) {
    AppRoutes.goToContact(contact);
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
      List<ContactModel> newContacts = [];
      for (var contact in contacts) {
        var rep = this.contacts.where((element) => element.name == contact.displayName);
        if (rep.isNotEmpty) {
          await helper.deleteContact(rep.first.id ?? 0);
        }
        ContactModel newContact = ContactModel(
          name: contact.displayName,
          email: contact.phones.isNotEmpty ? contact.phones.first.number : null,
          phone: contact.phones.isNotEmpty ? contact.phones.first.number : null,
          img: contact.photo != null ? File.fromRawPath(contact.photo!).path : null,
        );
        newContacts.add(newContact);
      }
      for (var contact in newContacts) {
        await helper.saveContact(contact);
      }
      getAllContacts();
    } else {
      ScaffoldMessengerComponent().showSnackBar(
        description: "Permissão negada! Permita o acesso aos contatos para continuar.",
        tapTitle: "Permitir",
        onTap: () {
          openAppSettings();
        },
        duration: 4,
      );
    }
  }
}
