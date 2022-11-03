import 'package:flutter/material.dart';

class CustomRoute extends MaterialPageRoute {
  CustomRoute({
    required WidgetBuilder builder,
  }) : super(
          builder: builder,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/') {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
