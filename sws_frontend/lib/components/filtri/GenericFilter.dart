import 'package:flutter/cupertino.dart';

abstract class GenericFilter{
  String name;
  GenericFilterPositionType positionType;
  Function(String? text)  valueChange;
  int flex;
  GenericFilter({required this.name, required this.positionType, required this.valueChange, this.flex=1});

  Widget getWidget();
}

enum GenericFilterPositionType {
  col,
  row
}