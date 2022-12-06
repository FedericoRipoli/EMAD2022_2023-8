import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_sws/components/filtri/GenericFilter.dart';
import 'package:frontend_sws/main.dart';

import 'TextFilter.dart';

class FilterBar extends StatefulWidget {
  final List<GenericFilter> filters;

  const FilterBar({super.key, required this.filters})
      : assert(filters.length != 0);

  @override
  State<FilterBar> createState() => _FilterBar();
}

class _FilterBar extends State<FilterBar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> columnChild = [];
    for (GenericFilter filter in widget.filters) {
      Widget w;
      switch (filter.runtimeType) {
        case TextFilter:
        default:
          w = TextField(
              cursorColor: Colors.black,
              controller: TextEditingController(),
              onChanged:(value) {
                if ((filter as TextFilter).debounce?.isActive ?? false) filter.debounce?.cancel();
                filter.debounce = Timer( Duration(milliseconds: filter.delayMilliSec), () {
                  filter.valueChange(value);
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                fillColor: Colors.white,
                filled: true,
                hintText: filter.name,
              ));
          break;
      }
      Widget toadd=Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:w));
              Widget? lastChild = columnChild.isNotEmpty ? columnChild.last : null;
      if (lastChild == null) {
        columnChild.add(filter.positionType == GenericFilterPositionType.col
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [toadd],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [toadd],
              ));
      } else {
        if ((filter.positionType == GenericFilterPositionType.col &&
                lastChild is Column) ||
            (filter.positionType == GenericFilterPositionType.row &&
                lastChild is Row)) {
          (lastChild as Flex).children.add(toadd);
        } else {
          columnChild.add(filter.positionType == GenericFilterPositionType.col
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [toadd],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [toadd],
                ));
        }
      }
    }
    return Container(
        color: appTheme.primaryColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: columnChild,
        ));
  }
}
