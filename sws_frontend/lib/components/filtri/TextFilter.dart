import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'GenericFilter.dart';

class TextFilter extends GenericFilter{
  TextFilter({
    required super.name,
    required super.positionType,
    required super.valueChange,
    this.delayMilliSec=750,
    this.textEditingController,
    this.debounce
  });
  Timer? debounce;
  int delayMilliSec;
  TextEditingController? textEditingController;

  @override
  Widget getWidget() {
    return TextField(
        cursorColor: Colors.black,
        controller: textEditingController ?? TextEditingController(),
        onChanged: (value) {
          if (debounce?.isActive ?? false){
            debounce?.cancel();
          }
          debounce =
              Timer(Duration(milliseconds: delayMilliSec), () {
                valueChange(value);
              });
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          fillColor: Colors.white,
          filled: true,
          hintText: name,
        ));
  }
}