import 'package:flutter/material.dart';

class ConfigItemComponent extends StatelessWidget {
  final Widget? content;
  final double? height;

  const ConfigItemComponent(this.content, {this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      width: MediaQuery.of(context).size.width * .88,
      decoration:
      BoxDecoration(
        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue,
                        Colors.red,
                      ],
                    )
      ),
      height: height ?? 50,
      // color: Theme.of(context).shadowColor,
      child: Center(child: content),
    );
  }
}
