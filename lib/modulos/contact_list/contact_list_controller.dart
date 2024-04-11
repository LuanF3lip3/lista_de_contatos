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
  Future<void> goToContactPage(ContactModel? contact) async{
    await AppRoutes.goToContact(contact);
    getContactsFromDevice();
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
        final Contact? c = await FlutterContacts.getContact(contact.id);
        if (c != null) {
          ContactModel newContact = ContactModel(
            id: c.id,
            name: c.displayName,
            email: c.emails.isNotEmpty ? c.emails.first.address : null,
            phone: c.phones.isNotEmpty ? c.phones.first.number : null,
            img: c.photo,
          );
          newContacts.add(newContact);
        }
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

  Future<void> deleteContact(ContactModel contactModel, int index) async {
    Contact? contactOrigin = await FlutterContacts.getContact(
        contactModel.id ?? "");
    if (contactOrigin != null) {
      FlutterContacts.deleteContact(contactOrigin);
      contacts.removeAt(index);
    }
  }
}
