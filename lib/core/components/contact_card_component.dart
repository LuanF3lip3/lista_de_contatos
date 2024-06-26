import 'package:flutter/material.dart';
import 'package:udemy_lista_de_contatos/core/models/contact_model.dart';

class ContactCardComponent extends StatelessWidget {
  final ContactModel contact;
  final Function()? onTap;

  const ContactCardComponent({
    required this.contact,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap?.call();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: contact.name!.isEmpty ? null : Theme.of(context).primaryColor,
            ),
            child: contact.img == null
                ? contact.name!.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 75,
                        color: Colors.black,
                      )
                    : Center(
                        child: Text(
                          contact.name!.substring(0, 1).toUpperCase(),
                          style: const TextStyle(fontSize: 60, color: Colors.white),
                        ),
                      )
                : Image.memory(
                    contact.img!,
                    fit: BoxFit.fill,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(contact.name ?? "Nome não informado",
                    style: Theme.of(context).textTheme.titleMedium),
                Text(contact.email ?? "Email não informado",
                    style: Theme.of(context).textTheme.titleSmall),
                Text(contact.phone ?? "Telefone não informado",
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
