import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.leadingIcon,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        leadingIcon ?? Icons.grid_view,
        color: Colors.white70,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white70, fontSize: 18),
      ),
    );
  }
}
