import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:udemy_lista_de_contatos/core/helpers/contact_helper.dart';
import 'package:udemy_lista_de_contatos/core/models/contact_model.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_controller.dart';

part 'contact_controller.g.dart';

class ContactController = ContactControllerBase with _$ContactController;

abstract class ContactControllerBase with Store {
  @observable
  TextEditingController nameController = TextEditingController();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController phoneController = TextEditingController();

  @observable
  String name = "";

  @observable
  String email = "";

  @observable
  String phone = "";

  @observable
  Uint8List? img;

  @observable
  FocusNode nameFocus = FocusNode();

  @observable
  ContactModel editedContact = ContactModel();

  @computed
  bool get userEdited => name.isNotEmpty || email.isNotEmpty || phone.isNotEmpty || img != null;

  @computed
  bool get contactValid => name.isNotEmpty && phone.isNotEmpty;

  @action
  void changeName(String value) {
    name = value;
    editedContact.name = name;
  }

  @action
  void changeEmail(String value) {
    email = value;
    editedContact.email = email;
  }

  @action
  void changePhone(String value) {
    phone = value;
    editedContact.phone = phone;
  }

  @action
  void changeImg(Uint8List? value) {
    img = value;
    editedContact.img = img;
  }

  @action
  void changeEditedContact(ContactModel value) {
    editedContact = value;
  }

  @action
  Future<void> saveContact() async {
    if (contactValid) {
      Contact contact = Contact(
        id: editedContact.id ?? "",
        photo:
            editedContact.img != null && editedContact.img!.isNotEmpty ? editedContact.img! : null,
        name: editedContact.name != null ? Name(first: editedContact.name!) : null,
        displayName: editedContact.name ?? "",
        phones: [Phone(editedContact.phone ?? "")],
        emails: [Email(editedContact.email ?? "")],
      );
      editedContact.id != null && editedContact.id!.isNotEmpty
          ? await FlutterContacts.updateContact(contact)
          : await FlutterContacts.insertContact(contact);
    }
  }

  @action
  void initPage(ContactModel? contact) {
    if (contact == null) {
      editedContact = ContactModel();
    } else {
      editedContact = ContactModel.fromMap(contact.toMap());
      changeImg(editedContact.img);
      changeName(editedContact.name ?? "");
      changeEmail(editedContact.email ?? "");
      changePhone(editedContact.phone ?? "");
      nameController.text = editedContact.name ?? "";
      emailController.text = editedContact.email ?? "";
      phoneController.text = editedContact.phone ?? "";
    }
  }
}
