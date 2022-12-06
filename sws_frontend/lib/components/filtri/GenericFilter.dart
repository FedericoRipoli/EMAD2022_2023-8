import 'package:flutter/cupertino.dart';

class GenericFilter{
  String name;
  GenericFilterPositionType positionType;
  Function(String text)  valueChange;

  GenericFilter({required this.name, required this.positionType, required this.valueChange});
}

enum GenericFilterPositionType {
  col,
  row
}