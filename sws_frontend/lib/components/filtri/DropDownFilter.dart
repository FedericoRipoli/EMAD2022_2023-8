import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'GenericFilter.dart';

class DropDownFilter extends GenericFilter {
  List<DropDownFilterItem> values;
  String? defaultValue;

  DropDownFilter(
      {required super.name,
      required super.positionType,
      required super.valueChange,
      required this.values,
      this.defaultValue,
      super.flex = 1});

  @override
  Widget getWidget() {
    // TODO: implement getWidget
    return DropdownButtonFormField2(
        decoration: InputDecoration(
            //Add isDense true and zero Padding.
            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(width: 1, color: AppColors.logoBlue),
            ),
            fillColor: Colors.white,
            filled: true
            //Add more decoration as you want here
            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
        isExpanded: true,
        hint: Text(
          name,
          style: const TextStyle(fontSize: 14),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        iconSize: 30,
        buttonHeight: 60,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: values,
        value: defaultValue,
        onChanged: valueChange);
  }
}

class DropDownFilterItem extends DropdownMenuItem<String> {
  final String? id;
  final String name;

  DropDownFilterItem({
    super.key,
    this.id,
    required this.name,
  }) : super(
          value: id,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11.7),
          ),
        );
}
