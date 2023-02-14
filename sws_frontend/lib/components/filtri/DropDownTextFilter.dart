import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'DropDownFilter.dart';
import 'GenericFilter.dart';

class DropDownTextFilter extends GenericFilter {
  List<DropDownFilterItem> values;
  TextEditingController textEditingController = TextEditingController();
  DropDownTextFilter(
      {required super.name,
      required super.positionType,
      required super.valueChange,
      required this.values,
      super.flex = 1});

  @override
  Widget getWidget() {
    // TODO: implement getWidget
    return DropdownButtonHideUnderline(
        child: DropdownButtonFormField2(
      decoration: InputDecoration(
          //Add isDense true and zero Padding.
          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
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
      onChanged: valueChange,
      dropdownMaxHeight: 200,
      searchController: textEditingController,
      searchInnerWidget: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 4,
          right: 8,
          left: 8,
        ),
        child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            hintText: 'Ricerca...',
            hintStyle: const TextStyle(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      searchMatchFn: (item, searchValue) {
        return (item as DropDownFilterItem)
            .name
            .toLowerCase()
            .contains(searchValue.toLowerCase());
      },
      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          textEditingController.clear();
        }
      },
    ));
  }
}
