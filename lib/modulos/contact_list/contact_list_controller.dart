import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:udemy_lista_de_contatos/app/app_routes.dart';
import 'package:udemy_lista_de_contatos/core/enums/order_options.dart';
import 'package:udemy_lista_de_contatos/core/helpers/contact_helper.dart';
import 'package:udemy_lista_de_contatos/core/models/contact_model.dart';

part 'contact_list_controller.g.dart';

class ContactListController = ContactListControllerBase with _$ContactListController;

abstract class ContactListControllerBase with Store {
  ObservableList<ContactModel> contacts = ObservableList();

  @observable
  bool permissionToAccessContacts = true;

  @observable
  ContactHelper helper = ContactHelper();

  @action
  void changePermissionToAccessContacts(bool val) => permissionToAccessContacts = val;

  @action
  Future<void> allowContacts() async {
    await openAppSettings();
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
    }
  }

  @action
  Future<void> getContactsFromDevice() async {
    if (await FlutterContacts.requestPermission()) {
      changePermissionToAccessContacts(true);
      List<Contact> contacts = await FlutterContacts.getContacts();
      List<ContactModel> newContacts = [];
      for (var contact in contacts) {
        ContactModel newContact = ContactModel(
          name: contact.displayName,
          email: contact.phones.isNotEmpty ? contact.phones.first.number : null,
          phone: contact.phones.isNotEmpty ? contact.phones.first.number : null,
          img: contact.photo != null ? File.fromRawPath(contact.photo!).path : null,
        );
        newContacts.add(newContact);
      }
      this.contacts.clear();
      this.contacts.addAll(ObservableList.of([...newContacts]));
      this.contacts.sort(
        (a, b) {
          return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
        },
      );
    } else {
      changePermissionToAccessContacts(false);
    }
  }
}
