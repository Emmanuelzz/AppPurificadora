import '/flutterflow/flutter_flow_icon_button.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({required this.title, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF001C30),
      automaticallyImplyLeading: false,
      leading: FlutterFlowIconButton(
        borderColor: Colors.transparent,
        borderRadius: 30,
        borderWidth: 1,
        buttonSize: 60,
        icon: const Icon(
          Icons.menu,
          size: 30,
        ),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Align(
        alignment: AlignmentDirectional(1, 0),
        child: Text(title, textAlign: TextAlign.end),
      ),
      actions: [],
      centerTitle: false,
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

