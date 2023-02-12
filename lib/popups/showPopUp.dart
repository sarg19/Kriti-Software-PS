import 'dart:ui';

import 'package:flutter/material.dart';

class ShowPopUp extends StatefulWidget {
  final Widget widgetcontent;
  const ShowPopUp({Key? key, required this.widgetcontent}) : super(key: key);

  @override
  State<ShowPopUp> createState() => _ShowPopUpState();
}

class _ShowPopUpState extends State<ShowPopUp> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        content: widget.widgetcontent,
      ),
    );
  }
}
