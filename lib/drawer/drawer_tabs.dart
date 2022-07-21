import 'package:flutter/material.dart';

class DrawerTabs extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  const DrawerTabs(this.icon, this.text, this.controller, this.page, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: _disableTabTile(context),
              ),
              const SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: _disableTabTile(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Esta função deixa a tab das páginas que não estão em uso com aspecto opaco
  Color? _disableTabTile(context) {
    if (controller.page!.round() == page) {
      return Theme.of(context).primaryColor;
    }
    return Colors.grey[700];
  }
}
