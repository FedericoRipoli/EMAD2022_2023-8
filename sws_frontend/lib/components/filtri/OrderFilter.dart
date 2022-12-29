import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'GenericFilter.dart';

class OrderFilter extends GenericFilter {
  OrderFilter(
      {required super.name, required super.positionType, required super.valueChange,super.flex=1});


  @override
  Widget getWidget() {
    // TODO: implement getWidget
    return IconButton(

      color: AppColors.white,

      icon: const Icon(Icons.sort),
      tooltip: 'Ordina',
      onPressed: () {


      },
    );
  }


}