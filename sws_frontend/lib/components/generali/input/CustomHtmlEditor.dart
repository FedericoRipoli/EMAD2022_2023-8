import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CustomHtmlEditor extends StatelessWidget {
  HtmlEditorController controller;
  String? initialText;
  CustomHtmlEditor({
    required this.controller,
    this.initialText,
    super.key});



  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: controller, //required
      htmlEditorOptions: HtmlEditorOptions(
        hint: "Testo...",

        initialText: initialText ?? "",
      ),
      otherOptions: const OtherOptions(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white
        )

      ),
    );
  }
}

