// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactListController on ContactListControllerBase, Store {
  late final _$helperAtom =
      Atom(name: 'ContactListControllerBase.helper', context: context);

  @override
  ContactHelper get helper {
    _$helperAtom.reportRead();
    return super.helper;
  }

  @override
  set helper(ContactHelper value) {
    _$helperAtom.reportWrite(value, super.helper, () {
      super.helper = value;
    });
  }

  late final _$getContactsFromDeviceAsyncAction = AsyncAction(
      'ContactListControllerBase.getContactsFromDevice',
      context: context);

  @override
  Future<void> getContactsFromDevice() {
    return _$getContactsFromDeviceAsyncAction
        .run(() => super.getContactsFromDevice());
  }

  late final _$ContactListControllerBaseActionController =
      ActionController(name: 'ContactListControllerBase', context: context);

  @override
  void getAllContacts() {
    final _$actionInfo = _$ContactListControllerBaseActionController
        .startAction(name: 'ContactListControllerBase.getAllContacts');
    try {
      return super.getAllContacts();
    } finally {
      _$ContactListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void orderList(OrderOptions result) {
    final _$actionInfo = _$ContactListControllerBaseActionController
        .startAction(name: 'ContactListControllerBase.orderList');
    try {
      return super.orderList(result);
    } finally {
      _$ContactListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
helper: ${helper}
    ''';
  }
}
