

import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

/// Class [FilterBar]
/// Per aggiungere questa barra di ricerca bisogna
/// inserire i [placeholders] e i [controllers]
/// per inputbox inserite. Entrambe le [List] devono essere
/// di cardinalità uguale a [filterCount].
class FilterBar extends StatefulWidget {
  final List<String?> placeholders;
  final List<TextEditingController> controllers;

  const FilterBar({super.key,
    required this.placeholders,
    required this.controllers}) :
      assert(placeholders.length == controllers.length);

  @override
  State<FilterBar> createState() => _FilterBar();
}

class _FilterBar extends State<FilterBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        color: appTheme.primaryColor,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(widget.controllers.length,
                  (index) => _generateFilter(index)),

        )
    );
  }

  Widget _generateFilter(int index) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                cursorColor: Colors.black,
                controller: widget.controllers[index],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.placeholders[index],
                )
            )
        )
    );
  }

}