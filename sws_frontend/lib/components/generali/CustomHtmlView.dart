import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:frontend_sws/components/generali/CustomAppBar.dart';

import '../../theme/theme.dart';

class CustomHtmlView extends StatefulWidget {
  const CustomHtmlView({Key? key, required this.title, required this.html})
      : super(key: key);
  final String title;
  final String html;

  @override
  State<CustomHtmlView> createState() => _CustomHtmlViewState();
}

class _CustomHtmlViewState extends State<CustomHtmlView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTitle(
          label: widget.title,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Html(
            data: widget.html,
            // Styling with CSS (not real CSS)
            /*style: {
              'h1': Style(color: Colors.red),
              'p': Style(color: Colors.black87, fontSize: FontSize.medium),
              'ul': Style(margin: const EdgeInsets.symmetric(vertical: 20))
            },*/
          ),
        ),
      ),
    );
  }
}
