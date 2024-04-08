import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ScaffoldMessengerComponent {
  BuildContext context = Modular.routerDelegate.navigatorKey.currentContext!;

  void showSnackBar({
    required String description,
    String? tapTitle,
    int? duration,
    Function()? onTap,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).shadowColor,
        content: SizedBox(
          height: double.parse(description.length.toString()),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Text(
                  tapTitle ?? "",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
          ),
        ),
        duration: Duration(seconds: duration ?? 3),
      ),
    );
  }
}
