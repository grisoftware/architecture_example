import 'package:flutter/material.dart';

abstract class Controller with ChangeNotifier {
  @mustCallSuper
  Controller() {
    initListeners();
  }

  @protected
  void initListeners();
}
