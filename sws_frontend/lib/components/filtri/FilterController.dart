
import 'package:flutter/material.dart';
import 'dart:async';

class FilterTextController extends TextEditingController{
  String textPlaceholder;
  Function(String text) f;
  Timer? _debounce;
  int delayMilliSec;

  FilterTextController({
    this.textPlaceholder = '',
    required this.f,
    this.delayMilliSec = 500
  });

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }


  String get placeholder => textPlaceholder;

  set placeholder(String newPlaceholder) {
    textPlaceholder = newPlaceholder;
  }

  void runFiltering(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer( Duration(milliseconds: delayMilliSec), () {
      f(value);
    });
  }
}