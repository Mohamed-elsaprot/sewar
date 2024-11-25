import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalWithMaterialPage extends Page {
  final Widget child;

  const ModalWithMaterialPage({required this.child, super.key});

  @override
  Route createRoute(BuildContext context) {
    return MaterialWithModalsPageRoute(
      settings: this,
      builder: (BuildContext context) => child,
    );
  }
}