import 'dart:ui';

import 'package:flutter/material.dart';

class ProfilePopup extends StatefulWidget {
  final Widget widgetcontent;
  const ProfilePopup({Key? key, required this.widgetcontent}) : super(key: key);

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
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
