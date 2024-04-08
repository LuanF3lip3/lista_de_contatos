import 'package:flutter/services.dart';

class NativeCalls{
  final MethodChannel channel = const MethodChannel('native_calls');

  Future<dynamic> getContacts() async {
    await channel.invokeMethod('getContacts');
  }
}