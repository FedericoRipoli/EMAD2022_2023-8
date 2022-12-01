
import 'package:flutter/material.dart';
import 'package:frontend_sws/components/filtri/FilterController.dart';
import 'package:frontend_sws/main.dart';

class FilterBar extends StatefulWidget {
  final List<FilterTextController> controllers;

  const FilterBar({super.key,
    required this.controllers}) :
      assert(controllers.length != 0);

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
                onChanged: widget.controllers[index].runFiltering,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.controllers[index].placeholder,
                )
            )
        )
    );
  }

}