import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownAree extends StatefulWidget {
  const DropdownAree({Key? key}) : super(key: key);

  @override
  State<DropdownAree> createState() => _DropdownAreeState();
}

class _DropdownAreeState extends State<DropdownAree> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
        iconSize: 14,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        hint: const Text(
          'Seleziona aree di riferimento',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        buttonHeight: 40,
        buttonWidth: 300,
        itemHeight: 40,
      ),
    );
  }
}
