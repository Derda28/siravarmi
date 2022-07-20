

import 'package:flutter/cupertino.dart';

class CustomScreenRoute extends PageRouteBuilder{

  final Widget child;

  CustomScreenRoute({
    required this.child
  }) : super(
      transitionDuration: Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child)=>
      ScaleTransition(
          child: child,
          scale: animation,
      );
}