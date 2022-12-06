import 'package:flutter/cupertino.dart';

abstract class GenericFilter{
  String name;
  GenericFilterPositionType positionType;
  Function(String? text)  valueChange;

  GenericFilter({required this.name, required this.positionType, required this.valueChange});

  Widget getWidget();
}

enum GenericFilterPositionType {
  col,
  row
}