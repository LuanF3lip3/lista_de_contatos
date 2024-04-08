import 'package:flutter/material.dart';

class EmptyMessageComponent extends StatelessWidget {
  final String? message;
  final EdgeInsets? padding;
  final bool? centralize;

  const EmptyMessageComponent(
    this.message, {
    this.padding,
    this.centralize = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return centralize!
        ? Center(
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: Text(
                message ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          )
        : Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Text(
              message ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
  }
}
