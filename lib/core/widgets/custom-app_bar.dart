
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showSearchIcon;
  final bool showMenuIcon;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onMenuPressed;
  final bool showBackButton;

   CustomAppBar({
    required this.title,
    this.showSearchIcon = false,
    this.showMenuIcon = false,
    this.onSearchPressed,
    this.onMenuPressed,
    this.showBackButton = false
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.lightBlue,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      actions: <Widget>[
        if (showSearchIcon)
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: onSearchPressed ?? () {},
          ),
        if (showMenuIcon)
          IconButton(
            icon:const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: onMenuPressed ?? () {},
          ),
      ],
    );
  }
}