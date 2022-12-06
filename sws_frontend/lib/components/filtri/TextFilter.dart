import 'dart:async';

import 'GenericFilter.dart';

class TextFilter extends GenericFilter{
  TextFilter({
    required super.name,
    required super.positionType,
    required super.valueChange,
    this.delayMilliSec=750,
    this.debounce
  });
  Timer? debounce;
  int delayMilliSec;
}