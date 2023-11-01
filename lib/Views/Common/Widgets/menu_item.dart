import 'package:flutter/material.dart';
import '/flutterflow/flutter_flow_theme.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onPressed;

  const MenuItemWidget({
    required this.icon,
    required this.title,
    required this.color,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 15, 5, 15),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPressed,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: FlutterFlowTheme.of(context).secondaryBackground,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
                child: Icon(
                  icon,
                  color: Colors.black,
                  size: 100,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: color),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
