// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactController on ContactControllerBase, Store {
  Computed<bool>? _$userEditedComputed;

  @override
  bool get userEdited =>
      (_$userEditedComputed ??= Computed<bool>(() => super.userEdited,
              name: 'ContactControllerBase.userEdited'))
          .value;
  Computed<bool>? _$contactValidComputed;

  @override
  bool get contactValid =>
      (_$contactValidComputed ??= Computed<bool>(() => super.contactValid,
              name: 'ContactControllerBase.contactValid'))
          .value;

  late final _$nameControllerAtom =
      Atom(name: 'ContactControllerBase.nameController', context: context);

  @override
  TextEditingController get nameController {
    _$nameControllerAtom.reportRead();
    return super.nameController;
  }

  @override
  set nameController(TextEditingController value) {
    _$nameControllerAtom.reportWrite(value, super.nameController, () {
      super.nameController = value;
    });
  }

  late final _$emailControllerAtom =
      Atom(name: 'ContactControllerBase.emailController', context: context);

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  late final _$phoneControllerAtom =
      Atom(name: 'ContactControllerBase.phoneController', context: context);

  @override
  TextEditingController get phoneController {
    _$phoneControllerAtom.reportRead();
    return super.phoneController;
  }

  @override
  set phoneController(TextEditingController value) {
    _$phoneControllerAtom.reportWrite(value, super.phoneController, () {
      super.phoneController = value;
    });
  }

  late final _$nameAtom =
      Atom(name: 'ContactControllerBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$emailAtom =
      Atom(name: 'ContactControllerBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: 'ContactControllerBase.phone', context: context);

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$imgAtom =
      Atom(name: 'ContactControllerBase.img', context: context);

  @override
  Uint8List? get img {
    _$imgAtom.reportRead();
    return super.img;
  }

  @override
  set img(Uint8List? value) {
    _$imgAtom.reportWrite(value, super.img, () {
      super.img = value;
    });
  }

  late final _$nameFocusAtom =
      Atom(name: 'ContactControllerBase.nameFocus', context: context);

  @override
  FocusNode get nameFocus {
    _$nameFocusAtom.reportRead();
    return super.nameFocus;
  }

  @override
  set nameFocus(FocusNode value) {
    _$nameFocusAtom.reportWrite(value, super.nameFocus, () {
      super.nameFocus = value;
    });
  }

  late final _$editedContactAtom =
      Atom(name: 'ContactControllerBase.editedContact', context: context);

  @override
  ContactModel get editedContact {
    _$editedContactAtom.reportRead();
    return super.editedContact;
  }

  @override
  set editedContact(ContactModel value) {
    _$editedContactAtom.reportWrite(value, super.editedContact, () {
      super.editedContact = value;
    });
  }

  late final _$saveContactAsyncAction =
      AsyncAction('ContactControllerBase.saveContact', context: context);

  @override
  Future<void> saveContact() {
    return _$saveContactAsyncAction.run(() => super.saveContact());
  }

  late final _$ContactControllerBaseActionController =
      ActionController(name: 'ContactControllerBase', context: context);

  @override
  void changeName(String value) {
    final _$actionInfo = _$ContactControllerBaseActionController.startAction(
        name: 'ContactControllerBase.changeName');
    try {
      return super.changeName(value);
    } finally {
      _$ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEmail(String value) {
    final _$actionInfo = _$ContactControllerBaseActionController.startAction(
        name: 'ContactControllerBase.changeEmail');
    try {
      return super.changeEmail(value);
    } finally {
      _$ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePhone(String value) {
    final _$actionInfo = _$ContactControllerBaseActionController.startAction(
        name: 'ContactControllerBase.changePhone');
    try {
      return super.changePhone(value);
    } finally {
      _$ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeImg(Uint8List? value) {
    final _$actionInfo = _$ContactControllerBaseActionController.startAction(
        name: 'ContactControllerBase.changeImg');
    try {
      return super.changeImg(value);
    } finally {
      _$ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEditedContact(ContactModel value) {
    final _$actionInfo = _$ContactControllerBaseActionController.startAction(
        name: 'ContactControllerBase.changeEditedContact');
    try {
      return super.changeEditedContact(value);
    } finally {
      _$ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initPage(ContactModel? contact) {
    final _$actionInfo = _$ContactControllerBaseActionController.startAction(
        name: 'ContactControllerBase.initPage');
    try {
      return super.initPage(contact);
    } finally {
      _$ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nameController: ${nameController},
emailController: ${emailController},
phoneController: ${phoneController},
name: ${name},
email: ${email},
phone: ${phone},
img: ${img},
nameFocus: ${nameFocus},
editedContact: ${editedContact},
userEdited: ${userEdited},
contactValid: ${contactValid}
    ''';
  }
}
