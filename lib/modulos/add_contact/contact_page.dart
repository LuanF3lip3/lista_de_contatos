import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_lista_de_contatos/modulos/add_contact/contact_controller.dart';
import 'package:udemy_lista_de_contatos/shared/constants.dart';
import 'package:udemy_lista_de_contatos/shared/models/contact_model.dart';

class ContactPage extends StatefulWidget {
  final ContactModel? contact;

  const ContactPage({this.contact, Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      controller.editedContact = ContactModel();
    } else {
      controller.editedContact = ContactModel.fromMap(widget.contact!.toMap());

      controller.nameController.text = controller.editedContact.name ?? "";
      controller.emailController.text = controller.editedContact.email ?? "";
      controller.phoneController.text = controller.editedContact.phone ?? "";
    }
  }

  final controller = ContactController();

  Future<bool> _requestPop() {
    if (controller.userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Você realmente deseja sair?"),
              content: const Text("Se sair as alteraçoes serao perdidas."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Sim"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Não"),
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _requestPop(),
      child: Observer(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Novo Contato"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.editedContact.img == null
                    ? Container(
                        padding: const EdgeInsets.only(bottom: 35, top: 10),
                        child: IconButton(
                          iconSize: 140,
                          onPressed: () {
                            ImagePicker().pickImage(source: ImageSource.camera).then(
                              (file) {
                                if (file == null) {
                                  return;
                                } else {
                                  controller.editedContact.img = file.path;
                                }
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.person,
                            size: 140,
                          ),
                        ),
                      )
                    : GestureDetector(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(
                                File(
                                  controller.editedContact.img!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          controller.editedContact.img = null;
                        },
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextField(
                    controller: controller.nameController,
                    focusNode: controller.nameFocus,
                    decoration: const InputDecoration(labelText: "Nome"),
                    style: Theme.of(context).textTheme.titleSmall,
                    onChanged: (text) {
                      controller.changeName(text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(labelText: "E-mail"),
                    style: Theme.of(context).textTheme.titleSmall,
                    onChanged: (text) {
                      controller.changeEmail(text);
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextField(
                    controller: controller.phoneController,
                    decoration: const InputDecoration(labelText: "Telefone"),
                    style: Theme.of(context).textTheme.titleSmall,
                    onChanged: (text) {
                      controller.changePhone(text);
                    },
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (controller.contactValid) {
                controller.saveContact();
                Navigator.pop(context);
              } else {
                FocusScope.of(context).requestFocus(controller.nameFocus);
              }
            },
            child: const Icon(
              Icons.save,
            ),
          ),
        );
      }),
    );
  }
}
