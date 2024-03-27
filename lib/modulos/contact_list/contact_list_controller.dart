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
        break;case OrderOptions.loadContacts:
        contacts.sort(
              (a, b) {
            return b.name!.toLowerCase().compareTo(a.name!.toLowerCase());
          },
        );
        break;
    }
  }
}