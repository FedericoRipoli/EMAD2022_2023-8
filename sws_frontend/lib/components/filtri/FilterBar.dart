import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_sws/components/filtri/GenericFilter.dart';
import 'package:frontend_sws/main.dart';

import 'DropDownFilter.dart';
import 'TextFilter.dart';

class FilterBar extends StatefulWidget {
  final List<GenericFilter> filters;

  const FilterBar({super.key, required this.filters})
      : assert(filters.length != 0);

  @override
  State<FilterBar> createState() => _FilterBar();
}

class _FilterBar extends State<FilterBar> {
  EdgeInsets defaultPadding=const EdgeInsets.all(8.0);
  @override
  Widget build(BuildContext context) {
    List<Widget> columnChild = [];
    for (GenericFilter filter in widget.filters) {
      Widget w=filter.getWidget();
      Widget toadd = w;
      Widget? lastChild = columnChild.isNotEmpty ? columnChild.last : null;
      if (lastChild == null) {
        columnChild.add(filter.positionType == GenericFilterPositionType.col
            ? Column(
                children: [
                  Padding(padding: defaultPadding, child: toadd)
                ],
              )
            : Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: defaultPadding, child: toadd))
                ],
              ));
      } else {
        if (filter.positionType == GenericFilterPositionType.col &&
                lastChild is Column){
          (lastChild).children.add(Padding(
                  padding: defaultPadding, child: toadd));
        }else if(filter.positionType == GenericFilterPositionType.row &&
                lastChild is Row) {
          (lastChild).children.add(Expanded(
              child: Padding(
                  padding: defaultPadding, child: toadd)));
        } else {
          columnChild.add(filter.positionType == GenericFilterPositionType.col
              ? Column(
                  children: [
                    Padding(padding: defaultPadding, child: toadd)
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: defaultPadding, child: toadd))
                  ],
                ));
        }
      }
    }
    return Container(
        color: appTheme.primaryColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: columnChild,
        ));
  }
}
