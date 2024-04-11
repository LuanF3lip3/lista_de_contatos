import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_lista_de_contatos/modulos/contact/contact_controller.dart';
import 'package:udemy_lista_de_contatos/core/models/contact_model.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_controller.dart';

class ContactPage extends StatefulWidget {
  final ContactModel? contact;

  const ContactPage({this.contact, Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  EdgeInsets inputPadding = const EdgeInsets.only(top: 15, left: 15, right: 15);

  @override
  void initState() {
    super.initState();
    controller.initPage(widget.contact);
  }

  final controller = ContactController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        return CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: const Text("Novo Contato"),
              stretch: true,
              forceElevated: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.28,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.21,
                          width: MediaQuery.of(context).size.height * 0.21,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: controller.img == null
                              ? Icon(
                                  Icons.person,
                                  size: MediaQuery.of(context).size.height * 0.16,
                                  color: Theme.of(context).hoverColor,
                                )
                              : Image.memory(
                                  controller.img!,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Positioned(
                          right: 4,
                          bottom: 8,
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Theme.of(context).hoverColor,
                              shape: const CircleBorder(),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.white,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return _dialog(context);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Padding(
                    padding: inputPadding,
                    child: TextField(
                      cursorColor: Colors.black,
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
                    padding: inputPadding,
                    child: TextField(
                      cursorColor: Colors.black,
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
                    padding: inputPadding,
                    child: TextField(
                      cursorColor: Colors.black,
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
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (controller.contactValid) {
            try {
              await controller.saveContact();
            } catch (err) {
              debugPrint(err.toString());
            }
            if (mounted) {
              Navigator.pop(context);
              ContactListController().getContactsFromDevice();
            }
          } else {
            FocusScope.of(context).requestFocus(controller.nameFocus);
          }
        },
        child: const Icon(
          Icons.save,
        ),
      ),
    );
  }

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

  AlertDialog _dialog(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Alterar imagem?")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).hoverColor, shape: BoxShape.circle),
                child: IconButton(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    Modular.to.pop();
                    ImagePicker().pickImage(source: ImageSource.camera).then(
                      (file) {
                        if (file == null) {
                          return;
                        } else {
                          file.readAsBytes().then((value) => controller.changeImg(value));
                        }
                      },
                    );
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).hoverColor, shape: BoxShape.circle),
                child: IconButton(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    Modular.to.pop();
                    ImagePicker().pickImage(source: ImageSource.gallery).then(
                      (file) {
                        if (file == null) {
                          return;
                        } else {
                          file.readAsBytes().then((value) => controller.changeImg(value));
                        }
                      },
                    );
                  },
                  icon: const Icon(Icons.image),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).hoverColor, shape: BoxShape.circle),
                child: IconButton(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    Modular.to.pop();
                    controller.changeImg(null);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: const Text("Não"),
            ),
          ),
        ],
      ),
    );
  }
}
