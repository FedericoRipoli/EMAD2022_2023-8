import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class CustomDropDownText extends StatelessWidget {
  final List<CustomDropDownItem> values;
  final String name;
  final TextEditingController textEditingController =TextEditingController();
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  CustomDropDownText({
    required this.values,
    required this.name,
    required this.validator,
    required this.onChanged,
    required this.onSaved,

    super.key});



  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child:

        DropdownButtonFormField2(
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
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
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
            return (item as CustomDropDownItem).name.toLowerCase().contains(searchValue.toLowerCase());
          },
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },


        )
    );
  }
}

class CustomDropDownItem  extends DropdownMenuItem<String>{
  final String? id;
  final String name;

  CustomDropDownItem({super.key,
    this.id,
    required this.name,
  }) : super(
    value: id,

    child: Text(name,overflow: TextOverflow.ellipsis),
  );


}