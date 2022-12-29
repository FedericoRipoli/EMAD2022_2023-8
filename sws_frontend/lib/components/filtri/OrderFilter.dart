import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';

import '../../theme/theme.dart';
import 'GenericFilter.dart';

class OrderFilter extends GenericFilter {
  BuildContext context;
  String orderString;
  final Map<String, String> elements;

  OrderFilter(
      {required super.name,
      required super.positionType,
      required super.valueChange,
      super.flex = 1,
      required this.orderString,
      required this.elements,
      required this.context});

  @override
  Widget getWidget() {
    // TODO: implement getWidget
    return IconButton(
      color: AppColors.white,
      icon: const Icon(Icons.sort),
      tooltip: 'Ordina',
      onPressed: () {
        showDialog(
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: OrderFilterDialog(
                valueChange: valueChange,
                defaultValue: orderString.split("=")[1].split(",")[0],
                asc: orderString.split("=")[1].split(",")[1]=="ASC",
                elements: elements,
              ),
            );
          },
          context: context,
        );
      },
    );
  }
}

class OrderFilterDialog extends StatefulWidget {
  final Map<String, String> elements;
  final String? defaultValue;
  final bool asc;
  final Function(String? text) valueChange;

  const OrderFilterDialog(
      {Key? key,
      required this.valueChange,
      required this.elements,
      this.defaultValue,
      this.asc = false})
      : super(key: key);

  @override
  State<OrderFilterDialog> createState() => _OrderFilterDialogState();
}

class _OrderFilterDialogState extends State<OrderFilterDialog> {
  bool asc = false;
  String valueSelected = "";

  @override
  void initState() {
    super.initState();
    valueSelected = widget.defaultValue ?? "";
    asc = widget.asc;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const Text("Ordina i risultati"),
      const SizedBox(
        height: 5,
      ),
      Row(children: [
        TextButton.icon(
            style: asc
                ? TextButton.styleFrom(
                    backgroundColor: AppColors.logoCadmiumOrange)
                : null,
            onPressed: () {
              setState(() {
                asc = true;
              });
            },
            icon: const Icon(Icons.text_rotate_up),
            label: const Text("Ascendente")),
        TextButton.icon(
            style: !asc
                ? TextButton.styleFrom(
                    backgroundColor: AppColors.logoCadmiumOrange)
                : null,
            onPressed: () {
              setState(() {
                asc = false;
              });
            },
            icon: const Icon(Icons.text_rotation_down),
            label: const Text("Discendente"))
      ]),
      const Divider(
        thickness: 2,
      ),
      Column(
        children: widget.elements.entries.map((e) {
          return TextButton(
              style: e.key == valueSelected
                  ? TextButton.styleFrom(
                      backgroundColor: AppColors.logoCadmiumOrange)
                  : null,
              onPressed: () {
                setState(() {
                  valueSelected = e.key;
                });
              },
              child: Text(e.value));
        }).toList(),
      ),
      const Divider(
        thickness: 2,
      ),
      const SizedBox(
        height: 5,
      ),
      CustomButton(
        onPressed: () {
          Navigator.pop(context);
          widget.valueChange(getOrderString());
        },
        textButton: 'Applica',
      )
    ]);
  }
  String getOrderString(){
    return "sort=$valueSelected,${asc?'ASC':'DESC'}";
  }
}
